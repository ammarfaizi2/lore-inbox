Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313923AbSDJXJl>; Wed, 10 Apr 2002 19:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313924AbSDJXJk>; Wed, 10 Apr 2002 19:09:40 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.94]:22026 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313923AbSDJXJk>; Wed, 10 Apr 2002 19:09:40 -0400
Date: Thu, 11 Apr 2002 00:09:37 +0100
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
Message-ID: <20020410230937.GA353@berserk.demon.co.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20020410101913.GA975@berserk.demon.co.uk> <Pine.GSO.4.21.0204101305210.24941-100000@trillium.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:06:09PM +0200, Geert Uytterhoeven wrote:
> On Wed, 10 Apr 2002, Peter Horton wrote:
> > On Wed, Apr 10, 2002 at 11:57:31AM +0100, benh@kernel.crashing.org wrote:
> > > 
> > > Fine, though I noticed the get_cmap_len got changed to
> > > +	return var->bits_per_pixel == 8 ? 256 : 16;
> > > 
> > 
> > The colour map is only used by the kernel and the kernel only uses 16
> > entries so there isn't any reason to waste memory by making it any
> > larger. I checked a few other drivers and they do the same (aty128fb for
> > one).
> 
> However, this change will make the driver not save/restore all color map
> entries on VC switch in graphics mode.
> 

My error. Apologies. I was getting confused between the colour map with
the console colour <-> pixel value mapping (pointed to by ->dispsw_data)
- too many variables with similiar names :-(

P.
