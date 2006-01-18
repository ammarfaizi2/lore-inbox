Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWARAaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWARAaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWARAaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:30:23 -0500
Received: from free.wgops.com ([69.51.116.66]:26629 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S964920AbWARA3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:29:48 -0500
Date: Tue, 17 Jan 2006 17:29:20 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
Message-ID: <7A7A0F7F294BB08D7CDA264C@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <43CD8A19.3010100@cfl.rr.com>
References: <E1EywcM-0004Oz-IE@laurel.muq.org>
 <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
 <43CD8A19.3010100@cfl.rr.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 17, 2006 7:21:45 PM -0500 Phillip Susi <psusi@cfl.rr.com> 
wrote:

> Your understanding of statistics leaves something to be desired.  As you
> add disks the probability of a single failure is grows linearly, but the
> probability of double failure grows much more slowly.  For example:

What about I said was inaccurate?  I never said that it increases 
exponentially or anything like that, just that it does increase, which 
you've proven.  I was speaking in the case of a RAID-5 set, where the 
minimum is 3 drives, so every additional drive increases the chance of a 
double fault condition.  Now if we're including mirrors and stripes/etc, 
then that means we do have to look at the 2 spindle case, but the third 
spindle and beyond keeps increasing.  If you've a 1% failure rate, and you 
have 100+ drives, chances are pretty good you're going to see a failure. 
Yes it's a LOT more complicated than that.

>
> If 1 disk has a 1/1000 chance of failure, then
> 2 disks have a (1/1000)^2 chance of double failure, and
> 3 disks have a (1/1000)^2 * 3 chance of double failure
> 4 disks have a (1/1000)^2 * 7 chance of double failure
>
> Thus the probability of double failure on this 4 drive array is ~142
> times less than the odds of a single drive failing.  As the probably of a
> single drive failing becomes more remote, then the ratio of that
> probability to the probability of double fault in the array grows
> exponentially.
>
> ( I think I did that right in my head... will check on a real calculator
> later )
>
> This is why raid-5 was created: because the array has a much lower
> probabiliy of double failure, and thus, data loss, than a single drive.
> Then of course, if you are really paranoid, you can go with raid-6 ;)
>
>
> Michael Loftis wrote:
>> Absolutely not.  The more spindles the more chances of a double failure.
>> Simple statistics will mean that unless you have mirrors the more drives
>> you add the more chance of two of them (really) failing at once and
>> choking the whole system.
>>
>> That said, there very well could be (are?) cases where md needs to do a
>> better job of handling the world unravelling.
>> -
>



--
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
