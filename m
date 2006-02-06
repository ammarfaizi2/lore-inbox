Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWBFTWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWBFTWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWBFTWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:22:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55272 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932297AbWBFTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:22:06 -0500
Date: Mon, 6 Feb 2006 11:22:01 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: discuss@x86-64.org, bharata@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602061955.19702.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602061121100.17183@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602061931.13953.ak@suse.de>
 <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com>
 <200602061955.19702.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Andi Kleen wrote:

> That is what prereservation was supposed to prevent. I remember there 
> were endless discussions when this all was originally implemented long
> ago (in the version that never got merged).

But the reservation does not consider cpusets and memory policies right?
It surely must fail if one restrict allocation to one node and then we run 
out of memory. That was the testcase that showed the Bus Error....\
