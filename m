Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265323AbSJRVbM>; Fri, 18 Oct 2002 17:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSJRVbL>; Fri, 18 Oct 2002 17:31:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59408 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265323AbSJRVbJ>; Fri, 18 Oct 2002 17:31:09 -0400
Date: Fri, 18 Oct 2002 22:37:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: [BK PATCHS] fbdev updates.
Message-ID: <20021018223708.C15827@flint.arm.linux.org.uk>
References: <20021018193245.A15827@flint.arm.linux.org.uk> <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210181421110.3591-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Fri, Oct 18, 2002 at 02:24:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:24:48PM -0700, James Simmons wrote:
> Your right. That is a bug from the old fbgen code. Since few driver used
> the old fbgen code it never appeared. I suggest we remove can_soft_blank
> and just test to see if the function pointer exist for fb_blank. If it
> doesn't then we can resort to other tricks in suggested in the ther email.

Ok.  What about the case where you're running in true colour / static
pseudo colour, and can't blank the palette, but do have a fb_blank
method to handle the direct colour / pseudo colour case?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

