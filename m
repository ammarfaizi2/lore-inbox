Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311568AbSCNJ1A>; Thu, 14 Mar 2002 04:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311569AbSCNJ0s>; Thu, 14 Mar 2002 04:26:48 -0500
Received: from mail.spylog.com ([194.67.35.220]:9447 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S311568AbSCNJ0p>;
	Thu, 14 Mar 2002 04:26:45 -0500
Date: Thu, 14 Mar 2002 12:27:15 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <1781804867952.20020314122715@spylog.ru>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: MMAP vs READ/WRITE
In-Reply-To: <20020313164158.A1219@namesys.com>
In-Reply-To: <861732271654.20020313161718@spylog.ru>
 <20020313164158.A1219@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

Wednesday, March 13, 2002, 4:41:58 PM, you wrote:

OD> Hello!

OD> On Wed, Mar 13, 2002 at 04:17:18PM +0300, Peter Zaitsev wrote:
>>   So I would say mmap is not really optimized nowdays in Linux and so
>>   read() may be wining in cases it should not. May be read-ahead is
>>   used with read and is not used with mmap.

OD> how about reading manual page on madvise(2) and redoing your test?

OK. I did but no luck.  The results are quite the same.

I think the hugest problem is:

 0  2  0 210736  19472   2000 733188 216   0  5068     2  382   340   4   2  94
 0  2  0 210424  20108   1860 729596 219   0  4732     0  319   352   4   1  96
 0  2  0 210216  19652   1616 727280 254   0  4718    10  313   298   3   4  93
 1  1  0 209756  19988   1744 723940 285   0  4523    14  313   197   6   6  88
 0  2  0 209700  20096   1904 722236 223   0  4485    15  307   265   7   5  88

 So then file is memory mapped and is read from some pages are coming
 out from swap instead of being read from file....
 

OD> Also cache is best cleaned by unmounting filesystem in question
OD> and then mounting it back.

Well. This was not really needed as I repeated the test several times
in a loop without clearing the cache after initial cleaning to see how
stable are results.




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

