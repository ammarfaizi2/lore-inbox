Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSLISBO>; Mon, 9 Dec 2002 13:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbSLISBO>; Mon, 9 Dec 2002 13:01:14 -0500
Received: from intpop.corp.wcom.ca ([205.150.160.74]:1428 "EHLO corp.wcom.ca")
	by vger.kernel.org with ESMTP id <S266020AbSLISBN> convert rfc822-to-8bit;
	Mon, 9 Dec 2002 13:01:13 -0500
Message-ID: <044101c29fae$0a7bb300$9c094d8e@wcom.ca>
From: "Serge Kuznetsov" <serge@wcom.ca>
To: "Anton Blanchard" <anton@samba.org>, <linux-kernel@vger.kernel.org>
References: <20021208124444.GA18751@krispykreme>
Subject: Re: 2.5.50 + e100 benchmarking
Date: Mon, 9 Dec 2002 13:08:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> e100_intr was the worst function in a profile. PCI reads are very costly

I profiled this part and I found what the main issue is the e100_alloc_skbs.
It takes from 10000 to ~19000 processor's tacts.
At the same time eepro100's speedo_iterrupt is pretty fast.

All the Best!
Serge.
