Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281456AbRKVTFe>; Thu, 22 Nov 2001 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKVTFY>; Thu, 22 Nov 2001 14:05:24 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:32288 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S281456AbRKVTFQ>; Thu, 22 Nov 2001 14:05:16 -0500
Date: Thu, 22 Nov 2001 21:05:03 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What are the recommended software RAID patch(es) for 2.2.20?
Message-ID: <20011122210503.B4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <2173081930.1006455144@[195.224.237.69]>; from linux-kernel@alex.org.uk on Thu, Nov 22, 2001 at 06:52:24PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 06:52:24PM -0000, you [Alex Bligh - linux-kernel] claimed:
> What are the recommended software RAID patch(es) for 2.2.20.
> 
> I have applied, but not yet tested, raid-2.2.19-A1, which
> fails on one hunk in init.c which I think is unimportant
> (seemingly 2.2.20 has a full boot line to device translation
> table without conditionality of compilation).

I just applied raid-2.2.19-A1 on 2.2.20 and have it running.
I'm not 100% sure it works, though, since I get always the same md5sum from

cat /dev/hde | md5sum
or 
cat /dev/hdg | md5sum
(hdg and hde are not the same, but successive hde runs are the same as are
hdg runs.)

but
cat /dev/md0 | md5sum

is different every time. md0 consists of hde and hdg striped together.
(Again, I'm not expecting it to be same as hde or hdg, but consistent over
successive runs.) Successive hde and hdg runs are consistent even when run
in parallel.

Any ideas what could cause this? A short read or something else trivial?

I'll try to go back to 2.2.18pre19 soon, and see if it happens there. Also,
I'll try to see where the difference is. The first GB of md0 md5sums ok.

I'm having a lot of problem with this setup, and raid code is not my primary
suspect. My gut feeling is that you should be safe with raid-2.2.19-A1 on
top of 2.2.20 and my problem is elsewhere.
 
> Do I need to apply anything else? (-A2, -A3, -B1, -B2 or
> whatever)

I reckon not. -B3, -A1 etc are version codes Ingo likes to use.


-- v --

v@iki.fi
