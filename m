Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272462AbTGaL4d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272997AbTGaL4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:56:33 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:42231 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272462AbTGaL4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:56:32 -0400
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731113838.GU1873@lug-owl.de>
References: <20030730135623.GA1873@lug-owl.de>
	 <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
	 <20030730184529.GE21734@fs.tum.de>
	 <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
	 <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de>
	 <20030731062252.GM1873@lug-owl.de>
	 <20030731071719.GA26249@alpha.home.local>
	 <20030731113838.GU1873@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059652268.16608.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 12:51:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> Thanks for that. In the meantime, I've started to give a try to the
> userspace version (using a LD_PRELOAD lib). My current Problem:
> 
> amtus:~/sigill_catcher# LD_PRELOAD=./libsigill.so ls
> sigill.c:_init():69: sigill started, sigaction() = 0
> build.sh  intercept.h  libsigill.so  run.sh  sigill.c  sigill.o
> amtus:~/sigill_catcher# LD_PRELOAD=./libsigill.so apt-get update
> Illegal instruction
> 
> See? It's loaded at the "ls" call, but it seems to be not loaded for
> apt-get.

Remember you need to overload signal setting functions like sigaction.
My guess is apt decided to disable your signal and you didnt stop it

