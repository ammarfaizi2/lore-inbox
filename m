Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbUCWWxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 17:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbUCWWxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 17:53:36 -0500
Received: from e35.marxmeier.com ([194.64.71.4]:61960 "EHLO e35.marxmeier.com")
	by vger.kernel.org with ESMTP id S262909AbUCWWxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 17:53:35 -0500
Message-ID: <4060BFEC.C77CB682@marxmeier.com>
Date: Tue, 23 Mar 2004 23:53:32 +0100
From: Michael Marxmeier <mike@marxmeier.com>
Organization: Marxmeier Software AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ENE CB1410 Cardbus bridge, yenta and ISA IRQ mask
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.21 (+SuSE patches)

My new laptop uses an ENE CB1410 cardbus bridge.

I found that my pcmcia ISDN card (AVM A1 PCMCIA) does not work 
correctly because yenta does not seem to recognize any ISA interrupts 
for me and consequently the hisax driver refuses to load.

Mar  9 20:29:38 linux kernel: Yenta IRQ list 0000, PCI irq5
Mar  9 20:29:38 linux kernel: Socket status: 30000006

The driver in Win XP in this case assigned IRQ 3. By adding a faked
ISA irq mask to yenta.c i was able to get the card working.

Could this be a problem that the ENE CB1410 needs some fixup during 
initialization to recognize the ISA IRQs or should i simply change 
the irq_mask in yenta.c?

I found a datasheet of the ENE CB1410 on the Internet:
http://ftp.cizgi.com.tr/turknote/CT10/CT10%20Service%20Manual/EnE%20Cardbus%20Controller%20Datasheet.pdf

Would anybody with some more depth in this area feel inclined to 
look into this? I'm happy to test any changes.


Thanks
Michael
