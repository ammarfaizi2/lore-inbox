Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUDJVCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 17:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDJVCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 17:02:54 -0400
Received: from hermes.domdv.de ([193.102.202.1]:23557 "EHLO zeus.lan.domdv.de")
	by vger.kernel.org with ESMTP id S262112AbUDJVCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 17:02:52 -0400
Message-ID: <407860F9.2070103@domdv.de>
Date: Sat, 10 Apr 2004 23:02:49 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040311
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kkeil@suse.de, paulus@samba.org
Subject: 2.4.25: kfree_skb on hard IRQ during ISDN dialin
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im getting this kernel warning during ISDN dialins:

Apr 10 22:24:28 titanic pppd[895]: local  IP address 10.1.1.7
Apr 10 22:24:28 titanic pppd[895]: remote IP address 10.1.1.8
Apr 10 22:25:31 titanic kernel: Warning: kfree_skb on hard IRQ c022d0a0
Apr 10 22:25:34 titanic last message repeated 2 times
Apr 10 22:26:20 titanic pppd[895]: Modem hangup
Apr 10 22:26:20 titanic pppd[895]: Connection terminated.

The client of the dialin is a Nokia 6820. It doesn't seem that this 
warning causes any real trouble as the system otherwise continues to 
work normally. I don't know if this warning is ISDN or PPP related.

System:

Tyan Tomcat K8S (S2850) with Opteron 144 runing in 32 bit mode

Linux titanic 2.4.25 #2 Sun Mar 21 15:31:33 CET 2004 i686 unknown

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
01:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
01:06.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)
01:07.0 Network controller: AVM Audiovisuelles MKTG & Computer System 
GmbH Fritz!PCI v2.0 ISDN (rev 02)
01:08.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 11)
01:0b.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
01:0d.0 Ethernet controller: Broadcom Corporation: Unknown device 1653 
(rev 03)
01:0e.0 Ethernet controller: Broadcom Corporation: Unknown device 1653 
(rev 03)
02:08.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46)
02:09.0 USB Controller: NEC Corporation USB (rev 41)
02:09.1 USB Controller: NEC Corporation USB (rev 41)
02:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
