Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUEGDCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUEGDCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 23:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUEGDCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 23:02:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:24200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262605AbUEGDCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 23:02:33 -0400
Date: Thu, 6 May 2004 20:02:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Cache queue_congestion_on/off_threshold
Message-Id: <20040506200210.44b04c38.akpm@osdl.org>
In-Reply-To: <200405062030.i46KUuF13625@unix-os.sc.intel.com>
References: <20040506064301.GC10069@suse.de>
	<200405062030.i46KUuF13625@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> >>>> Jens Axboe wrote on Wed, May 05, 2004 11:43 PM
> > On Wed, May 05 2004, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > Do you have any numbers at all for this? I'd say these calculations are
> > > >  severly into the noise area when submitting io.
> > >
> > > The difference will not be measurable, but I think the patch makes sense
> > > regardless of what the numbers say.
> >
> > Humm dunno, I'd rather save the sizeof(int) * 2.
> 
> Strictly speaking from memory consumption point of view, it probably comes
> for free since sizeof(struct request_queue) currently is 456 bytes on x86
> and 816 on 64bit arch.  The structure is being rounded to 512 or 1024 with
> kmalloc.

That's a good argument for creating a standalone slab cache for request
queue structures ;)
