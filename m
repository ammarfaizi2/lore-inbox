Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278397AbRJSNNm>; Fri, 19 Oct 2001 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278396AbRJSNNW>; Fri, 19 Oct 2001 09:13:22 -0400
Received: from fe090.worldonline.dk ([212.54.64.152]:50181 "HELO
	fe090.worldonline.dk") by vger.kernel.org with SMTP
	id <S278395AbRJSNNQ>; Fri, 19 Oct 2001 09:13:16 -0400
Date: Fri, 19 Oct 2001 15:13:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
        Arjan Van de Ven <arjanv@redhat.com>
Subject: Re: [patch] block highmem zero-bounce #17
Message-ID: <20011019151331.E5509@suse.de>
In-Reply-To: <20011018144047.E4825@suse.de> <jen12n4w1v.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jen12n4w1v.fsf@sykes.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19 2001, Andreas Schwab wrote:
> using a private struct.  Why did you switch to struct scatterlist in the
> first place??

BTW, let me expand on this one. The sg_list change was dropped, davem
and I decided to evolve the current scatterlist in two steps:

- add ->page and ->offset and have the PCI DMA mapping interface use
  that if available. This step has already been taken with the pci64
  patches.

- Remove ->address completely. This step must be taken to ensure that
  drivers will be highmem safe. Period. Don't know when we will do this
  yet.

-- 
Jens Axboe

