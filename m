Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVHQDwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVHQDwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVHQDwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:52:23 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:47006 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbVHQDwW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:52:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Of0W+1hSDVSKEO8RUWCiH2cvibbD5X+q4+KZDA86wmrBDHWvqJKrFyn9E3ZP9Zs/64PHmy9WZcIKMV6lqevtAttzrfwAu8/GlyLk4IpZq5qOzYd14ZuI2lLTwAL3t2dSzIUAgkBh5UziYyddpoYI+Nob5MiLIKb8ntenQZRo07U=
Message-ID: <9e47339105081620524ca1d510@mail.gmail.com>
Date: Tue, 16 Aug 2005 23:52:17 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1124249381.8848.19.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1124242875.8848.10.camel@gaston> <1124249381.8848.19.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As an alternative to using VT IOCTLs you should be able to echo these
values to /sys/class/graphics/fb0/blank and blank the screen. The
attribute is pretty new so it hasn't had a lot of testing on the
various fbdev drivers.

#define VESA_NO_BLANKING        0
#define VESA_VSYNC_SUSPEND      1
#define VESA_HSYNC_SUSPEND      2
#define VESA_POWERDOWN          3


On 8/16/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
> 
> > (I'm blind and I use a braille display. I use those functions to blank
> > my laptop's screen so people don't read it, and hopefully to conserve
> > power.)
> 
> Oops ! I _am_not_ the one who is blind, though thanks a lot for some of
> the comments ;) I just forgot the line:
> 
> From: Stéphane Doyon <s.doyon@videotron.ca>
> 
> (I'm still stuck to Signed-off-by only lines)
> 
> 
> Stephane is to congratulate for this fix.
> 
> Ben.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Jon Smirl
jonsmirl@gmail.com
