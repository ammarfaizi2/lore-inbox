Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWBWD26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWBWD26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 22:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWBWD26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 22:28:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:1504 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750719AbWBWD25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 22:28:57 -0500
Date: Thu, 23 Feb 2006 08:59:03 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] map multiple blocks for mpage_readpages()
Message-ID: <20060223032903.GA31252@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <1140470635.22756.15.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140470635.22756.15.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 01:23:55PM -0800, Badari Pulavarty wrote:
> [PATCH 2/3] map multiple blocks for mpage_readpages()
> 
> This patch changes mpage_readpages() and get_block() to
> get the disk mapping information for multiple blocks at the
> same time.
> 
> b_size represents the amount of disk mapping that needs to
> mapped. On the successful get_block() b_size indicates the
> amount of disk mapping thats actually mapped.  Only the
> filesystems who care to use this information and provide multiple
> disk blocks at a time can choose to do so.
> 
> No changes are needed for the filesystems who wants to ignore this.

That's a nice way to handle this !

Just one minor suggestion on the patches - instead of adding all those
arguments to do_mpage_readpage, have you considered using
an mio structure as we did in the mpage_writepages multiple blocks case ?

Regards
Suparna

> 
> Thanks,
> Badari
> 
> 



-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

