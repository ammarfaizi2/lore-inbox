Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSCMPRb>; Wed, 13 Mar 2002 10:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310655AbSCMPRV>; Wed, 13 Mar 2002 10:17:21 -0500
Received: from mail.spylog.com ([194.67.35.220]:11212 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S310654AbSCMPRH>;
	Wed, 13 Mar 2002 10:17:07 -0500
Date: Wed, 13 Mar 2002 18:17:35 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <991739488742.20020313181735@spylog.ru>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re[3]: MMAP vs READ/WRITE
In-Reply-To: <Pine.LNX.4.44L.0203131157210.2181-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0203131157210.2181-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

Wednesday, March 13, 2002, 5:58:08 PM, you wrote:


RvR> That would be a bit premature since this part of the code
RvR> hasn't been touched by -rmap ;)

RvR> It is something that still needs fixing, though.

:)

The most upsetting thing is the followings:

 0  2  0 210736  19472   2000 733188 216   0  5068     2  382   340   4   2  94
 0  2  0 210424  20108   1860 729596 219   0  4732     0  319   352   4   1  96
 0  2  0 210216  19652   1616 727280 254   0  4718    10  313   298   3   4  93
 1  1  0 209756  19988   1744 723940 285   0  4523    14  313   197   6   6  88
 0  2  0 209700  20096   1904 722236 223   0  4485    15  307   265   7   5  88


 Note some pages coming up from swap.

 This is vmstat exactly corresponding to doing read via mmap. So it
 looks like current VM  preforms in come cases to swap out pages from
 mapped files rather then discarding them :(

 This of course reduces performance on sequential IO :(



-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

