Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTBKKpj>; Tue, 11 Feb 2003 05:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267444AbTBKKpj>; Tue, 11 Feb 2003 05:45:39 -0500
Received: from mail013.syd.optusnet.com.au ([210.49.20.171]:63627 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267439AbTBKKpi>; Tue, 11 Feb 2003 05:45:38 -0500
From: Con Kolivas <ckolivas@yahoo.com.au>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.60-cfq with contest
Date: Tue, 11 Feb 2003 21:55:15 +1100
User-Agent: KMail/1.5
Cc: Jens Axboe <axboe@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302112155.17048.ckolivas@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a quick set of the relevant results with the untuned CFQ by Jens:

ctar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   99      78.8    1.0     4.0     1.25
2.5.60-cfq          1   101     78.2    1.0     4.0     1.28
xtar_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   101     76.2    1.0     5.0     1.28
2.5.60-cfq          1   115     66.1    1.0     4.3     1.46
io_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   139     54.7    29.0    12.1    1.76
2.5.60-cfq          1   606     12.7    212.0   21.6    7.67
io_other:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   90      83.3    10.8    5.5     1.14
2.5.60-cfq          1   89      84.3    10.8    5.6     1.13
read_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   103     74.8    6.2     6.8     1.30
2.5.60-cfq          1   103     76.7    6.9     5.8     1.30
list_load:
Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
2.5.60              2   95      80.0    0.0     6.3     1.20
2.5.60-cfq          1   95      81.1    0.0     6.3     1.20

Write based loads hurt. No breakages, but needs tuning. 

Con
