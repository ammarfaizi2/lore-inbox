Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTEGQfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbTEGQfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:35:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20432 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264063AbTEGQfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:35:01 -0400
Date: Wed, 7 May 2003 18:47:28 +0200
From: Jens Axboe <axboe@suse.de>
To: markw@osdl.org
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
Message-ID: <20030507164728.GO823@suse.de>
References: <200305071633.h47GXWW15850@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305071633.h47GXWW15850@mail.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, markw@osdl.org wrote:
> I've collected some data from STP to see if it's useful or if there's
> anything else that would be useful to collect. I've got some tests
> queued up for the newer patches, but I wanted to put out what I had so
> far.
> 
> 
> METRICS OVER LAST 20 MINUTES:
> --------------- -------- ----- ---- -------- -----------------------------------
> Kernel          Elevator NOTPM CPU% Blocks/s URL                                
> --------------- -------- ----- ---- -------- -----------------------------------
> 2.5.68-mm2      as        1155 94.3   8940.2 http://khack.osdl.org/stp/271356/  
> 2.5.68-mm2      deadline  1255 94.9   9598.7 http://khack.osdl.org/stp/271359/  
> 
> FUNCTIONS SORTED BY TICKS:
> -- ------------------------- ------- ------------------------- -------
>  # as 2.5.68-mm2             ticks   deadline 2.5.68-mm2       ticks  
> -- ------------------------- ------- ------------------------- -------
>  1 default_idle              6103428 default_idle              5359025
>  2 bounce_copy_vec             86272 bounce_copy_vec             97696
>  3 schedule                    63819 schedule                    70114
>  4 __make_request              30397 __blk_queue_bounce          31167
>  5 __blk_queue_bounce          26962 scsi_request_fn             26623
>  6 scsi_request_fn             24845 __make_request              25012

uhh nasty, you are spending a lot of time bouncing. How much RAM is in
the machine, and what is the scsi hba?

-- 
Jens Axboe

