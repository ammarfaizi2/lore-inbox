Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263125AbTDBTKe>; Wed, 2 Apr 2003 14:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263126AbTDBTKe>; Wed, 2 Apr 2003 14:10:34 -0500
Received: from smtp1.cavium.com ([209.113.159.133]:8945 "EHLO smtp1.cavium.com")
	by vger.kernel.org with ESMTP id <S263125AbTDBTKd>;
	Wed, 2 Apr 2003 14:10:33 -0500
From: "Adam Khan" <adam.khan@cavium.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Adam Khan'" <adam.khan@cavium.com>, <kodol2000@hanmir.com>
Subject: Memory allocation differences between 2.4.18 and 2.5.52
Date: Wed, 2 Apr 2003 11:21:47 -0800
Message-ID: <000b01c2f94d$1be53780$7710a8c0@D6XKZR11>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-OriginalArrivalTime: 02 Apr 2003 19:21:54.0595 (UTC) FILETIME=[1EE57F30:01C2F94D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that the kmalloc() function on 2.4.18 provides memory
allocation blocks on 8-byte boundaries. 2.5.52 provides memory
allocation blocks on 4-byte boundaries.

We have run into an issue with a device driver developed for 2.4.18 and
ported to 2.5.52. The driver requires buffers that are allocated on
8-byte boundaries. 
Can anyone explain why this difference in buffer boundaries exists?
Any suggestions to ensure that the buffer allocation is 8-byte bounded?
Can we write a my_kmalloc() function that would always return an 8-byte
bounded buffer. 

Thanks in advance,
Adam 
 



