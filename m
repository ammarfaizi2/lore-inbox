Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263387AbTDCNAa>; Thu, 3 Apr 2003 08:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263388AbTDCNAa>; Thu, 3 Apr 2003 08:00:30 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:4446 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263387AbTDCNA2>; Thu, 3 Apr 2003 08:00:28 -0500
Date: Thu, 3 Apr 2003 15:11:47 +0200
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403131147.GB7961@iliana>
References: <4D87862358@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D87862358@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 03:05:54PM +0100, Petr Vandrovec wrote:
> On  3 Apr 03 at 14:38, Sven Luther wrote:
> > On Thu, Apr 03, 2003 at 12:05:13PM +0100, Petr Vandrovec wrote:
> > > No. With matroxfb, you have two framebuffer devices, /dev/fb0 & /dev/fb1,
> > > which can be connected to any of three outputs: analog primary, analog
> > > secondary and DVI. Analog primary & DVI share same pair of DDC cables,
> > > and analog secondary has its own... And user can interconnect fb* with
> > > outputs in almost any way he wants, as long as hardware supports it.
> > 
> > Mmm, i have not been into fbdev much lately, but for my X devel work, i
> > believe thta it is a good thing to separate the framebuffer issues from
> > the output issues, and thus, for the card i have at least, have one
> > function where the per chip things are done (memory detection, bypass
> > unit handling, framebuffer and memory management) and another set of
> > functions which would be head, that is output, specific. This way, you
> > would configure the /dev/fbx and when the user which to use this or that
> > output, the DDC will be connected to the output, not the framebuffer.
> > This seems a reasonable way of doing this and should solve your problem,
> > no ?
> 
> Of course. But because of James decided that fbdev layer will automatically
> choose appropriate resolution only from xres/yres, I need to have monitor
> capabilities at the time upper layer asks to set videomode on /dev/fbx...
> And it just sets it on /dev/fbx, leaving out both VTs (so I cannot remember
> what mode was probed on each VT anymore) and outputs.

Mmm, and at what time is the fbdev->output mapping done ?

Friendly,

Sven Luther
