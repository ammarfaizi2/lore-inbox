Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWBVQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWBVQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWBVQ7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:59:53 -0500
Received: from verein.lst.de ([213.95.11.210]:15023 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030307AbWBVQ7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:59:52 -0500
Date: Wed, 22 Feb 2006 17:59:42 +0100
From: christoph <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: christoph <hch@lst.de>, mcao@us.ibm.com, akpm@osdl.org,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
Message-ID: <20060222165942.GA25167@lst.de>
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140627510.22756.81.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 08:58:30AM -0800, Badari Pulavarty wrote:
> Thanks. Only current issue Nathan raised is, he wants to see
> b_size change to u64 (instead of u32) to support really-huge-IO
> requests. Does this sound reasonable to you ?

I know that we didn't want to increase b_size at some point because
of concerns about the number of objects fitting into a page in the
slab allocator.  If the same number of bigger heads fit into the
same page I see no problems with the increase.
