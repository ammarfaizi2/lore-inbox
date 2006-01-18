Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWARC4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWARC4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWARC4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:56:22 -0500
Received: from ozlabs.org ([203.10.76.45]:11485 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964873AbWARC4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:56:21 -0500
Date: Wed, 18 Jan 2006 13:55:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andrew Morton <akpm@osdl.org>, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sparse parse error in lppaca.h
Message-ID: <20060118025554.GI762@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Bryan O'Sullivan <bos@serpentine.com>,
	Andrew Morton <akpm@osdl.org>, arnd@arndb.de,
	linux-kernel@vger.kernel.org
References: <1137544465.4757.13.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137544465.4757.13.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 04:34:25PM -0800, Bryan O'Sullivan wrote:
> sparse can't parse a struct definition in include/asm-powerpc/lppaca.h,
> even though gcc can accept it.  The form looks like this:
> 
>         struct __attribute__((whatever)) foo { };
> 
> An equivalent that both gcc and sparse can handle is
> 
>         struct foo { } __attribute__((whatever));
> 
> This is the only definition of this type in the tree, and fixing it is
> easier than fixing sparse.
> 
> Signed-off-by: Bryan O'Sullivan <bos@serpentine.com>

Oops.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
