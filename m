Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbTLDJJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLDJJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:09:38 -0500
Received: from mail.netzentry.com ([157.22.10.66]:25096 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S262580AbTLDJJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:09:36 -0500
Message-ID: <3FCEF9B7.5070301@netzentry.com>
Date: Thu, 04 Dec 2003 01:09:11 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: the3dfxdude@hotmail.com, prakashpublic@gmx.de
CC: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash Cheemplavam wrote
 >>>Thanks everyone for your continued interest in this, I'll
 >>>try and test the no-onboard-PATA + UP LAPIC and IOAPIC and
 >>>add-in-card-PATA with no onboard PATA + + UP LAPIC and IOAPIC
 >>>when I get a spare moment which is rare.
 >
 >I don't think that the AMD IDE is the problem. I have compiled
 >it in, as
 >well, but I am using the onboard SATA. Since this can be
 >considered as  >an pci-card (the chip is connected to the pci
 > bridge) I think ölocking occurs on high traffic on PCI bus.
 > Like now I get over 60mb/s with my >HD. Formerly I got only
 > 25mb/s. before I could do some rounds of hdparm -t, before it
 > locks. Now it locks immediately when doing hdparm -t
 > when  APIC is enabled.
 >
 >SO, I think it is not IDE specific. Does anybody have gigabit
 > network card? Maybe that we should try to push something big
 > through it (without reading from hd). If that leads to lock
 > up we have a semi proof that it is due to high traffic on
 > pci-bus.

I was thinking that myself (PCI activity triggering this).
The first time I hit this problem was with a card with two
ACENics/tigon2 (acenic.o) sniffing traffic at high rates
(100,000pps+) with most file i/o going over NFS on the
integrated 3com interface.

I ran for three days 200,000+pps sniffing with tethereal on
windows2000 on both acenics and never a lockup.

The AMD-Nvidia PATA does seem to be a very common in this
problem, but everyone at least has a CD-ROM and most
have a PATA hard disk so its going to be there every time
a problems crops up. I think we need to prove that an
solid add-in PCI PATA card that takes the CD and the
and the PATA disk and shut off the onboard ATA and torture
test again. I havent had time to yet.




