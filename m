Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUIUUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUIUUaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUIUUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:30:52 -0400
Received: from [132.68.238.35] ([132.68.238.35]:60047 "EHLO
	mailgw3.technion.ac.il") by vger.kernel.org with ESMTP
	id S268039AbUIUUau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:30:50 -0400
Date: Tue, 21 Sep 2004 23:23:15 +0300 (IDT)
From: Alon Altman <alon@8ln.org>
X-X-Sender: alon@alon1.dhs.org
To: linux-kernel@vger.kernel.org
Subject: ICH5 SATA problem loading ide-cd module
Message-ID: <Pine.LNX.4.61.0409212317570.2932@alon1.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc me to any replies, as I'm not subscribed to LKML.

Hello,
   I've just installed the Debian package of the 2.6.8 kernel
(2.6.8-1-686-smp) on my machine with an ASUS board with an ICH5 chipset and
a SATA HDD in enhanced mode.

   The system loads correctly, identifying the SATA drive as /dev/sda, up
until I load the ide-cd module. The ide-cd module correctly detects the DVD
Writer as /dev/hdb, and immediately generates the following error:

APIC error on CPU0: 60(60) [this is repeated several times]

   Then, I get a message "irq 185: nobody cared", which lists the folowing
handlers:

f884af00 ata_interrupt
f88aeea0 ide_intr

   After this error, all attempts to access the SATA drive time out, and I
have to resort to a cold reboot.

   I heard ICH5 SATA should work on 2.6.8, so is there something simple I'm
missing here?

Thanks,
   Alon

-- 
This message was sent by Alon Altman (alon@alon.wox.org) ICQ:1366540
GPG public key at http://8ln.org/pubkey.txt
Key fingerprint = A670 6C81 19D3 3773 3627  DE14 B44A 50A3 FE06 7F24
--------------------------------------------------------------------------
  -=[ Random Fortune ]=-
A stitch in time saves nine.
