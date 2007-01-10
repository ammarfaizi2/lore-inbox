Return-Path: <linux-kernel-owner+w=401wt.eu-S932695AbXAJFkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbXAJFkM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 00:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbXAJFjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 00:39:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:57248 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAJFji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 00:39:38 -0500
Date: Wed, 10 Jan 2007 11:14:19 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-aio@kvack.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070110054419.GA3542@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <20070104090242.44dd8165.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104090242.44dd8165.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 09:02:42AM -0800, Andrew Morton wrote:
> On Thu, 4 Jan 2007 10:26:21 +0530
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> 
> > On Wed, Jan 03, 2007 at 02:15:56PM -0800, Andrew Morton wrote:
> 
> Patches against next -mm would be appreciated, please.  Sorry about that.

I have updated the patchset against 2620-rc3-mm1, incorporated various
cleanups suggested during last review. Please let me know if I have missed
anything:

It should show up at
www.kernel.org:/pub/linux/kernel/people/suparna/aio/2620-rc3-mm1

Brief changelog:
- Reworked against the block layer unplug changes 
- Switched from defines to inlines for init_wait_bit* etc (per akpm)
- Better naming:  __lock_page to lock_page_async (per hch, npiggin)
- Kill lock_page_slow wrapper and rename __lock_page_slow to lock_page_slow
  (per hch)
- Use a helper function aio_restarted() (per hch)
- Replace combined if/assignment (per hch)
- fix resetting of current->io_wait after ->retry in aio_run_iocb (per zab)

I have run my usual aio-stress variations script
(www.kernel.org:/pub/linux/kernel/people/suparna/aio/aio-results.sh)

Regards
Suparna


-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

