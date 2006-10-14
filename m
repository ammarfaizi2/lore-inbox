Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752007AbWJMX6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbWJMX6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJMX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:58:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53661 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1752007AbWJMX6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:58:20 -0400
Subject: Re: USB performance bug since kernel 2.6.13 (CRITICAL???)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Open Source <opensource3141@yahoo.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20061013233024.5786.qmail@web58107.mail.re3.yahoo.com>
References: <20061013233024.5786.qmail@web58107.mail.re3.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 14 Oct 2006 01:24:52 +0100
Message-Id: <1160785492.25218.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 16:30 -0700, ysgrifennodd Open Source:
> There is an ioctl that is waiting for the URB to be reaped.
> I am almost certain it is this syscall that is taking 4 ms (as
> opposed to 1 ms with CONFIG_HZ=1000).

What does strace say about it ? This is measurable not speculation.

> Will the first piece of code wake up immediately or only after the
> next HZ timeslice?  If it is the latter, which is what I am starting to

It depends if there are other things running and on their priority
relative to you.


