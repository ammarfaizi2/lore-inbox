Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137095AbREKKEX>; Fri, 11 May 2001 06:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137096AbREKKEO>; Fri, 11 May 2001 06:04:14 -0400
Received: from ns.suse.de ([213.95.15.193]:34319 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137095AbREKKD5>;
	Fri, 11 May 2001 06:03:57 -0400
Date: Fri, 11 May 2001 12:03:41 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Source code compatibility in Stable series????
Message-ID: <20010511120341.A5112@gruyere.muc.suse.de>
In-Reply-To: <200105110947.LAA18167@cave.bitwizard.nl> <15099.46931.914571.475632@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15099.46931.914571.475632@pizda.ninka.net>; from davem@redhat.com on Fri, May 11, 2001 at 02:56:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 02:56:35AM -0700, David S. Miller wrote:
> 
> Rogier Wolff writes:
>  > It seems that in 2.4.4 suddenly the function "skb_cow" no longer
>  > returns the modified skb, but it retuns and integer for
>  > succes/failure.
>  > 
>  > This means that for networking modules requiring this function, there
>  > is no source code compatibilty between 2.4.3 and 2.4.4.
> 
> And skb_datarefp went away too, in fact a ton of things changes.
> 
> Just deal with it.

I guess it would be possible to add a HAVE_ZEROCOPY to skbuff.h to make
it a bit easier for single source drivers.

--- include/linux/skbuff.h-o	Wed May  9 12:36:44 2001
+++ include/linux/skbuff.h	Fri May 11 12:12:43 2001
@@ -29,6 +29,7 @@
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
 #define SLAB_SKB 		/* Slabified skbuffs 	   */
+#define HAVE_ZEROCOPY		/* Zerocopy stack */ 
 
 #define CHECKSUM_NONE 0
 #define CHECKSUM_HW 1


-Andi

