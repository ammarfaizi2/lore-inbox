Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269197AbTCBMVA>; Sun, 2 Mar 2003 07:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269198AbTCBMVA>; Sun, 2 Mar 2003 07:21:00 -0500
Received: from holomorphy.com ([66.224.33.161]:56205 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S269197AbTCBMU7>;
	Sun, 2 Mar 2003 07:20:59 -0500
Date: Sun, 2 Mar 2003 04:31:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Multiple & vs. && and | vs. || bugs in 2.5.63
Message-ID: <20030302123108.GG1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Norbert Kiesel <nkiesel@tbdnetworks.com>,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20030302121923.GA27074@defiant>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302121923.GA27074@defiant>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 04:19:23AM -0800, Norbert Kiesel wrote:
> --- linux-2.5.63/mm/slab.c~	2003-02-24 11:05:39.000000000 -0800
> +++ linux-2.5.63/mm/slab.c	2003-03-02 03:03:33.000000000 -0800
> @@ -1643,7 +1643,7 @@
>  	if (cachep->ctor && cachep->flags & SLAB_POISON) {
>  		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
>  
> -		if (!flags & __GFP_WAIT)
> +		if (!(flags & __GFP_WAIT))
>  			ctor_flags |= SLAB_CTOR_ATOMIC;
>  
>  		cachep->ctor(objp, cachep, ctor_flags);

Holy cow! This is major.

akpm, please expedite.


-- wli
