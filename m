Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSHLNmX>; Mon, 12 Aug 2002 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318014AbSHLNmX>; Mon, 12 Aug 2002 09:42:23 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:34821 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318009AbSHLNmU>; Mon, 12 Aug 2002 09:42:20 -0400
Date: Mon, 12 Aug 2002 14:46:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [patch 1 of 2] Scalable statistics counters
Message-ID: <20020812144605.A4595@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	dipankar@in.ibm.com
References: <20020812183524.B1992@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020812183524.B1992@in.ibm.com>; from kiran@in.ibm.com on Mon, Aug 12, 2002 at 06:35:24PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 06:35:24PM +0530, Ravikiran G Thirumalai wrote:
> Hi Andrew,
> Here is the new statctr patch with some of the changes suggested by Christoph.
> Do you think the foll patch is ready to get into the mainline kernel now? 
> If so, will you forward this to Linus or shall I send the patch to him?
> The following patch works on 2.5.31. I will be mailing out the 2.5.31
> version of Dipankar's kmalloc_percpu dynamic memory allocator in a separate
> mail (since statctrs depend on them ).

But you ignored the most important suggestion.  Using proc_calc_metrics()
in new code is a mistake.  It's a sign you want to use the seq_file
interface.  And exporting it outside proc_misc.c is an even bigger mistake.

