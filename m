Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTKQIGW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 03:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTKQIGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 03:06:22 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:32732 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S263203AbTKQIGV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 03:06:21 -0500
Message-ID: <32926358.1069056306140.JavaMail.ngmail@webmail06.arcor-online.net>
Date: Mon, 17 Nov 2003 09:05:06 +0100 (CET)
From: thomas.mey3r@arcor.de
To: linux-kernel@vger.kernel.org
Subject: TI PC1410 PC Cardbus hardlocks
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: : 193.150.166.43, 193.150.166.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this happens on 2.4.22 and 2.6.0-test9-bk20.
I only did investigate this error on 2.6.0-test9-bk20. System is really hard locked. nmi oopser doesn´t help. yenta_socket driver is compiled as modul. after loading the driver the system hard locks after an undefined period of time (between few secounds and 10 minutes - this is strange!) 

i enabled debug info in yenta_socket driver. i had a quick look at the init sequence that is done to config space and cb_registers. looks ok, but i will have a closer look at this, spec is available. 
I already did some basic testings, so for example the last entry written to syslog has got a to differnet time compared with time system crashes.
i disabled the register_socket call (in probe), so i only got the init seqeunce -> still crashes.
i did a printk(" i am in this function") in various places, so in the interrupt handler. -> still no entries in syslog.

Next thing I want to known: Does this driver work for someone? It is this device:

"CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1410, TI1250),"

This happens on an acer laptop.

with kind regards
Thomas Meyer







