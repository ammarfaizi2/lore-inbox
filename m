Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbTEHRfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 13:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTEHRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 13:35:03 -0400
Received: from hypatia.llnl.gov ([134.9.11.73]:1152 "EHLO hypatia.llnl.gov")
	by vger.kernel.org with ESMTP id S261907AbTEHRfC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 13:35:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dave Peterson <dsp@llnl.gov>
Organization: Lawrence Livermore National Laboratory
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
Date: Thu, 8 May 2003 10:47:24 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, davej@suse.de
References: <Pine.SOL.4.30.0305080311330.21696-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0305080311330.21696-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305081047.24908.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 May 2003 06:17 pm, Bartlomiej Zolnierkiewicz wrote:
> > > Yes, but bio->bi_next is a NULL already.
> >
> > I think assuming this is bad programming form.  You are assuming that
> > the memory allocator zeros out newly allocated memory.  Though your
>
> No, it is not memory allocator but block layer.
> Look at bio_init(), there is bio->bi_next = NULL explicitly.

Ok, I agree: the patch is not needed for 2.5 (although I think it still
makes sense for 2.4.20).  Thanks for the correction.

-Dave
