Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTJOEMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTJOEMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:12:38 -0400
Received: from mx1.blkhawk.net ([12.148.201.5]:29300 "EHLO mx1.blkhawk.net")
	by vger.kernel.org with ESMTP id S262344AbTJOEMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:12:36 -0400
Subject: 2.6.0-test7 athlon smp network devices not found
From: "Jason L. Nesheim" <jason@bhawk.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Blackhawk Internet Communications Inc.
Message-Id: <1066191155.30643.16.camel@st-wrkstn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 14 Oct 2003 23:12:35 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2003 04:12:35.0347 (UTC) FILETIME=[9003EE30:01C392D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have an issue, maybe a bug, with test7 on athlon smp.

The kernel is compiled for athlon with smp and acpi (acpi makes no
difference though) and I am receiving strange errors with several
network utils.

ifconfig returns this with I execute 'ifconfig':

: error fetching interface information: Device not found

yet, if I run 'ifconfig eth1' or with any other interface as the
argument I get:

eth1      Link encap:Ethernet  HWaddr 00:04:75:B1:A4:47
          inet addr:12.148.210.98  Bcast:12.255.255.255 
Mask:255.255.255.224
          inet6 addr: fe80::204:75ff:feb1:a447/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10117 errors:0 dropped:0 overruns:0 frame:0
          TX packets:10592 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:5714965 (5.4 MiB)  TX bytes:1151861 (1.0 MiB)
          Interrupt:19 Base address:0x2000

which is the correct output.  If I configure the ip manually with
ifconfig for the device, and set routes with 'ip', the card works fine.
Also, dhclient and other programs give me similar errors.

output of dhclient:

Internet Software Consortium DHCP Client 2.0pl5
Copyright 1995, 1996, 1997, 1998, 1999 The Internet Software Consortium.
All rights reserved.
 
Please contribute if you find this software useful.
For info, please visit http://www.isc.org/dhcp-contrib.html
 
Can't get interface flags for : No such device
exiting.

Adding the interface as an argument makes no difference here.

Anyone have ideas what is going on?

Jason L. Nesheim

