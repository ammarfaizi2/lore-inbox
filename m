Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268411AbUJJSRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268411AbUJJSRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 14:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268413AbUJJSRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 14:17:08 -0400
Received: from main.gmane.org ([80.91.229.2]:20366 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268411AbUJJSRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 14:17:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Date: Mon, 11 Oct 2004 03:17:09 +0900
Message-ID: <m2zn2uigka.fsf@tnuctip.rychter.com>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it>
	<2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it>
	<E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.4 (Security Through
	Obscurity, linux)
Cancel-Lock: sha1:pQvYGEba/7R5oMbTElHGQOnpGsI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:
 Pavel> Hi!
 > The problem isn't really that you're out of memory. Rather, the
 > memory is so fragmented that swsusp is unable to get an order 8
 > allocation in which to store its metadata. There isn't really
 > anything you can do to avoid this issue apart from eating memory
 > (which swsusp is doing anyway).
 >>
 >> That's one megabyte, right? Can't we preallocate that on boot, while
 >> there's still chance to get that much contiguous memory? If the user
 >> has swsusp compiled into his kernel, he probably wants it to
 >> function, so it's not really "wasted".

 Pavel> You do not know how much you should preallocate, because it
 Pavel> depends on ammount of memory used. You could preallocate maximum
 Pavel> possible ammount...

 Pavel> OTOH this is first report of this failure. If it fails once in a
 Pavel> blue moon, it is probably better to let it fail than waste
 Pavel> memory.

This is *exactly* why I choose to use swsusp2. There is a marked
difference in the maintainer's approach to these kinds of problems.

The net result is that swsusp2 has worked for me very well for many
months now: I have been suspending and resuming happily for several
months, with exactly 0 swsusp-caused crashes or failures.

BTW, on a related note, I believe there is too much acceptance for
crashes and failures in the Linux world recently. Take an example: I can
bring down any of my machines (kernels 2.4 or 2.6) in less than 10
minutes just by plugging in and unplugging USB devices. There is
something fundamentally wrong with the USB subsystem if it is possible
to do that.

--J.

