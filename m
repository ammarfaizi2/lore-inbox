Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289340AbSAOA5V>; Mon, 14 Jan 2002 19:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSAOA5M>; Mon, 14 Jan 2002 19:57:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15119 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289336AbSAOA5A>; Mon, 14 Jan 2002 19:57:00 -0500
Date: Tue, 15 Jan 2002 00:56:50 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev currcon
Message-ID: <20020115005650.J23429@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.10.10201141618410.1714-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201141618410.1714-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Mon, Jan 14, 2002 at 04:39:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 04:39:43PM -0800, James Simmons wrote:
> [stuff about currcon]

I've killed currcon completely in the cyber2000fb driver in favour of
tracking which struct display is current.  Tracking 'currcon', doing
a whole pile of special cases, and copying 'var' stuff to/from fb.var
didn't make sense anymore.  I'm expecting the same thing will happen
with the other stuff in the struct fb_info.

(Think about the current cyber2000fb code, and what happens to other
consoles when you fbset 800x600-60 -a and then switch to them to
discover you only have a 640x480 window where the characters appear).

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

