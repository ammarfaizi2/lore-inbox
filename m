Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWANUpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWANUpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWANUpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:45:44 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17115 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751078AbWANUpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:45:43 -0500
Message-ID: <43C962F0.30400@us.ibm.com>
Date: Sat, 14 Jan 2006 14:45:36 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Dave McCracken <dmccr@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <43C7C4C7.8050409@cfl.rr.com>
In-Reply-To: <43C7C4C7.8050409@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:

> Shouldn't those kind of applications already be using threads to share 
> page tables rather than forking hundreds of processes that all mmap() 
> the same file?
>
We're talking about sharing anonymous memory here, not files.

The feedback we've gotten on converting from a process-based to a 
thread-based model is that it's a major undertaking,
when development and test expense is considered.  It's understandable if 
one considers that they'd probably want to convert
across on several operating systems at once to minimize the number of 
source trees they have to maintain.

Also, the case for conversion isn't helped by the fact that at least two 
prominent commercial UNIX flavors either inherently
share page tables, or provide an explicit memory allocation mechanism 
that achieves page table sharing (e.g. Intimate Shared
Memory).

Cheers,
Brian

