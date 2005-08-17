Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVHQTwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVHQTwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbVHQTwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:52:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:60322 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751227AbVHQTwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:52:21 -0400
Date: Wed, 17 Aug 2005 12:52:10 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: vamsi krishna <vamsi.krishnak@gmail.com>
cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Multiple virtual address mapping for the same code on IA-64
 linux kernel.
In-Reply-To: <3faf0568050816142715f14c2c@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0508171246070.17863@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04294461@scsmsx401.amr.corp.intel.com>
 <3faf0568050816142715f14c2c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2005, vamsi krishna wrote:

> Seems like most of core size(VmSize) on ipf (126MB) is coming from the
> code size(VmExe) i.e 97MB. While the code size is just 62MB on amd64.
> 
> Looks like IA-64 wastes a lot of VM due to big instruction sizes, so
> big instruction sizes will improve performance ? compared small
> instruction sizes? , but fetching big instructions surely takes time
> compared to small, this may be the reason why amd64 is the fasttest
> 64-bit process ?

IA64 arranges instructions in word size bundles in order to optimize 
instruction fetch. Current GCC versions cannot properly optimize for 
the parallelism capabilities of the Itanium processor and thus many 
slots are filled with nop. Hopefully that will become better in gcc 4.X.

Itanium processors are the fastest 64bit processors at any given clock 
frequency. The earlier generations of processors do not even have the 
instruction set that would enable the processor to do more parallel 
processing. =-)

Please do not make such inflammatory statements on the 
ia64 list.
