Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVBORqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVBORqt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 12:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVBORqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 12:46:48 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:750 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261622AbVBORqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 12:46:25 -0500
Message-ID: <4212350D.3060501@sgi.com>
Date: Tue, 15 Feb 2005 11:44:45 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Andi Kleen <ak@muc.de>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215110506.GD19658@lnx-holt.americas.sgi.com>
In-Reply-To: <20050215110506.GD19658@lnx-holt.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Mon, Feb 14, 2005 at 06:29:45PM -0600, Ray Bryant wrote:
> 
>>which is what you are asking for, I think.  The library's job
>>(in addition to suspending all of the processes in the list for
>>the duration of the migration operation, plus do some other things
>>that are specific to sn2 hardware) would be to examine the
> 
> 
> You probably want the batch scheduler to do the suspend/resume as it
> may be parking part of the job on nodes that have memory but running
> processes of a different job while moving a job out of the way for a
> big-mem app that wants to run on one of this jobs nodes.
> 

That works as well, and if we keep the majority of the work on
deciding who to migrate where and what to do when in a user space
library rather than in the kernel, then we have a lot more flexibility
in, for example who suspends/resumes the jobs to be migrated.

> 
>>do memory placement by first touch, during initialization.  This is,
>>in part, because most of our codes originate on non-NUMA systems,
>>and we've typically done very just what is necessary to make them
> 
> 
> Software Vendors tend to be very reluctant to do things for a single
> architecture unless there are clear wins.
> 
> Thanks,
> Robin
> 


-- 
-----------------------------------------------
Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
	 so I installed Linux.
-----------------------------------------------
