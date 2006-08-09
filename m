Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHIRLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHIRLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWHIRLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:11:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750749AbWHIRLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:11:14 -0400
Date: Wed, 9 Aug 2006 18:11:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 3/6] unlink: monitor i_nlink
Message-ID: <20060809171109.GC7324@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060809165729.FE36B262@localhost.localdomain> <20060809165732.07F0AD16@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809165732.07F0AD16@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 09:57:32AM -0700, Dave Hansen wrote:
> 
> When a filesystem decrements i_nlink to zero, it means that a
> write must be performed in order to drop the inode from the
> filesystem.
> 
> We're shortly going to have keep filesystems from being remounted
> r/o between the time that this i_nlink decrement and that write
> occurs.  
> 
> So, add a little helper function to do the decrements.  We'll
> tie into it in a bit to note when i_nlink hits zero.
> 
> Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

Acked-by: Christoph Hellwig <hch@lst.de>


Note that we all (and especially Andrew :)) need to be carefull not to
introduce unguarded i_nlink decrements again.  Dave, you'll probably need
to do another audit when you introduce the real functionality.
