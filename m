Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJZAGx>; Fri, 25 Oct 2002 20:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261718AbSJZAGx>; Fri, 25 Oct 2002 20:06:53 -0400
Received: from zok.SGI.COM ([204.94.215.101]:44942 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261715AbSJZAGw>;
	Fri, 25 Oct 2002 20:06:52 -0400
Message-ID: <037101c27c84$70015ce0$9865fea9@PCJohn>
From: "John Hawkes" <hawkes@sgi.com>
To: <linux-kernel@vger.kernel.org>
References: <fa.d95885v.1d14t8c@ifi.uio.no>
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Date: Fri, 25 Oct 2002 17:12:56 -0700
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

From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
>     39 new_raph       Unable to solve equation in 100 tries. P =
1.5708, P0
> = 1.5708, delta = 6.12574e-17
> new_raph: Success
>  *** Failed to execute new_raph  ***

The AIM7/AIM9 new_raph is broken code.  The convergence loop termination
conditional looks something like:
   if (delta == 0) break;
for a type "double" delta.  You ought to change that to be something
like:
   if (delta <= 0.00000001L) break;

--
John Hawkes

