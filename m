Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWJVWhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWJVWhM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWJVWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:37:12 -0400
Received: from colin.muc.de ([193.149.48.1]:38411 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750776AbWJVWhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:37:10 -0400
Date: 23 Oct 2006 00:37:09 +0200
Date: Mon, 23 Oct 2006 00:37:09 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Jan Beulich <jbeulich@novell.com>
Subject: Re: [Nasty crash on boot] was Re: 2.6.19-rc2-mm2
Message-ID: <20061022223709.GA79345@muc.de>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <453B7308.70307@reub.net> <20061022111352.6b58ef58.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022111352.6b58ef58.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
> > RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422

This might have been related to the uninitialized cpu variable which
made the interrupt stacks uninitialized
Another patch broke that and gcc even warned about it but I only fixed  
it today.

It was only in -mm* for a short time too.

-Andi

