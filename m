Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWEID5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWEID5D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 23:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWEID5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 23:57:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:41631 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751363AbWEID5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 23:57:02 -0400
Date: Tue, 9 May 2006 09:23:20 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 2/8] Sync block I/O and swapin delay collection
Message-ID: <20060509035320.GC784@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061408.GM13962@in.ibm.com> <20060508141952.2d4b9069.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508141952.2d4b9069.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:19:52PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > @@ -550,6 +550,12 @@ struct task_delay_info {
> >  	 * Atomicity of updates to XXX_delay, XXX_count protected by
> >  	 * single lock above (split into XXX_lock if contention is an issue).
> >  	 */
> > +
> > +	struct timespec blkio_start, blkio_end;	/* Shared by blkio, swapin */
> > +	u64 blkio_delay;	/* wait for sync block io completion */
> > +	u64 swapin_delay;	/* wait for swapin block io completion */
> > +	u32 blkio_count;
> > +	u32 swapin_count;
> 
> These fields are a bit mystifying.
> 
> In what units are blkio_delay and swapin_delay?
> 
> What is the meaning behind blkio_count and swapin_count?
> 
> Better comments needed, please.

Will add more detailed comments and send them as updates.


	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
