Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288234AbSAND13>; Sun, 13 Jan 2002 22:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSAND1K>; Sun, 13 Jan 2002 22:27:10 -0500
Received: from tomts15-srv.bellnexxia.net ([209.226.175.3]:30651 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288234AbSAND1F>; Sun, 13 Jan 2002 22:27:05 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [patch] O(1) scheduler-H6/H7 and nice +19
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sun, 13 Jan 2002 22:27:02 -0500
In-Reply-To: <Pine.LNX.4.33.0201111723260.3212-100000@localhost.localdomain> <20020111212834.D36DFBA489@oscar.casa.dyndns.org>
Organization: me
User-Agent: KNode/0.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20020114032702.8EA14CA7EA@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With pre3+H7, kernel compiles still take 40% longer with a setiathome
process running at nice +19.  This is _not_ the case with the old scheduler.

Ed Tomlinson

> On January 11, 2002 11:24 am, you wrote:
>> On Wed, 9 Jan 2002, Ed Tomlinson wrote:
>> > Noticed something about tasks running with nice 19.  They seem to
>> > always get 25-35% of the cpu.  This happens with kernel compiles and
>> > some other benchmarking processes.  If I kill the setiathome task, the
>> > other processes shoot up to 90% and above.
>>
>> why dont you run the setiathome task at nice +19? that way it'll share
>> CPU time with other niced processes.
> 
> Setiathome _is_ running at nice +19...  The H6 version cured the 2.4.17
> boot
> problem here.  Here are some numbers (H6) for you to consider:
> 
> make bzImage with setiathome running nice +19
> 
> make bzImage  391.11s user 30.85s system 62% cpu 11:17.37 total
> 
> make bzImage alone
> 
> make bzImage  397.33s user 32.14s system 92% cpu 7:43.58 total
> 
> Notice the large difference in run times...
> 
> System is: UP K6-III 400, 512M
> 
> Ed Tomlinson
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

