Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSBDUEw>; Mon, 4 Feb 2002 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSBDUEm>; Mon, 4 Feb 2002 15:04:42 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:61492 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S287895AbSBDUE1>; Mon, 4 Feb 2002 15:04:27 -0500
Message-ID: <3C5EE8AE.1206EEEB@kolumbus.fi>
Date: Mon, 04 Feb 2002 22:01:50 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Tomlinson <tomlins@cam.org>
CC: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202040627001.22583-100000@localhost.localdomain> <20020204044055.EF0579251@oscar.casa.dyndns.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson wrote:
> 
> One point that seems to get missed is that a group of java threads,
> posix threads or sometimes forked processes combine to make an 
> application. Linux, at the scheduler level at least, does not have the 
> ability to determine that all the tasks are really one application.  
> Under light loads this makes no difference.  When the load gets heavy 
> having this ability helps here.

My application is very good example of this kind of application. I'm very
worried about the way new scheduler is beginning to behave. It's combination
of single processes with many threads and many processes with single
threads. And because it's kind of realtime application, _all_ processes and
threads are "interactive". CPU load is typically very high.


	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

