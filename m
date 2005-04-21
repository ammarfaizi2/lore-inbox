Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVDUS6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVDUS6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVDUS6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:58:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6799 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261779AbVDUS6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:58:21 -0400
Date: Thu, 21 Apr 2005 20:57:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andreas Steinmetz <ast@domdv.de>
Cc: pavel@ucw.cz, rjw@sisk.pl,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
Message-ID: <20050421185717.GB475@openzaurus.ucw.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <4267DC2E.9030102@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267DC2E.9030102@domdv.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> there's some problems with swsusp in 2.6.12-rc3 (x86_64):

Are they new or were they in -rc2, too?

> 1. Is it necessary to print the following message during regular boot?
>    swsusp: Suspend partition has wrong signature?
>    It is a bit annoying and I believe it will confuse some swsusp
>    users.

Hmm, feel free to provide a patch. (I need something to try git on :-).

> 2. PCMCIA related hangs during swsusp.
>    swsusp hangs after freeing memory when either cardmgr is running
>    or pcmcia cards are *physically* inserted. It is insufficient
>    to do a 'cardctl eject' the cards must be removed, too, for
>    swsusp not to hang. I do suspect some problem with the
>    'pccardd' kernel threads.

Did it work with any older kernel? Which driver is it? yenta?

> 3. Sometimes during the search for the suspend hang reason the system
>    went during suspend into a lightshow of:
>    eth0: Too much work at interrupt!
>    and some line that ends in:
>    release_console_sem+0x13d/0x1c0)
>    The start of the line is not readable as it just flickers by in
>    the eth0 message limbo. NIC is a built in RTL-8169 Gigabit Ethernet
>    (rev 10). Oh, no chance for a serial console capture as there's no
>    built in serial device in this laptop.

How repeatable is that? Will NIC work okay if you rmmod/insmod its driver?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

