Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbUKCAsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUKCAsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKCAoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:44:54 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:11512 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261724AbUKBWWh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:22:37 -0500
Message-ID: <4188086F.8010005@us.ibm.com>
Date: Tue, 02 Nov 2004 14:21:35 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random>
In-Reply-To: <20041102220720.GV3571@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Still I recommend investigating _why_ debug_pagealloc is violating the
> API. It might not be necessary to wait for the pageattr universal
> feature to make DEBUG_PAGEALLOC work safe.

OK, good to know.  But, for now, can we pull this out of -mm?  Or, at 
least that BUG_ON()?  DEBUG_PAGEALLOC is an awfully powerful debugging 
tool to just be removed like this.
