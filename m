Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSKSAQG>; Mon, 18 Nov 2002 19:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSKSAQG>; Mon, 18 Nov 2002 19:16:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265266AbSKSAQF>; Mon, 18 Nov 2002 19:16:05 -0500
Date: Tue, 19 Nov 2002 00:23:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More missing includes [1/4]
Message-ID: <20021119002305.G21571@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0211182314490.16079-100000@vervain.sonytel.be> <20021118231745.D21571@flint.arm.linux.org.uk> <20021118161947.B16391@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021118161947.B16391@twiddle.net>; from rth@twiddle.net on Mon, Nov 18, 2002 at 04:19:47PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 04:19:47PM -0800, Richard Henderson wrote:
> On Mon, Nov 18, 2002 at 11:17:45PM +0000, Russell King wrote:
> > The more obvious solution is to remove the __initdata from the
> > declaration on line 545.  Such usage of __initdata (and __init)
> > serves no purpose.
> 
> Yes it does.  If the variable is small, then the compiler may
> expect the variable to be placed in the .sdata section, and so
> be reachable by, say, a 16-bit gp-relative relocation.
> 
> Now, this variable in particular may not be small enough for
> that, but the fact remains that the general rule should be that
> variables should be declared with their section attributes.

Sigh, which is contary to what Christoph told me.  Fine, have it your
own way.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

