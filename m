Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSIYDnq>; Tue, 24 Sep 2002 23:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261901AbSIYDnq>; Tue, 24 Sep 2002 23:43:46 -0400
Received: from quechua.inka.de ([212.227.14.2]:26700 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S261902AbSIYDnn>;
	Tue, 24 Sep 2002 23:43:43 -0400
From: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <37EF12D6-D015-11D6-AD2E-000502C90EA3@Whitewlf.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E17u3AZ-0005Z0-00@sites.inka.de>
Date: Wed, 25 Sep 2002 05:48:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <37EF12D6-D015-11D6-AD2E-000502C90EA3@Whitewlf.net> you wrote:
> I have been trying to find an answer to this for the past couple weeks, 
> but I have finally broken down and must post this to this list. ;)

Ok, but I wonder a bit about your question. You have a big workload and
therefore a high load on the system, there is nothing much you can do from a
kernel perspecitve about it. I guess the PHP is one of the Problems here,
perhaps you should start to benchmark your mostly used web pages for
database access patttern.

> We also see high amounts of apache children segfaulting under load... 
> as high as 2-10/minute at times.

This is strange. Is this a ressource limit congestion or a apache bug. Which
apache version are you using?

> reducing tcp timeouts, etc. The big users of CPU are typically apache 
> and mysql. About 110+ instances of apache and mysqld each run in top at 
> high load. CPU use bounces wildly, with most in user space.

What are your Apache Parameters for min/max spare, maxclients etc.

> Machines:
> Moya (Which ran OK):

does that mean it run ok and had high load, or does that mean it had not
such a high load?

> Dual Thunder K7 1900+MPs, 1.5Gddr/ecc/reg ram
> dual u160 scsi,   3x18G soft raid 5 /home(ext3), 9G / (ext3) & /boot 
> (ext2) & 512Mb swap

this is a bit small ram, and you are probably better using raid-1 here.

> Anubis:
> Dual PIII  440lx, 1.0Gpc100/ecc ram

this is much slower, no wonder the system is sluggish, if you have CPU bound
tasks. can you post some vmstat results, to see if you are io, cpu or ram
bound.

>   7:04pm  up 1 day, 15:56,  2 users,  load average: 18.95, 17.81, 16.21
> 236 processes: 223 sleeping, 13 running, 0 zombie, 0 stopped
> CPU0 states: 89.1% user, 10.5% system,  0.0% nice,  0.0% idle
> CPU1 states: 84.2% user, 15.4% system,  0.0% nice,  0.0% idle
> Mem:  2061772K av, 1949428K used,  112344K free,       0K shrd,  
> 290984K buff
> Swap: 1493808K av,   48420K used, 1445388K free                  
> 882200K cached

to me this looks good, it is a very balanced workload. No idle time. Your
system seems to be mostly cpu bound here.

Greetings
Bernd
