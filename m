Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261207AbSJHPNm>; Tue, 8 Oct 2002 11:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSJHPNm>; Tue, 8 Oct 2002 11:13:42 -0400
Received: from michael.checkpoint.com ([199.203.73.68]:64966 "EHLO
	michael.checkpoint.com") by vger.kernel.org with ESMTP
	id <S261207AbSJHPNl>; Tue, 8 Oct 2002 11:13:41 -0400
From: "Ofer Raz" <oraz@checkpoint.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: 2.4.9/2.4.18 max kernel allocation size
Date: Tue, 8 Oct 2002 17:19:12 +0200
Message-ID: <027801c26ede$0f37deb0$8b705a3e@checkpoint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Ofer Raz [mailto:oraz@checkpoint.com]
Sent: Tuesday, October 08, 2002 2:19 PM
To: 'linux-kernel-owner@vger.kernel.org'
Subject: 2.4.9/2.4.18 max kernel allocation size


I'm trying to obtain the largest kernel allocation possible using vmalloc.

I have tested both Linux 2.4.9-7 and 2.4.18-10 max kernel allocation using
vmalloc on Intel platform with different physical memory configurations.
>From my experience, playing with the Virtual/Physical memory split issues
different results (which makes sense)

Following are the results on 2.4.9-7 when the 4GB highmem config option is
set:

Config Option	Physical Memory	Max Allocation
CONFIG_1GB		512MB			400
			1024MB		900
			1536MB		1400
			2048MB		981

CONFIG_2GB		512MB			400
			1024MB		900
			1536MB		461
			2048MB		VFS Panic on boot

CONFIG_3GB		512MB			400
			1024MB		85
			1536MB		VFS Panic on boot
			2048MB		VFS Panic on boot

Please note that CONFIG_3GB is the default and results 85MB max allocation
for 1GB machine.

For my surprise, I have discovered that the CONFIG_1GB/CONFIG_2GB/CONFIG_3GB
configuration options were removed from 2.4.18-10, it seems that the kernel
is set for the CONFIG_3GB option (by looking at the PAGE_OFFSET mask
(0xc0000000)).

Any idea how can I make the kernel allocation on 2.4.18-10 larger than 85MB
on 1GB machine?

Cheers,
	Ofer

