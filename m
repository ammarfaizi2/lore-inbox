Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319173AbSHNBz3>; Tue, 13 Aug 2002 21:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319180AbSHNBz3>; Tue, 13 Aug 2002 21:55:29 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:50159 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S319173AbSHNBz2>; Tue, 13 Aug 2002 21:55:28 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cache coherency and snooping
Date: Tue, 13 Aug 2002 18:56:38 -0700
Message-ID: <0aa601c24335$d4c6a0f0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.44L.0208132237390.23404-100000@imladris.surriel.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking at the linux kernel code. The driver in /drivers/char/agp uses
this same seqeuence to allocate non-cacheable memory page ( look at the
function static int agp_generic_create_gatt_table(void)).

I will give it a try on my mips based platform and let you guys know the
outcome.

Thanks to everyone for all the responses and guidance.
Imran.



-----Original Message-----
From: Rik van Riel [mailto:riel@conectiva.com.br]
Sent: Tuesday, August 13, 2002 6:38 PM
To: Imran Badr
Cc: 'Ralf Baechle'; 'Alan Cox'; linux-kernel@vger.kernel.org
Subject: RE: Cache coherency and snooping


On Tue, 13 Aug 2002, Imran Badr wrote:

> Please advise if following sequence of operations are going to help:
>
> alloc memory
> reserve the page
> flush every cache
> call ioremap_nocache

Won't work around hardware limitations.  If the hardware
cannot turn off caching, all you could do is flush the
page to ram before every explicit IO request...

regards,

Rik
--
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


