Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbQLVJKV>; Fri, 22 Dec 2000 04:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQLVJKM>; Fri, 22 Dec 2000 04:10:12 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:28942 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S131317AbQLVJJ6>; Fri, 22 Dec 2000 04:09:58 -0500
Date: Fri, 22 Dec 2000 09:39:28 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001222093928.A30636@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu> <20001221154446.A10579@vger.timpanogas.org> <20001221155339.A10676@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001221155339.A10676@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Thu, Dec 21, 2000 at 03:53:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000 around 15:53:39 -0700, Jeff V. Merkey wrote:
> 
> Alan,
> 
> I am looking over the 2.4 bigphysarea patch, and I think I agree 
> there needs to be a better approach.  It's a messy hack -- I agree.

Please explain further.
Just leaving it at that is not nice. What is messy?
The implementation? The API?

If you have a better solutions for allocating big chunks of
physical continious memory at different stages during the
runtime of the kernel, i would be very interesseted.

(Alan: bootmem allocation just won't do. I need that memory
in modules which get potentially loaded/unloaded, hence a
wrapper interface for allowing access to a bootmem allocated
piece of memory)

And the API? That API was set a long time ago, luckely not by me :)
Though I dont see the real problem. It allows allocation and
freeing of chunks of memory. Period. Its all its suppose to do.
Or do you want it rolled in kmalloc? So GFP_DMA with size>128K
would take memory from this? That would mean a much more intrusive
patch in very sensitive and rapidly changing parts of the kernel
(2.2->2.4 speaking)...

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
