Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSFGUU2>; Fri, 7 Jun 2002 16:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSFGUU1>; Fri, 7 Jun 2002 16:20:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54027 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317341AbSFGUU0>;
	Fri, 7 Jun 2002 16:20:26 -0400
Message-ID: <3D011538.AF796D19@zip.com.au>
Date: Fri, 07 Jun 2002 13:19:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Patch??: linux-2.5.20/fs/bio.c - ll_rw_kio could generate bio's 
 bigger than queue could handle
In-Reply-To: <200206071246.FAA06400@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> ..
>         Jens has been cc'ed on all of this.  I think I should proceed
> as I described in the above paragraph.

I'd be more comfortable waiting for an ack from Jens, really.

+int bio_max_iovecs(request_queue_t *q, int *iovec_size)
+{
+       unsigned max_iovecs = min(q->max_phys_segments, q->max_hw_segments);

It seems that this test will significantly reduce the max BIO
size for some devices.  What's the thinking here?

-
