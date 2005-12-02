Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVLBDlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVLBDlX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVLBDlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:41:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964829AbVLBDlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:41:22 -0500
Date: Thu, 1 Dec 2005 19:40:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, christoph@lameter.com,
       riel@redhat.com, a.p.zijlstra@chello.nl, npiggin@suse.de,
       andrea@suse.de, magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for
 balanced zone aging
Message-Id: <20051201194036.68756424.akpm@osdl.org>
In-Reply-To: <20051202012645.GA3834@dmt.cnet>
References: <20051201101810.837245000@localhost.localdomain>
	<20051201101933.936973000@localhost.localdomain>
	<20051201023714.612f0bbf.akpm@osdl.org>
	<20051201222846.GA3646@dmt.cnet>
	<20051201150349.3538638e.akpm@osdl.org>
	<20051202012645.GA3834@dmt.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  > Could be.  But what about the bug which I think is there?  That'll cause
>  > overscanning of the DMA zone. 
> 
>  There were about 12Mb of inactive pages on the DMA zone. You're hypothesis 
>  was that there were no LRU pages to be scanned on DMA zone?

No, my hypothesis was that balance_pgdat() had a bug.  Looking at it again,
I don't see it any more..
