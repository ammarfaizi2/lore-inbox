Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSLKGJM>; Wed, 11 Dec 2002 01:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSLKGJM>; Wed, 11 Dec 2002 01:09:12 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:37712 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id <S266560AbSLKGJL>; Wed, 11 Dec 2002 01:09:11 -0500
From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
To: "'Arjan van de Ven'" <arjanv@redhat.com>, <imran.badr@cavium.com>
Cc: "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: vmalloc
Date: Wed, 11 Dec 2002 00:16:54 -0600
Message-ID: <000c01c2a0dc$e866dda0$972a3a41@joe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <1039554761.10002.31.camel@laptop.fenrus.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is there any limitation on the amount of
>> memory that can be allocated by using vmalloc
>> ( like 128KB for kmalloc) ?

> for x86 you shouldn't count on being to get more
> than 64Mb of vmalloc memory (even though most
> machines go upto 128Mb at least)

According to the specifications, vmalloc is limited only by the amount of
physical memory on your machine.  However, Arjan VanDeVen has a point.
Other process are already using physical memory (like the kernel process),
and those process count against the physical memory available.

TIP: It's always nice to leave at least 20% of the physical memory free for
other critical processes, especially those that can't be swapped out.

Joseph Wagner

