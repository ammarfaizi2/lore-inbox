Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273567AbRIWN60>; Sun, 23 Sep 2001 09:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273621AbRIWN6R>; Sun, 23 Sep 2001 09:58:17 -0400
Received: from lilly.ping.de ([62.72.90.2]:37637 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S273567AbRIWN6A>;
	Sun, 23 Sep 2001 09:58:00 -0400
Date: 23 Sep 2001 15:28:41 +0200
Message-ID: <20010923152841.A9671@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Chris Mason" <mason@suse.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        "Beau Kuiper" <kuib-kl@ljbc.wa.edu.au>
Subject: Re: [PATCH] reiserfs speedup for 2.4.9+
In-Reply-To: <1696760000.1001194777@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <1696760000.1001194777@tiny>; from mason@suse.com on Sat, Sep 22, 2001 at 05:39:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2001 at 05:39:37PM -0400, Chris Mason wrote:
> 
> Hello everyone,

Hello Chris,

> Beau pointed me towards a performance bug in reiserfs, where reiserfs_write_super would be called excessively.  
> 
> Turns out that 2.4.9 included some new super handling code that 
> interacted poorly with how reiserfs uses kupdated calls to 
> write_super to trigger writebacks of metadata.
> 
> This is most obvious with benchmarks like bonnie++, where 
> 2.4.9 and 2.4.10 reiserfs do very poorly.
> 
> This patch makes things much better in my tests, I'd appreciate 
> a few more testers.  The only risk is reiserfs using slightly 
> more memory, but only if I've screwed something up.

Just to share my two cents. First I have to tell that the skipping
of alsaplayer playing .wav files I experienced during kernel compiles
or other activities is almost completly gone. Furthermore I did some
performance testing of kernel compiles (actions that are done:
untar kernel, patch kernel, make -j50 bzImage modules, 5 times in a
row). These are the results of plain 2.4.10-pre14aa1:

Elapsed (wall clock) time (h:mm:ss or m:ss): 6:25.90
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:15.43
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:01.95
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:12.56
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:35.61

And here are the results of 2.4.10-pre14aa1 + your patch:

Elapsed (wall clock) time (h:mm:ss or m:ss): 5:23.55
Elapsed (wall clock) time (h:mm:ss or m:ss): 5:32.21
Elapsed (wall clock) time (h:mm:ss or m:ss): 5:34.77
Elapsed (wall clock) time (h:mm:ss or m:ss): 6:17.55
Elapsed (wall clock) time (h:mm:ss or m:ss): 5:49.31

Is the performance fix also required for 2.4.9-acXX ?

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
