Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUDGW1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbUDGW1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:27:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61158 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264184AbUDGW0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:26:53 -0400
Date: Wed, 07 Apr 2004 15:38:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, colpatch@us.ibm.com
cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: NUMA API for Linux
Message-ID: <5840000.1081377504@flay>
In-Reply-To: <20040407145130.4b1bdf3e.akpm@osdl.org>
References: <1081373058.9061.16.camel@arrakis> <20040407145130.4b1bdf3e.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, April 07, 2004 14:51:30 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Matthew Dobson <colpatch@us.ibm.com> wrote:
>> 
>> Just from the patches you posted, I would really disagree that these are
>> ready for merging into -mm.
> 
> I have them all merged up here.  I made a number of small changes -
> additional CONFIG_NUMA ifdefs, whitespace improvements, remove unneeded
> arch_hugetlb_fault() implementation.  The core patch created two copies of
> the same file in mempolicy.h, compile fix in mmap.c and a few other things.

I think there are some design issues that still aren't resolved - we've
been over this a bit before, but I still don't think they're fixed.
It seems you're still making a copy of the binding structure for every
VMA, which seems ... extravagent. Can we share them? IIRC, the only 
justification was the striping ... and I thought we agreed that was
better fixed by using the mod of the offset as a decider?

Maybe I'm just misreading your code, in which case, feel free to spit at me ;-)

M.

