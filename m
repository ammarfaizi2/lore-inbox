Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287396AbSALUGd>; Sat, 12 Jan 2002 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSALUGX>; Sat, 12 Jan 2002 15:06:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287408AbSALUGL>;
	Sat, 12 Jan 2002 15:06:11 -0500
Date: Sat, 12 Jan 2002 21:05:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BIO Usage Error or Conflicting Designs
Message-ID: <20020112210538.F19814@suse.de>
In-Reply-To: <200201121828.g0CISaM342258@saturn.cs.uml.edu> <Pine.LNX.4.10.10201121040040.13034-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201121040040.13034-200000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12 2002, Andre Hedrick wrote:
> 
> Jens,
> 
> Below is a single sector read using ACB.
> If I do not use the code inside "#ifdef USEBIO" and run UP/SMP but no
> highmem, it runs and works like a charm.  It is also 100% unchanged code
> from what is in 2.4 patches.  The attached oops is generate under
> SMP without highmem and running the USEBIO code.
> 
> CONFIG_NOHIGHMEM=y

Is this with the highmem debug stuff enabled? That's the only way I can
see this BUG triggering, otherwise q->bounce_pfn _cannot_ be smaller
than the max_pfn.

-- 
Jens Axboe

