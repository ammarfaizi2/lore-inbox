Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVDSVHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVDSVHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVDSVHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:07:36 -0400
Received: from alpha.polcom.net ([217.79.151.115]:51943 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261589AbVDSVHa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:07:30 -0400
Date: Tue, 19 Apr 2005 23:12:17 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
In-Reply-To: <20050419205445.GC16594@schottelius.org>
Message-ID: <Pine.LNX.4.62.0504192303220.8671@alpha.polcom.net>
References: <20050419121530.GB23282@schottelius.org> <20050419132417.GS17865@csclub.uwaterloo.ca>
 <1113938220.20178.0.camel@mindpipe> <20050419200011.GB16594@schottelius.org>
 <1113943332.21038.6.camel@mindpipe> <20050419205445.GC16594@schottelius.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Nico Schottelius wrote:

> Lee Revell [Tue, Apr 19, 2005 at 04:42:12PM -0400]:
>> On Tue, 2005-04-19 at 22:00 +0200, Nico Schottelius wrote:
>>> Can you tell me which ones?
>>>
>>
>> Multimedia apps like JACK and mplayer that use the TSC for high res
>> timing need to know the CPU speed, and /proc/cpuinfo is the fast way to
>> get it.
>>
>> Why don't you create sysfs entries instead?  It would be better to have
>> all the cpuinfo contents as one value per file anyway (faster
>> application startup).
>
> Well, sounds very good. It's a chance for me to learn to program
> sysfs and also to create something useful.
>
> So the right location to place that data would be
> /sys/devices/system/cpu/cpuX?

IIRC there was such patch not very long ago and it was rejected (to not 
make kernel larger or something like that...). But I can be wrong.

I think that all data from /proc that are not user-process data should be 
exported using sysfs or something similar. Maybe even in future one will 
write userspace fs (using FUSE?) to emulate old /proc entries using sysfs 
exported data. This will allow removing all proc code from kernel. Maybe 
even user processes data should be exported using sysfs (like 
/sys/processes/123/maps/41610000/file)? But this is my personal opinion.


Grzegorz Kulewski
