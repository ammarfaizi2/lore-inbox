Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSLKJNs>; Wed, 11 Dec 2002 04:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSLKJNs>; Wed, 11 Dec 2002 04:13:48 -0500
Received: from pD9552139.dip.t-dialin.net ([217.85.33.57]:16347 "EHLO xpc823")
	by vger.kernel.org with ESMTP id <S267081AbSLKJNp>;
	Wed, 11 Dec 2002 04:13:45 -0500
Message-ID: <079901c2a0f6$fdcc0340$4b00000a@elite>
From: "Felix Domke" <tmbinc@elitedvb.net>
To: <linux-kernel@vger.kernel.org>
Subject: Allocating 16MB aligned phsyical memory
Date: Wed, 11 Dec 2002 10:23:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm almost a newbie to kernel hacking, and i'm currently writing a driver
for some powerpc-based chipset by IBM (STBxxxx), using the
2.4.xx-linuxppc_devel kernel.

Some On-Chip-Devices require a very strict alignment of memory. For example,
one function (mpeg2 transport demuxer) require that all (32) queues (each of
them about 32kb) reside in one 16MB region, each of them not crossing 1MB
boundary.

At the moment, i'm reserving a 16MB space of ram for which i made an own
allocater. needless to say that this sucks. So now i'm searching for a way
to allocate physical-mapped, contiguous, aligned (at 2^24 bytes) memory. I
already tried to understand __get_free_pages, map_page and the
powerpc-specific "consistent_alloc", but i couldn't think of enforcing the
alignments. I don't want to allocate 16MB more memory just for the
alignment.

I know that allocating 16MB-aligned memory isn't nice. But the other choice
is to completely reserve 16MB of RAM, which isn't nice either, since i only
need ~2MB of them.

Can anybody give me a hint how to do this?

felix domke

