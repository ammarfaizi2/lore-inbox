Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbTCJTSx>; Mon, 10 Mar 2003 14:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbTCJTSx>; Mon, 10 Mar 2003 14:18:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:32766 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261432AbTCJTSv>; Mon, 10 Mar 2003 14:18:51 -0500
Date: Mon, 10 Mar 2003 11:18:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: apw@shadowen.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64bk5: X86_PC + HIGHMEM boot failure
Message-ID: <4990000.1047323880@flay>
In-Reply-To: <200303101922.LAA05449@adam.yggdrasil.com>
References: <200303101922.LAA05449@adam.yggdrasil.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I just verified that the problem also occurs with NUMA +
> HIGHMEM_64GB (i.e., it is not limited to HIGHMEM_4GB).
> 
> 	By the way, HIGHMEM_64GB without NUMA gets a lot father, but
> still experiences memory corruption, probably same bug that caused me
> to downgrade to HIGHMEM_4G months ago (i.e., probably not related to
> this NUMA problem).

Yeah, we really ought to fix that. This one?
 http://bugme.osdl.org/show_bug.cgi?id=5

>>> 	Sorry for my misunderstanding of the CONFIG_NUMA configution
>>> options.
> 
>> No prob ... should probably be made more obvious. Are you by any chance
>> doing "yes | make oldconfig"? That's the obvious way to switch it on
>> by chance ... if so, can I recommend doing "yes '' | make oldconfig"
>> instead? That'll take the defaults, and work much better in general.
> 
> 	I want a kernel that is as broadly hardware compatible as
> possible and can take advantage of as much hardware as possible, in
> that order.  So, I guess I hope to reactivate CONFIG_NUMA once this
> problem is solved.

Right ... I think I have some more patches from Andy somewhere, though
he may not have tested with 64Gb on his PC ... I'll go look, and send
them to you if I have.

M.

