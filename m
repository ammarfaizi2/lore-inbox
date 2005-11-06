Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVKFTfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVKFTfo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 14:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKFTfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 14:35:44 -0500
Received: from lixom.net ([66.141.50.11]:13718 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751172AbVKFTfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 14:35:43 -0500
Date: Sun, 6 Nov 2005 11:34:59 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-ID: <20051106193459.GA7798@pb15.lixom.net>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com> <20051106112838.0d524f65.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106112838.0d524f65.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 11:28:38AM -0800, Andrew Morton wrote:

> This patch makes the ppc64 crash.  See
> http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg
> 
> I don't know what the access address was (ia32 nicely tells you), but if
> it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab

Yes, DAR is the faulting address on PPC. I'll submit a patch to improve
our Oops message later today unless someone beats me to it. :)


-Olof
