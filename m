Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVAWVZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVAWVZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 16:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVAWVZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 16:25:53 -0500
Received: from are.twiddle.net ([64.81.246.98]:18048 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261359AbVAWVZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 16:25:48 -0500
Date: Sun, 23 Jan 2005 13:24:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: vlobanov <vlobanov@speakeasy.net>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123212455.GA8055@twiddle.net>
Mail-Followup-To: vlobanov <vlobanov@speakeasy.net>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Olaf Kirch <okir@suse.de>,
	"Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
	Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 01:00:24PM -0800, vlobanov wrote:
> #define SWAP(a, b, size)			\
>     do {					\
> 	register size_t __size = (size);	\
> 	register char * __a = (a), * __b = (b);	\
> 	do {					\
> 	    *__a ^= *__b;			\
> 	    *__b ^= *__a;			\
> 	    *__a ^= *__b;			\
> 	    __a++;				\
> 	    __b++;				\
> 	} while ((--__size) > 0);		\
>     } while (0)
> 
> What do you think? :)

I think you'll confuse the compiler and get worse results.


r~
