Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWAIUyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWAIUyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWAIUyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:54:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51924 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751361AbWAIUyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:54:46 -0500
Date: Mon, 9 Jan 2006 12:54:32 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] use local_t for page statistics
In-Reply-To: <200601070401.47618.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0601091253240.4061@schroedinger.engr.sgi.com>
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org>
 <43BF2D03.2030908@yahoo.com.au> <200601070401.47618.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Andi Kleen wrote:

> On Saturday 07 January 2006 03:52, Nick Piggin wrote:
> 
> > No. On many load/store architectures there is no good way to do local_t,
> > so something like ppc32 or ia64 just uses all atomic operations for
> 
> well, they're just broken and need to be fixed to not do that.

I tried to use local_t on ia64 for page statistics and have to agree with 
Nick. local_t has highly arch specific semantics.

