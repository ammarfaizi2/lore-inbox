Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSGAM4M>; Mon, 1 Jul 2002 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSGAM4L>; Mon, 1 Jul 2002 08:56:11 -0400
Received: from smtp.intrex.net ([209.42.192.250]:26887 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S315525AbSGAM4K>;
	Mon, 1 Jul 2002 08:56:10 -0400
Date: Mon, 1 Jul 2002 09:03:53 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020701090353.B1957@tricia.dyndns.org>
References: <Pine.LNX.4.44.0206281730160.12542-100000@freak.distro.conectiva> <E17O7yk-0007w5-00@the-village.bc.nu> <20020630035058.A884@localhost.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020630035058.A884@localhost.park.msu.ru>; from ink@jurassic.park.msu.ru on Sun, Jun 30, 2002 at 03:50:58AM +0400
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2002 at 03:50:58AM +0400, Ivan Kokshaysky wrote:
> +#ifdef	__alpha__
> +		/* Current versions of Tru64 unix are SuS compliant.
> +		   Unfortunately, we have to use the binaries (namely
> +		   Netscape and Acrobat Reader) compiled vs. older
> +		   versions of OSF/1, where iov_len was a 32 bit integer. */
> +		ssize_t len = (int) iov[i].iov_len;
> +#else

So how does Tru64 handle this?  It must have some way of knowing whether to
mask the high bits or not.  If the comment above is correct then this patch
breaks new Tru64 binaries.

Jim
