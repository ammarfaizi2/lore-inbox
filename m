Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318933AbSG1HzG>; Sun, 28 Jul 2002 03:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318937AbSG1HzG>; Sun, 28 Jul 2002 03:55:06 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:56272 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318933AbSG1HzD>; Sun, 28 Jul 2002 03:55:03 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
Date: Sun, 28 Jul 2002 00:59:13 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECIEADDAAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20020728065830.GT1465@niksula.cs.hut.fi>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sat, Jul 27, 2002 at 03:39:41PM -0700, you [Buddy Lumpkin] wrote:
>>
>> Why would you want to push *anything* to swap until you have to?

>If you have idle io time in your hands, you can choose to back up some
dirty
>anonymous pages to the swap device. This way, when pages really needs to
get
>freed, you can just drop the pages (just like you would drop clean file
>backed pages.) This obviously eliminates a great latency (somebody said
>something about a "swap storm"), because the write happened beforehand.

>There's nothing wrong with the swap being in use (and the pages may still
be
>in memory). If you have swap, it makes sense to use it. What doesn't make
>sense is to waste time waiting for paging to happen.

In Solaris you don't even need to define a swap device at all.
If your sure that you will never reach lotsfree (for that matter, nothing
stops you from setting lotsfree, desfree and minfree to whatever value you
want) Solaris will happily run without a swap device even defined.

Once you reach the lotsfree watermark it's a whole different story, then it
makes perfect sense to queue up writes to the swap device and write
them out to swap in a sensible way as you point out above, but when I made
the comment above, I was referring to a system that is not low on memory.

Regards,

--Buddy



