Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTAOXMR>; Wed, 15 Jan 2003 18:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267383AbTAOXMR>; Wed, 15 Jan 2003 18:12:17 -0500
Received: from smtp16.us.dell.com ([143.166.85.139]:61079 "EHLO
	smtp16.us.dell.com") by vger.kernel.org with ESMTP
	id <S267377AbTAOXMQ>; Wed, 15 Jan 2003 18:12:16 -0500
Date: Wed, 15 Jan 2003 17:20:59 -0600 (CST)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: robert@ping.us.dell.com
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
In-Reply-To: <20030115143313.76953b63.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301151712350.23847-100000@ping.us.dell.com>
X-Complaints-to: /dev/null
X-Apparently-From: mars
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2003, Andrew Morton wrote:
> OK, thanks.  The below patch reverts the spinlocking change,
> if you could please test that with CONFIG_PREEMPT=y

Reverting that brings the speed back up
2.5.57, preempt on, 8gig RAM
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 5  1   3624   7832 177824 7413824    0    1    16  8195  156   153  0 48 
46  5
 8  0   3624   7124 179336 7413612    0    0     0 110510 1317  2014  0 83 
10  7
 9  1   3624   8112 182552 7409316    0    1     0 109681 1309  1369  0 90  
4  6
 8  1   3624   8176 185824 7405948    0    0     0 112612 1302  2202  0 75 
17  8
10  1   3632   7328 189300 7402564    0    1     0 112160 1352  1764  0 81 
12  6

