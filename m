Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVGYW3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGYW3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVGYW3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:29:45 -0400
Received: from totor.bouissou.net ([82.67.27.165]:28121 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261246AbVGYW3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:29:44 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Tue, 26 Jul 2005 00:29:41 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507251635510.8043-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507251635510.8043-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507260029.41709@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Juillet 2005 22:44, Alan Stern a écrit :
>
> Now that's strange.  When you plug the high-speed device into the
> integrated ports, which IRQ counter changes?  Since nothing is using IRQ
> 21, it should be disabled and its counter should remain constant.  Does
> this mean the interrupts show up on IRQ 19 (used by ehci-hcd), or do they
> not show up at all (i.e., is the USB connection just being polled)?

I assume it's IRQ 19.

cat /proc/interrupts doesn't show IRQ21 at all when uhci isn't loaded.

IRQ 19 being shared with 4 IDE controllers that controls my hard drives, 
that's hard to isolate interrupts counts due to USB activity from interrupts 
counts due to disks activity...

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
