Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272310AbTG3XPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272319AbTG3XPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:15:53 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:4087 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272310AbTG3XPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:15:51 -0400
Subject: Re: TSCs are a no-no on i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030730215032.GA18892@vana.vc.cvut.cz>
References: <20030730135623.GA1873@lug-owl.de>
	 <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com>
	 <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de>
	 <20030730215032.GA18892@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059606394.10505.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Jul 2003 00:10:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 22:50, Petr Vandrovec wrote:
> There is no such instruction. Skip LOCK prefix and decode again,
> you'll get either cmpxchg or xadd (or cmpxchg8b, but then it does
> not work on i486 too).

And if the byte you are looking at was patched by another thread you've
blown it. Your emulation can only be so good 8) People do stuff like
patching instructions under software decode as a robustness check - its
normally pretty amusing



