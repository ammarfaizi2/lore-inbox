Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSJ2VLj>; Tue, 29 Oct 2002 16:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJ2VLj>; Tue, 29 Oct 2002 16:11:39 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:49934 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262327AbSJ2VLh>; Tue, 29 Oct 2002 16:11:37 -0500
Date: Tue, 29 Oct 2002 21:18:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK updates] fbdev changes updates.
Message-ID: <20021029211800.A2806@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <20021029205529.A2145@infradead.org> <Pine.LNX.4.33.0210291408110.1363-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210291408110.1363-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Tue, Oct 29, 2002 at 02:08:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 02:08:37PM -0800, James Simmons wrote:
> 
> > On Tue, Oct 29, 2002 at 12:46:16PM -0800, James Simmons wrote:
> > >
> > > OOps. Forgot the link.
> > >
> > > bk://fbdev.bkbits.net/fbdev-2.5
> >
> > Does it still contain the random file movearounds?
> 
> The reason I did this was to prevent adding another chuck of agp code. The
> current work around for AGP fbdev drivers to have there OWN AGP code. So
> we can leave the agp drivers where they are at or the framebuffer layer
> can have its own AGP code for itself. Which way do you think it should be
> done?
> 
> 1) Fbdev layer has it own AGP layer
> 
> 2) Use already existing AGP layer code.

Well, I'd be very happy if you could separate different things abit.
Everyone wants the console fixes in, but code placement is a bit more of a
policy issue and wants more discussion..  Even when they are in different
directories the drm drivers can always call into the fbdev drivers as "base
modules", like sis currently does.
