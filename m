Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbULAHNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbULAHNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 02:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULAHNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 02:13:12 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:59375 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261314AbULAHMs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 02:12:48 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
Date: Wed, 1 Dec 2004 02:16:11 -0500
User-Agent: KMail/1.7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <200411301124.18628.gene.heskett@verizon.net> <Pine.LNX.4.61.0411300951220.14514@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0411300951220.14514@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412010216.11056.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.57.34] at Wed, 1 Dec 2004 01:12:47 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 November 2004 11:52, Zwane Mwaikambo wrote:
>On Tue, 30 Nov 2004, Gene Heskett wrote:
>> On Tuesday 30 November 2004 10:26, K.R. Foley wrote:
>> >"<some process> is being piggy... Read missed before next
>> > interrupt"
>> >
>> >2) tvtime is probably running at a RT priority of 99. The IRQ
>> > handler for the rtc defaults to 48-49 (I think). If you didn't
>> > already do so, you should bump the priority up as in:
>> >
>> >chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
>>
>> [root@coyote root]# chrt -f -p 99 `/sbin/pidof 'IRQ 8'`
>> bash: chrt: command not found
>>
>> chrt is an unknown command here. WTH?  Basicly an FC2 system.
>
>Install the package first (from an FC2 system)
>
>zwane@r3000 ~ {0:1} rpm -qif `which chrt`
>Name        : schedutils                   Relocations: (not
> relocatable) Version     : 1.3.0                            
> Vendor: Red Hat, Inc. Release     : 6                            
> Build Date: Tue 17 Feb 2004 10:16:15 MST
>Install Date: Tue 13 Jul 2004 11:13:52 MDT      Build Host:
> tweety.devel.redhat.com Group       : Applications/System          
> Source RPM: schedutils-1.3.0-6.src.rpm Size        : 39412         
>                   License: GPL Signature   : DSA/SHA1, Thu 06 May
> 2004 16:36:57 MDT, Key ID b44269d04f2a6fd2 Packager    : Red Hat,
> Inc. <http://bugzilla.redhat.com/bugzilla> Summary     : Utilities
> for manipulating process scheduler attributes Description :
> schedutils is a set of utilities for retrieving and manipulating
> process scheduler-related attributes, such as real-time parameters
> and CPU affinity.
>
>This package includes the chrt and taskset utilities.
>
>Install this package if you need to set or get scheduler-related
>attributes.

Ok, I installed it just now, and ran it twice, once before running 
tvtime, and once after, but it made no visible difference in the log 
input, which is still being very verbose and the delays it reports 
also remain the same.

So it would appear that this isn't the nail my hammer needs. :-)

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
