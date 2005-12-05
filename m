Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVLEB3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVLEB3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 20:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLEB3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 20:29:25 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:12230 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751320AbVLEB3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 20:29:25 -0500
Date: Mon, 5 Dec 2005 09:43:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
Message-ID: <20051205014338.GA4849@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	clameter@sgi.com
References: <20051203071444.260068000@localhost.localdomain> <20051203071625.331743000@localhost.localdomain> <20051204155750.3972c3df.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204155750.3972c3df.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 03:57:50PM -0800, Andrew Morton wrote:
> Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> >
> > [PATCH] radix-tree: Remove unnecessary indirections and clean up code
> > 
> >  is only partially merged into -mm tree. This patch completes it.
> 
> md: autorun ...               
> md: ... autorun DONE.
> Unable to handle kernel paging request at virtual address 8000003c
>  printing eip:                                                    
> c013e16f      
> *pde = 00000000
> Oops: 0000 [#1]
> SMP            
> Modules linked in:
> CPU:    1         
> EIP:    0060:[<c013e16f>]    Not tainted VLI
> EFLAGS: 00010086   (2.6.15-rc5-mm1)         
> EIP is at find_get_page+0x2e/0x4e   

It has been running ok on several machines for over a month. A mysterious
bug mysteriously corrected by the following radix-tree look-aside cache patch?
I'll test this single patch against -mm tree, thanks.

Wu
