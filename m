Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133082AbRDLOp0>; Thu, 12 Apr 2001 10:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbRDLOpQ>; Thu, 12 Apr 2001 10:45:16 -0400
Received: from memphis.cbn.net.id ([202.158.3.16]:50189 "HELO
	memphis.cbn.net.id") by vger.kernel.org with SMTP
	id <S133082AbRDLOpE>; Thu, 12 Apr 2001 10:45:04 -0400
Date: Thu, 12 Apr 2001 21:46:50 +0700 (JAVT)
From: <imel96@trustix.co.id>
To: <linux-kernel@vger.kernel.org>
cc: <nazief@indo.net.id>
Subject: perfect MAX_ORDER?
Message-ID: <Pine.LNX.4.33.0104122114480.312-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi,

the default MAX_ORDER is 10. as i don't know anything about
page usage, i did some tests to see how it affects performance
(with the infamous kernel compile time).
here it is (all +6m):

	1st test	2nd test	mean
2	40.153
3	38.543
4	38.065		38.615		38.350
5	36.778		38.696		37.737
6	37.902		37.800		37.851
7	36.990		36.650		36.820
8	37.157		36.379		36.768
9	37.215
10	37.951
11	36.889
12	36.773
13	36.765
14	36.533
15	37.683

so i conclude that the test is inconclusive. only the first
three (MAX_ORDER == [234]) have noticeable difference, but
those must be affected by the shrinked dentry & page cache
hash table size, right?

the machine has 128mb ram, so the maximum MAX_ORDER that really
works is 14 (largest chunk 32mb).

if i use MAX_ORDER = 6 i save one page. so what should i use?
6, 14, or the default (10)?

would somebody care how the chunks used?


		imel



