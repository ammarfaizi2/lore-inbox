Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261795AbSJNCjX>; Sun, 13 Oct 2002 22:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbSJNCjX>; Sun, 13 Oct 2002 22:39:23 -0400
Received: from smtp02.iprimus.net.au ([210.50.76.70]:22801 "EHLO
	smtp02.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S261795AbSJNCjW>; Sun, 13 Oct 2002 22:39:22 -0400
Message-ID: <3DAA2FE1.7040308@users.sourceforge.net>
Date: Mon, 14 Oct 2002 12:45:53 +1000
From: James Courtier-Dutton <jcdutton@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: kernel api for application profiling
References: <200210132217.AAA07121@harpo.it.uu.se> <20021013222636.GA2289@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 02:45:12.0467 (UTC) FILETIME=[B7D36E30:01C2732B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>I agree that it doesn't make sense to split up the resources (though at
>some point I'd like to maintain the watchdog functionality even with
>oprofile running). In fact, for now, I think the simple exclusive CONFIG
>solution is the simplest - the things don't get on together, after all.
>
>regards
>john
>  
>
Speaking as the potential user of these tools, having to run a different 
kernel (My translation of exclusive CONFIG) to swich these features on 
and off would be annoying. I would prefer the simple loading/unloading 
of a kernel module to do the job. Having looked at a fair bit of kernel 
module code, I at first think that the kernel module api cannot achieve 
this, but other people on this list might think/know otherwise.
 From the user point of view it is adding/removing a kernel feature so a 
module would seem appropriate, but from a programmers point of view, the 
profiling code would have to be spread about all the kernel code in 
order to accurately catch the profiling information.

Summary: -
Please try to create a profiling kernel runtime loadable module instead 
of an exclusive CONFIG item.

Cheers
James


