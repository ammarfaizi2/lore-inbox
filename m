Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbSL1FqO>; Sat, 28 Dec 2002 00:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbSL1FqN>; Sat, 28 Dec 2002 00:46:13 -0500
Received: from are.twiddle.net ([64.81.246.98]:50313 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265532AbSL1FqN>;
	Sat, 28 Dec 2002 00:46:13 -0500
Date: Fri, 27 Dec 2002 21:54:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       william stinson <wstinson@wanadoo.fr>, trivial@rustcorp.com.au
Subject: Re: [PATCH] Mark deprecated functions so they give a warning on use
Message-ID: <20021227215426.A4557@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	william stinson <wstinson@wanadoo.fr>, trivial@rustcorp.com.au
References: <20021228035319.903502C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021228035319.903502C04B@lists.samba.org>; from rusty@rustcorp.com.au on Sat, Dec 28, 2002 at 11:57:10AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 11:57:10AM +1100, Rusty Russell wrote:
> +#define __DEPRECATED(msg) ({DEPRECATED_##msg: 1; })
[...]
> +#define check_region(start,n)	__DEPRECATED(use_request_region_return_value), __check_region(&ioport_resource, (start), (n))

So now it's a syntax error to use check_region twice
in the same function?


r~
