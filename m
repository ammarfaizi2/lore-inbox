Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbUC2Tf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUC2Tf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:35:57 -0500
Received: from pC19F1BE6.dip0.t-ipconnect.de ([193.159.27.230]:21632 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S263061AbUC2Tfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:35:55 -0500
Message-ID: <40687A8E.5000604@pC19F1BE6.dip0.t-ipconnect.de>
Date: Mon, 29 Mar 2004 21:35:42 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040212
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Very poor performance with 2.6.4
References: <40672F39.5040702@p3EE062D5.dip0.t-ipconnect.de>	 <20040328200710.66a4ae1a.akpm@osdl.org>	 <4067BF2C.8050801@p3EE060D4.dip0.t-ipconnect.de> <1080570227.20685.93.camel@watt.suse.com>
In-Reply-To: <1080570227.20685.93.camel@watt.suse.com>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> On Mon, 2004-03-29 at 01:16, Andreas Hartmann wrote:
>> Andrew Morton wrote:
>> > Andreas Hartmann <andihartmann@freenet.de> wrote:
>> >>
>> >> I tested kernel 2.6.4. While compiling kdelibs and kdebase, I felt, that
>> >>  kernel 2.6 seems to be slower than 2.4.25.
>> >> 
>> >>  So I did some tests to compare the performance directly. Therefore I
>> >>  rebooted for everey test in init 2 (no X).
>> >> 
>> >>  I locally compiled 2.6.5rc2 3 times under 2.6.4 and under 2.4.25 on a
>> >>  reiserfs LVM partition, which resides onto a IDE HD (using DMA) and got
>> >>  the following result:
>> >> 
>> >>  In the middle, compiling under kernel 2.6.4 tooks 9.3% more real time than
>> >>  under 2.4.25.
>> >>  The user-processortime is about the same, but the system-processortime is
>> >>  under 2.6.4 32.9% higher than under 2.4.25.
>> > 
>> > Try mounting your reiserfs filesystems with the `-o nolargeio=1' option.
>> 
>> This didn't help.
>> 
>> > 
>> > If that doesn't help, please run a comparative kernel profile.  See
>> > Documentation/basic_profiling.txt.
>> 
>> I'll do this next.
> 
> You might also want to try 2.6.5-rc2 which has a set of reiserfs fixes
> from 2.4.x.  I'm hoping those will clean things up for you.

Ok, here is the result for 2.6.5-rc2 (3 times middle, with preemption), 
compared to 2.4.25.

The result is, the performancedifference to 2.4.25 is the same as for 
2.6.4 as described above.
Nearly means: The real processing time is about 1% faster than under 
2.6.4, but 8.3% slower than with 2.4.25. The system-processortime is 1.2% 
faster than under 2.6.4 but 31,7% more than under 2.4.25. The times for 
the user-processortime is unchanged.

But I'm not shure if these values are really significant, because the 
values for the real time meassured each try differ a lot under 2.6.

For example 2.6.5rc2:
between 9.07 min and 8.37 min for real time.
Under 2.4.25, the differences are a lot of smaller: between 8.06 min and 
8.15 min for real time.
The values for user and system time are nearly constant with 6.49 min and 
36 sec (kernel 2.6) and 6.43 min / 27 sec for 2.4.25.


Regards,
Andreas Hartmann
