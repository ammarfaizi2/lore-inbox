Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261277AbSJ1Op4>; Mon, 28 Oct 2002 09:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261278AbSJ1Op4>; Mon, 28 Oct 2002 09:45:56 -0500
Received: from ns.suse.de ([213.95.15.193]:9736 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261277AbSJ1Opz>;
	Mon, 28 Oct 2002 09:45:55 -0500
Date: Mon, 28 Oct 2002 15:51:23 +0100
From: Andi Kleen <ak@suse.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler (lmben ch data)
Message-ID: <20021028155123.A13576@wotan.suse.de>
References: <F2DBA543B89AD51184B600508B68D4000ECE730A@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000ECE730A@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 06:47:27AM -0800, Nakajima, Jun wrote:
> I don't think people need to use PGO for day-to-day development or
> debugging. Rather, it would be used only for systems deployed for actual
> use. For example, various kernel binaries optimized for particular use, such
> as database, web server, file server, embedded systems, etc, can be
> distributed as RPM (with profile feedback data). 

But unless these kernels are 100% bug free it still leaves the mainteance
issues open.

Also is it really that big a win ?

> 
> For development we should such profile feedback data to optimize the kernel
> in source code level (i.e by hand). I don't know the data in gcc has any
> clue for that.

likely/unlikely is the clue. In fact it is already overused.


-Andi

P.S.: Your original mail mentioned that the "P4P kernel was instable
with gcc32". Could you elaborate on the instability? We're using
kernels compiled with gcc 3.2 all the time and they work just fine.
