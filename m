Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279734AbRJYJ1y>; Thu, 25 Oct 2001 05:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279735AbRJYJ1p>; Thu, 25 Oct 2001 05:27:45 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:14097 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S279734AbRJYJ1e>; Thu, 25 Oct 2001 05:27:34 -0400
Date: Thu, 25 Oct 2001 11:27:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Two suggestions (loop and owner's of linux tree)
Message-ID: <20011025112752.A4795@suse.de>
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24 2001, Lukasz Trabinski wrote:
> Hello
> 
> I would like to suggest to change max_loop from 8 to 16 or more if it
> possible.
> 
> --- linux.org/drivers/block/loop.c      Wed Oct 24 15:23:11 2001
> +++ linux/drivers/block/loop.c  Wed Oct 24 15:24:52 2001
> @@ -75,7 +75,7 @@
>  
>  #define MAJOR_NR LOOP_MAJOR
>  
> -static int max_loop = 8;
> +static int max_loop = 16;
>  static struct loop_device *loop_dev;
>  static int *loop_sizes;
>  static int *loop_blksizes;

You just bumped loop memory usage by 24000 bytes on my system with
something that can be handled with a boot parameter. I'd rather see a
max_loop = 4 or something patch instead...

-- 
Jens Axboe

