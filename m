Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266287AbTGJHAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 03:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269016AbTGJHAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 03:00:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25241 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266287AbTGJG60 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 02:58:26 -0400
Date: Thu, 10 Jul 2003 00:13:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Diego Calleja =?ISO-8859-1?B?R2FyY+1h?= <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: benchmark: 2.5 io test regression?
Message-Id: <20030710001328.562c2692.akpm@osdl.org>
In-Reply-To: <20030710013600.1483e80a.diegocg@teleline.es>
References: <20030710013600.1483e80a.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García <diegocg@teleline.es> wrote:
>
> Hi. I just went to my 2.5 kernel source tree and i did
> 
>  #time grep foo * -r
> 
>  in both 2.4 & 2.5

Me too.

ext2.  2.5 kernels had HZ=100, so we can meaningfully compare system and
user times between 2.4 and 2.5.

2.4.22-pre4-SMP:
	0.15s user 0.71s system 9% cpu 8.888 total
	0.07s user 0.69s system 11% cpu 6.658 total
	0.14s user 0.56s system 11% cpu 6.212 total
	0.18s user 0.60s system 11% cpu 6.944 total

Average:           0.64                 7.18

2.5.74-mm3-SMP:
	0.10s user 0.58s system 11% cpu 6.060 total
	0.08s user 0.54s system 10% cpu 6.009 total
	0.13s user 0.55s system 11% cpu 6.085 total
	0.11s user 0.49s system 10% cpu 5.858 total

Average:           0.54                 6.00



2.4.22-pre4-UP:
	0.11s user 0.60s system 10% cpu 6.733 total
	0.22s user 0.60s system 12% cpu 6.683 total
	0.12s user 0.58s system 8% cpu 8.408 total
	0.17s user 0.65s system 8% cpu 9.544 total

Average:           0.61                 7.84

2.5.74-mm3-UP:
	0.11s user 0.45s system 7% cpu 7.431 total
	0.19s user 0.46s system 10% cpu 6.354 total
	0.19s user 0.51s system 8% cpu 8.197 total
	0.09s user 0.59s system 9% cpu 6.842 total

Average:           0.50                 7.21


Modest but nice improvements in both system time and elapsed time.

I suspect that more than four runs was needed, really.
