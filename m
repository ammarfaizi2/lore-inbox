Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVHBPqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVHBPqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVHBPoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:44:19 -0400
Received: from dvhart.com ([64.146.134.43]:8891 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261587AbVHBPnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:43:53 -0400
Date: Tue, 02 Aug 2005 08:43:50 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Sonny Rao <sonny@burdell.org>, Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, anton@samba.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POWER 4 fails to boot with NUMA
Message-ID: <1980000.1122997430@[10.10.2.4]>
In-Reply-To: <20050801062322.GA32415@kevlar.burdell.org>
References: <17133.45774.226079.790875@cargo.ozlabs.ibm.com> <20050801062322.GA32415@kevlar.burdell.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Sonny Rao <sonny@burdell.org> wrote (on Monday, August 01, 2005 02:23:22 -0400):

> On Mon, Aug 01, 2005 at 12:27:42AM -0500, Paul Mackerras wrote:
>> From: Mike Kravetz <kravetz@us.ibm.com>
>> 
>> If CONFIG_NUMA is set, some POWER 4 systems will fail to boot.  This is
>> because of special processing needed to handle invalid node IDs (0xffff)
>> on POWER 4.  My previous patch to handle memory 'holes' within nodes
>> forgot to add this special case for POWER 4 in one place.
>> 
>> In reality, I'm not sure that configuring the kernel for NUMA on POWER 4
>> makes much sense.  Are there POWER 4 based systems with NUMA characteristics
>> that are presented by the firmware?  But, distros want one kernel for all
>> systems so NUMA is on by default in their kernels.  The patch handles those
>> cases.
> 
> IIRC, In SMP mode the NUMA topology is exported.  I've tried this on a
> p690 and it worked correctly on older kernels (2.6.10 or 2.6.11) 
> 
> I also noticed a nice speedup on a few things compared to LPAR mode :-)

Yeah, I have a p650 that's set up similarly .... I thought the auto-test
stuff was covering that, but it seems NUMA is not turned on for that box
like I thought it was. will fix ....

M.

