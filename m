Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUIPFDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUIPFDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 01:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUIPFDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 01:03:41 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:23504 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S266488AbUIPFDi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 01:03:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Thu, 16 Sep 2004 01:03:35 -0400
User-Agent: KMail/1.7
Cc: "Stephen C. Tweedie" <sct@redhat.com>
References: <200409121128.39947.gene.heskett@verizon.net> <1095088378.2765.18.camel@sisko.scot.redhat.com>
In-Reply-To: <1095088378.2765.18.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409160103.35665.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.59.197] at Thu, 16 Sep 2004 00:03:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 11:12, Stephen C. Tweedie wrote:
>Hi,
>
>On Sun, 2004-09-12 at 16:28, Gene Heskett wrote:
>> I just got up, and found advisories on every shell open that the
>> journal had encountered an error and aborted, converting my /
>> partition to read-only.
>
>...
>
>> The kernel is 2.6.9-rc1-mm4.  .config available on request.
>>
>> This is precious little info to go on, but basicly I'm wondering
>> if anyone else has encountered this?
>
>Well, we really need to see _what_ error the journal had encountered
> to be able to even begin to diagnose it.  But 2.6.9-rc1-mm3 and
> -mm4 had a bug in the journaling introduced by low-latency work on
> the checkpoint code; can you try -mm5 or back out
>"journal_clean_checkpoint_list-latency-fix.patch" and try again?
>
It just did it to me again, this time with 2.6.9-rc1-mm5.

This seems to coincide with the system being busier than that famous 
cat on the equally famous tin roof as far as disk traffic is 
concerned.  This time amanda was running which makes the drives work 
up a sweat, and I was trying to get checkinstall to install 
xorg.6.8.1 that I had just built, so it was moving about 55 megs of 
files around when things went splat.

So that run of amanda is kaput, and I have a mess to clean up 
in /var/tmp and /usr/src/X6.8.1 from checkinstall.

And as usual in these cases, the logs are spotlessly clean 
because /var is on /, which is on /dev/hda7, an syslog couldn't write 
when its read-only.

Has anyone any ideas?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

