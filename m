Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290749AbSBLDeg>; Mon, 11 Feb 2002 22:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290753AbSBLDeW>; Mon, 11 Feb 2002 22:34:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26378 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290749AbSBLDeL>; Mon, 11 Feb 2002 22:34:11 -0500
Date: Mon, 11 Feb 2002 21:19:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Hesterberg <jh@sgi.com>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-ia64@linuxia64.org>
Subject: Re: driver location for platform-specific drivers
In-Reply-To: <20020211131744.A16032@sgi.com>
Message-ID: <Pine.LNX.4.33.0202112118180.22909-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Feb 2002, John Hesterberg wrote:
>
> For SGI's upcoming Linux platform (nicknamed Scalable Node, or SN),
> we have some platform specific device drivers.  Where should these go?
> I see several precedents in the current kernels.

If they are equivalent to a new bus, make a new platform directory under
drivers, is my vote.

However, if they are likely to eventually spread out (ie they are
really PCI-based, and just your own private chips, and they might end up
as part of some other sgi platform), spread them out as normal drivers.

		Linus

