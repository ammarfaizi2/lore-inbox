Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265282AbSJRS04>; Fri, 18 Oct 2002 14:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265565AbSJRS0z>; Fri, 18 Oct 2002 14:26:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49165 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265282AbSJRS0y>; Fri, 18 Oct 2002 14:26:54 -0400
Date: Fri, 18 Oct 2002 19:32:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
Message-ID: <20021018193245.A15827@flint.arm.linux.org.uk>
References: <20021015103833.C9771@flint.arm.linux.org.uk> <Pine.LNX.4.33.0210181018470.10832-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210181018470.10832-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Fri, Oct 18, 2002 at 10:27:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 10:27:59AM -0700, James Simmons wrote:
> Yes the drivers should always have priority. The other stuff is there
> only if the drivers have no power management of any kind. I leave it up to
> the driver write to implement a fb_blank function that handles different
> cases.

The drivers don't have priority though.  You call set_par, and then
wander off into the internals of fbgen.c to set can_soft_blank youself,
without giving the drivers any look-in to set that correctly.

> > There is also the argument about wanting soft blanking, but hardware power
> > saving.
> 
> Hm. True unfortunely the fbdev layer lacks handling details like that. The
> console system is even worse. This is why a single flag like
> can_soft_blank can actually be a limitation.

Well, it needs to be fixed.  We've lost functionality that was present in
2.4, and therefore I call it a bug.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

