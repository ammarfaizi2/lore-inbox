Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVAUQiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVAUQiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAUQhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:37:50 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:48524 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262425AbVAUQhI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:37:08 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Roman Zippel <zippel@linux-m68k.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [Linux-fbdev-devel] Re: Radeon framebuffer weirdness in -mm2
Date: Sat, 22 Jan 2005 00:36:43 +0800
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org
References: <20050120232122.GF3867@waste.org> <20050121060928.GI12076@waste.org> <Pine.LNX.4.61.0501211315010.6118@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0501211315010.6118@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501220036.43358.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 January 2005 20:33, Roman Zippel wrote:
> Hi,
>
> On Thu, 20 Jan 2005, Matt Mackall wrote:
> > On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > > Next suspects would be:
> > > >
> > > >  +cleanup-vc-array-access.patch
> > > >  +remove-console_macrosh.patch
> > > >  +merge-vt_struct-into-vc_data.patch
> > >
> > > Make that:
> > >
> > > +cleanup-vc-array-access.patch
> > > +remove-console_macrosh.patch
> > > +merge-vt_struct-into-vc_data.patch
> > > +vgacon-fixes-to-help-font-restauration-in-x11.patch
> >
> > It's something in this batch. Which is good, as I'd be a bit
> > disappointed if the "vt leakage" were somehow attributable to the fb
> > layer. More bisection after dinner.
>
> Could you try the patch below. I cleaned up the logic a little in
> redraw_screen() and the code below really wants to do a update_screen().
> The old switch_screen(fg_console) behaved like update_screen(fg_console).
>

Probably does not matter as this particular code is never invoked during
framebuffer initialization (unless one uses fbcon=map:n option). 

Tony


