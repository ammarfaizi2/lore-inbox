Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUHSPqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUHSPqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUHSPqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:46:36 -0400
Received: from the-village.bc.nu ([81.2.110.252]:1412 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266560AbUHSPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:46:01 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4124BA10.6060602@bio.ifi.lmu.de>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
	 <4124BA10.6060602@bio.ifi.lmu.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092925942.28353.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 19 Aug 2004 15:32:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-19 at 15:32, Frank Steiner wrote:
> What a stupid claim. When I call cdrecord on SuSE 9.1, I can burn CDs and
> DVDs as normal user, without root permissions, without suid, without ide-scsi,
> using /dev/hdc as device.
> 
> And this just works fine. So where's the problem?

You can also erase the drive firmware as a user etc. That's the problem.
When you fix that cdrecord gets broken by the security fix if you are
using the SG_IO interface. Patches are kicking around to try and sort
things out so cd burning is safe as non-root. cdrecord works as root.

As a security fix it was sufficiently important that it had to be done.

Alan

