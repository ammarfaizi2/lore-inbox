Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWBUONn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWBUONn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbWBUONn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:13:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29956 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1160994AbWBUONm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:13:42 -0500
Date: Tue, 21 Feb 2006 15:13:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport install_page
Message-ID: <20060221141341.GW4661@stusta.de>
References: <20060220223709.GT4661@stusta.de> <20060221103808.GB19349@infradead.org> <Pine.LNX.4.61.0602211227450.8400@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602211227450.8400@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 12:49:51PM +0000, Hugh Dickins wrote:
>...
> Why's that?  It's rightly been recognized as a library function since
> 2.6.0-test3.  I'd say it should remain exported for whatever filesystems
> might wish to use it (but no, I've no vested interest, the filesystem
> you'll suspect me of arguing for does not use it ;)
> 
> <akpm@osdl.org>
>   [PATCH] export install_page() to modules
> 
>   install_page() is a library function which we expect will be used by all
>   drivers which implement vm_operations.populate().  Therefore it should be
>   exported to kernel modules.
> 
>   Petr Vandrovec has a project which involves sparse mappings of device memory
>   which can use remap_file_pages().  It needs install_page().


This export was justified in mid-2003 with a projet that would use it.

Now it's 2006, and there's still no in-kernel user.

This means it has only bloated the kernel for two and a half years 
for nearly everyone.


> Hugh

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

