Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTA3F1M>; Thu, 30 Jan 2003 00:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTA3F1M>; Thu, 30 Jan 2003 00:27:12 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45748 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S267411AbTA3F1L>; Thu, 30 Jan 2003 00:27:11 -0500
Message-ID: <008401c2c821$8af20cf0$c1a5190a@png.flab.fujitsu.co.jp>
From: "Takeshi Kodama" <kodama@flab.fujitsu.co.jp>
To: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Why doesn't kernel store ICMP redirect in the routing tables?
Date: Thu, 30 Jan 2003 14:36:30 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I run kernel-2.4.18. 
When kernel receives ICMP redirect message, only store ICMP redirect in the route cache,
not in the routeing tables.
I have a question.

Why doesn't kernel store ICMP redirect in the routing tables?

In kernel-2.4.18, when new route is added(or existed route is deleted)
and route become old, kernel flushs the route cache.
If kernel doesn't store ICMP redirect in the routing tables,
kernel will send packet to wrong gateway whenever flush the route cache.

Is it no matter that it generates ICMP redirect every time flush the route cache?  

Please tell me why kernel has such a specification that doesn't store ICMP redirect
in the routing tables.

Regards.
-----
Takeshi Kodama
