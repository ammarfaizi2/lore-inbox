Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVC0G7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVC0G7q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVC0G7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 01:59:45 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:7778 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261399AbVC0G7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 01:59:44 -0500
Message-ID: <424659D9.9000705@yahoo.com.au>
Date: Sun, 27 Mar 2005 16:59:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc1] cpusets special case GFP_ATOMIC allocs
References: <20050327065222.25762.37675.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20050327065222.25762.37675.sendpatchset@sam.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Stringent enforcement of cpuset memory placement could cause
> the kernel to panic on a GFP_ATOMIC (!wait) memory allocation,
> even though memory was available elsewhere in the system.
> 
> Relax the cpuset constraint, on the last zone loop in
> mm/page_alloc.c:__alloc_pages(), for ATOMIC requests.
> 

Kernel should not panic if a GFP_ATOMIC allocation fails.
Where is this happening?

