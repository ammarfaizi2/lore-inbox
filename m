Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWAISaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWAISaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWAISaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:30:12 -0500
Received: from kanga.kvack.org ([66.96.29.28]:46517 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030232AbWAISaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:30:10 -0500
Date: Mon, 9 Jan 2006 13:26:22 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] use local_t for page statistics
Message-ID: <20060109182622.GC16451@kvack.org>
References: <20060106215332.GH8979@kvack.org> <20060106163313.38c08e37.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106163313.38c08e37.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:33:13PM -0800, Andrew Morton wrote:
> Bah.  I think this is a better approach than the just-merged
> mm-page_state-opt.patch, so I should revert that patch first?

After going over things, I think that I'll redo my patch on top of that 
one, as it means that architectures that can optimize away the save/restore 
of irq flags will be able to benefit from that.  Maybe after all this is 
said and done we can clean things up sufficiently to be able to inline the 
inc/dec where it is simple enough to do so.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
