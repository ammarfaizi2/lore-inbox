Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278391AbRJSNLC>; Fri, 19 Oct 2001 09:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278393AbRJSNKw>; Fri, 19 Oct 2001 09:10:52 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:64274 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S278391AbRJSNKk>; Fri, 19 Oct 2001 09:10:40 -0400
Date: Fri, 19 Oct 2001 15:10:24 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Arjan Van de Ven <arjanv@redhat.com>
Subject: Re: [patch] block highmem zero-bounce #17
Message-ID: <20011019151023.D5509@suse.de>
In-Reply-To: <20011018144047.E4825@suse.de> <jen12n4w1v.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jen12n4w1v.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19 2001, Andreas Schwab wrote:
> Jens Axboe <axboe@suse.de> writes:
> 
> |> Patch is considered solid. Find it here:
> |> 
> |> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.13-pre4/block-highmem-all-17.bz2
> 
> Your patch still makes bad use of struct scatterlist which is architecture
> dependent.  Either fix the definitions in asm-*/scatterlist.h or go back
> using a private struct.  Why did you switch to struct scatterlist in the
> first place??

What are you talking about? Please expand. struct scatterlist has very
intentionally been changed to its current look, and if an arch is not
uptodate please let me know.

Some archs may not have updated their PCI DMA interfaces yet, that's
another issue. This will come in time.

-- 
Jens Axboe

