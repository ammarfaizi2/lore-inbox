Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265668AbSKFHP4>; Wed, 6 Nov 2002 02:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265669AbSKFHP4>; Wed, 6 Nov 2002 02:15:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:47057 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265668AbSKFHPz>;
	Wed, 6 Nov 2002 02:15:55 -0500
Date: Wed, 6 Nov 2002 08:22:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46: ide-cd cdrecord (almost) success report
Message-ID: <20021106072223.GB4369@suse.de>
References: <20021106041330.GA9489@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106041330.GA9489@www.kroptech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05 2002, Adam Kropelin wrote:
> I felt like making some coasters tonight so I figured it was a good time
> to give ide-cd a chance with cdrecord. For the most part, it worked
> great! I was stunned, in fact, by how smoothly it went after I upgraded
> my cdtools. I was running SMP + preempt and it wrote smoothly at 12x
> with < 2% CPU usage the whole time. Buffer capacity never dropped below
> 98%.
> 
> I was almost disappointed at not making any coasters so I decided to
> stress it a bit. I tried running 'make -j10 bzImage' on the 2.5.46
> kernel tree while it was writing and that also worked! Buffer never
> dropped below 96%. (This machine is 2x Xeon 450, 256 MB RAM, BTW.)

That sounds very good so far!

> Still without coaster I tried one more thing...
> 'dd if=/dev/zero of=foo bs=1M' in parallel with another burn. That one
> did it in. ;) I'm running ext3 and the writeout load totally killed
> burn, which isn't surprising. I was asking for it, I know. What happened

Really, this should work. The deadline scheduler should handle this just
fine in fact. Which device is your burner and which device is the hard
drive? It sounds like a bug.

> when the cdrecord buffer underran was surprising, though: oops below.
> Very repeatable. Can supply copious hw details if it helps.

I'll try and reproduce that here, there's been a similar report (same
oops) before. If you can just send me the dmesg output after a boot that
should be fine.

Thanks a lot for testing, it's this kind of testing I need to iron out
the last few bugs!

-- 
Jens Axboe

