Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266462AbUBFEp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266465AbUBFEp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:45:29 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:16078 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266462AbUBFEp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:45:27 -0500
Date: Thu, 05 Feb 2004 20:45:15 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com, lord@xfs.org
Subject: Re: Limit hash table size
Message-ID: <91090000.1076042714@[10.10.2.4]>
In-Reply-To: <20040205193008.25bd922b.akpm@osdl.org>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel><20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel><p73isilkm4x.fsf@verdi.suse.de><20040205190904.0cacd513.akpm@osdl.org><20040206031834.GA24890@wotan.suse.de> <20040205193008.25bd922b.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > But I've been telling poeple for a year that they should set
>>  > /proc/sys/vm/swappiness to zero during the updatedb run and afaik nobody has
>>  > bothered to try it...
>> 
>>  I do not think such hacks are the right way to do. If updatedb does not
>>  do that backup will or maybe your nightly tripwire run or some other
>>  random application that walks file systems. Hacking all of them is just not 
>>  realistic.
> 
> You need some way of not slowing down real-world applications by a factor
> of 1000.  That is unacceptable, and the problems which updatedb and friends
> cause (just once per day!) pale in comparison.

I still think this needs to be on a per-process basis, rather than system
wide - it's updatedb that's the problem here, not the time of day. Personally, 
I'd just trigger on processes that were niced to hell, but I'm sure other
people have other ways.

M.

