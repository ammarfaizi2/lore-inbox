Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132933AbRDKTD4>; Wed, 11 Apr 2001 15:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRDKTDr>; Wed, 11 Apr 2001 15:03:47 -0400
Received: from [216.174.202.135] ([216.174.202.135]:64530 "EHLO
	celeborn.rivendell.insynq.com") by vger.kernel.org with ESMTP
	id <S132933AbRDKTDh>; Wed, 11 Apr 2001 15:03:37 -0400
From: Ian Eure <ieure@insynq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15060.43709.340915.563107@pyramid.insynq.com>
Date: Wed, 11 Apr 2001 12:04:29 -0700
To: Jens Axboe <axboe@suse.de>
Cc: Ian Eure <ieure@insynq.com>, linux-kernel@vger.kernel.org
Subject: Re: loop problems continue in 2.4.3
In-Reply-To: <20010409095607.A432@suse.de>
In-Reply-To: <15055.36597.353681.125824@pyramid.insynq.com>
	<20010409095607.A432@suse.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-Face: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i get this message when it panics:

-- snip --
loop: setting 534781920 bs for 07:86
Kernel panic: Invalid blocksize passed to set_blocksize
-- snip --

Jens Axboe writes:
 > On Sat, Apr 07 2001, Ian Eure wrote:
 > > i'm still having loopback problems with linux 2.4.3, even though they
 > > were supposed to be fixed. it doesn't deadlock my maching right away
 > > anymore, but instead causes a kernel panic after 4-6 uses of the loop
 > > device.
 > > 
 > > the message i get is: "Kernel panic: Invalid blocksize passed to
 > > set_blocksize"
 > > 
 > > 100% reproducable. has anyone else seen this?
 > > 
 > > i did compile with gcc 2.92.3, and i have hedrick's ide patches
 > > applied.
 > > 
 > > anyone else see this?
 > 
 > Nope, please add a printk like before set_blocksize in
 > drivers/block/loop.c and print the bs info, like so
 > 
 >         printk("loop: setting %d bs for %s\n", bs, kdevname(inode->i_rdev));
 >         set_blocksize(dev, bs);
 > 
 > -- 
 > Jens Axboe

-- 
 ___________________________________
| Ian Eure - <ieure@insynq.com>     | "You're living in a facist world...
|         -  Developer -            | Freedom is a luxury." -Front Line
|        -  InsynQ, Inc. -          | Assembly, "Digital Tension Dementia"
| Your Internet Utility Company.tm  |________________________________________
