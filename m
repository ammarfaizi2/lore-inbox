Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTJXBzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTJXBzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:55:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22973 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261950AbTJXBzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:55:46 -0400
Date: Fri, 24 Oct 2003 02:55:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] must fix lists
Message-ID: <20031024015542.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <3F94C833.8040204@cyberone.com.au> <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk> <3F986859.2000101@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F986859.2000101@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 09:46:33AM +1000, Nick Piggin wrote:
>  drivers/tty
>  ~~~~~~~~~~~
>  
> -o viro: we need to fix refcounting for tty_driver (oopsable race, must fix
> -  anyway, hopefully about a week until it's merged) then we can do
> -  tty/misc/upper levels of sound.

Still not completely fixed.
  
>  o 64-bit dev_t.  Seems almost ready, but it's not really known how much
>    work is still to do.  Patches exist in -mm but with the recent rise of the
>    neo-viro I'm not sure where things are at.

32-bit dev_t is done, 64-bit means extra work on nfsd/raid/etc. for those who
are really interested.  Not a mustfix for 2.6.0.
  
>  o viro: cdev rework.  Main group is pretty stable and I hope to feed it to
>    Linus RSN.  That's cdev-cidr and ->i_cdev/->i_cindex stuff

Mostly done.
  
>  o viro: paride drivers need a big cleanup

Partially done, but ATAPI drivers will need serious work.  There are
real bugs, BTW - it's not just that code is ugly as hell.
