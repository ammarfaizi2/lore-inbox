Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265338AbUAZXuD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUAZXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:47:11 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:7389 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265338AbUAZXpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:45:18 -0500
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange xmms deaths under high disk load
References: <yw1xu12i1fak.fsf@ford.guide> <4015A24A.3090101@cyberone.com.au>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 27 Jan 2004 00:45:15 +0100
In-Reply-To: <4015A24A.3090101@cyberone.com.au> (Nick Piggin's message of
 "Tue,: 27:06 +1100")
Message-ID: <yw1x3ca21dh0.fsf@ford.guide>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> writes:

>>If I play music with TCVP instead, it keeps playing, but sound is
>>choppy at intervals.  Below is vmstat output during a copying.
>>
>>procs ---------memory---------- ---swap-- -----io---- --system-- ----cpu----
>> r  b swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>> 0  0    0  86128   3424 165920    0    0    66    66   24     4 23 23 54  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1131  1352 17 14 69  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1128  1360 13  4 84  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1129  1351 13  4 84  0
>> 0  0    0  86128   3424 165920    0    0     0   153 1142  1361 14  3 83  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1127  1353 14  4 83  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1128  1348 12  3 84  0
>> 0  0    0  86128   3424 165920    0    0     0     0 1130  1344 17 15 69  0
>> 0  0    0  86000   3424 166048    0    0   128     0 1132  1356 13  3 84  0
>>
> ...
>
>>11  2    0   2400   3392 246368    0    0   768 26112  969   626 25 71  0  3
>>
> ...
>
>>11  0    0   3040   1704 248160    0    0     0 33704  696    58 10 90  0  0
>>
> ...
>
>>
>> 1  1    0   2528   1736 250608    0    0  1756 21332  965   590 35 56  0  8
>>
>
> Looks like you might be losing timer interrupts, possibly caused by
> an IDE disk doing PIO?

All the disks are doing ATA-100, so that's not it.  Something else
could have caused it, of course.  Rather bad of xmms to crash, too.

What worries me most is the file corruption I saw in connection with
one such crash.  It hasn't happened again, though.

-- 
Måns Rullgård
mru@kth.se
