Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWILVjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWILVjY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWILVjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:39:24 -0400
Received: from buick.jordet.net ([193.91.240.190]:11676 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1751426AbWILVjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:39:23 -0400
Subject: Re: [PATCH V3] VIA IRQ quirk behaviour change
From: Stian Jordet <liste@jordet.net>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Drake <dsd@gentoo.org>,
       akpm@osdl.org, torvalds@osdl.org, jeff@garzik.org, greg@kroah.com,
       cw@f00f.org, bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       harmon@ksu.edu, len.brown@intel.com, vsu@altlinux.ru
In-Reply-To: <1158064640.13591.5.camel@localhost.localdomain>
References: <20060907223313.1770B7B40A0@zog.reactivated.net>
	 <1157811641.6877.5.camel@localhost.localdomain>
	 <4502D35E.8020802@gentoo.org>
	 <1157817836.6877.52.camel@localhost.localdomain>
	 <45033370.8040005@gentoo.org>
	 <1157848272.6877.108.camel@localhost.localdomain>
	 <450436F1.8070203@gentoo.org>
	 <1157906395.23085.18.camel@localhost.localdomain>
	 <4504621E.5090202@gentoo.org>
	 <1157917308.23085.26.camel@localhost.localdomain>
	 <1157916102.21295.9.camel@localhost.localdomain>
	 <1157988809.13889.5.camel@localhost.localdomain>
	 <1158005769.4748.0.camel@localhost.localdomain>
	 <1158009834.3434.4.camel@localhost.portugal>
	 <1158010698.23135.1.camel@localhost.localdomain>
	 <1158064640.13591.5.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 23:38:35 +0200
Message-Id: <1158097115.8436.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tir, 2006-09-12 at 13:37 +0100, Sergio Monteiro Basto wrote:
> Ok, as a quick answer, you have a very primitive VIA SMP board, which
> make me remember my old laptop. 
> I maintain what a had write in previous emails about this system. 
> Seeing the configuration of irqs on windows, USB are in 9, so could be a
> clue.
> If I had your board, I'll try not quirk USB (cause quirk put USB in 11)
> and make USB interrupts work as IO-APIC-edge.
> 9:       nnnn       nnnn   IO-APIC-edge  uhci_hcd:usb1, uhci_hcd:usb2,
> uhci_hcd:usb3

The point is, that even when I do not quirk (just insert return at the
top of the quirk-function), usb still uses irq 11 (as I wrote here:
http://lkml.org/lkml/2006/9/6/49 ), but won't work. And acpi (on
interrupt 9) gets an interrupt storm, and gets disabled.

But if I somehow got usb using irq 9, all my problems might vanish...

-Stian

