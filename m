Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbSKSAMv>; Mon, 18 Nov 2002 19:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKSAMv>; Mon, 18 Nov 2002 19:12:51 -0500
Received: from are.twiddle.net ([64.81.246.98]:53128 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265243AbSKSAMv>;
	Mon, 18 Nov 2002 19:12:51 -0500
Date: Mon, 18 Nov 2002 16:19:47 -0800
From: Richard Henderson <rth@twiddle.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More missing includes [1/4]
Message-ID: <20021118161947.B16391@twiddle.net>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0211182314490.16079-100000@vervain.sonytel.be> <20021118231745.D21571@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021118231745.D21571@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Nov 18, 2002 at 11:17:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:17:45PM +0000, Russell King wrote:
> The more obvious solution is to remove the __initdata from the
> declaration on line 545.  Such usage of __initdata (and __init)
> serves no purpose.

Yes it does.  If the variable is small, then the compiler may
expect the variable to be placed in the .sdata section, and so
be reachable by, say, a 16-bit gp-relative relocation.

Now, this variable in particular may not be small enough for
that, but the fact remains that the general rule should be that
variables should be declared with their section attributes.


r~
