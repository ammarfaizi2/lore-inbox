Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJ2UAB>; Tue, 29 Oct 2002 15:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbSJ2UAB>; Tue, 29 Oct 2002 15:00:01 -0500
Received: from zok.SGI.COM ([204.94.215.101]:40349 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262296AbSJ2UAA>;
	Tue, 29 Oct 2002 15:00:00 -0500
Message-ID: <015e01c27f86$a42d4290$9865fea9@PCJohn>
From: "John Hawkes" <hawkes@sgi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <wookie@osdlab.org>
References: <fa.e2emdkv.j1ksaf@ifi.uio.no> <fa.f6uq3iv.232305@ifi.uio.no>
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Date: Tue, 29 Oct 2002 12:06:16 -0800
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

From: "Jakob Oestergaard" <jakob@unthought.net>
...[snip]...
> The correct way to terminate that loop is, like was already suggested,
> doing a comparison to see if the residual is "numerically zero" or
> "sufficiently zero-ish for the given purpose". Eg.  "delta < 1E-12" or
> eventually "fabs(delta) < 1E-12".

Tim Witham at the OSDL told me that he ran some experiments with
different convergent deltas:

  zero Rate (ops/sec) Iteration Rate
 10-6    331,300    1656.5
 10-8    315,049    1575.0
 10-10    302,000    1510.0
 10-12    292,300    1461.5
 10-14    285,400    1427.0

Anything smaller than 10-14 didn't converge.


--
John Hawkes


