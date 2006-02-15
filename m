Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWBOV3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWBOV3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWBOV3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:29:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:16807 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751010AbWBOV3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:29:13 -0500
Subject: Re: [PATCH 0/2] Add support to map multiple blocks in get_block()
	and remove get_blocks()
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, christoph <hch@lst.de>,
       akpm@osdl.org, mcao@us.ibm.com
In-Reply-To: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
References: <1139961721.4762.43.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 15 Feb 2006 13:29:10 -0800
Message-Id: <1140038951.20936.3.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 16:02 -0800, Badari Pulavarty wrote:
> Hi,
> 
> Following patches add support to map multiple blocks in ->get_block().
> This is will allow us to handle mapping of multiple disk blocks for
> mpage_readpages() and mpage_writepages() etc. Instead of adding new
> argument, I use "b_size" to indicate the amount of disk mapping needed
> for get_block().
> 
> Now that get_block() can handle multiple blocks, there is no need
> for ->get_blocks() which was added for DIO. Second patch removes
> them.
> 
> [PATCH 1/2] map multiple blocks in get_block() for mpage_readpages()
> 
> [PATCH 2/2] remove ->get_blocks() support
> 
> 
> Andrew, Please let me know if you want to pick these up into -mm
> tree, since they need to be integrated with Mingming's ext3 multiblock
> support.
> 

Hi Badari,

Patch looks good.  Did you get a chance to combine your patches with the
ext3 multiple blocks map/allocation patches, and run some simple
buffered-IO read tests? It would be nice to see if there is any
performance or cpu-usage gain (or regression).

Mingming

