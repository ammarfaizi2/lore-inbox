Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTDEEky (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 23:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbTDEEky (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 23:40:54 -0500
Received: from franka.aracnet.com ([216.99.193.44]:42902 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261801AbTDEEkw (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 23:40:52 -0500
Date: Fri, 04 Apr 2003 20:52:02 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <9320000.1049518322@[10.10.2.4]>
In-Reply-To: <20030405024414.GP16293@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm not convinced that we can't do something with nonlinear mappings for
>> this ... we just need to keep a list of linear areas within the nonlinear
>> vmas, and use that to do the objrmap stuff with. Dave and I talked about
>> this yesterday ... we both had different terminology, but I think the
>> same underlying fundamental concept ... I was calling them "sub-vmas"
>> for each linear region within the nonlinear space. 
> 
> that's wasted memory IMHO, if you need nonlinear, you don't want to
> waste further metadata, you only want to pin pages in the pagetables,
> the 'window' over the pagecache (incidentally shm)

Hold on a minute ... don't the rmap chains (which this would be replacing)
waste rather more space than this anyway? I'd rather have it per linear
area than per-page ... think of it as "shared rmap pte chains with offsets"
if you like ;-)

M.

