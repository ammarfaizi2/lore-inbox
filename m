Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267279AbUGNG0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267279AbUGNG0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 02:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbUGNG0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 02:26:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:43679 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267279AbUGNG0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 02:26:12 -0400
Date: Tue, 13 Jul 2004 23:11:38 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-ID: <20040714061138.GC11803@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru> <20040617194739.GA15983@kroah.com> <20040618015504.661a50a9.zap@homelink.ru> <20040617220510.GA4122@kroah.com> <20040618095559.20763766.zap@homelink.ru> <20040624213452.GC2477@kroah.com> <20040627002152.20e2da7d.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040627002152.20e2da7d.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 12:21:52AM +0400, Andrew Zabolotny wrote:
> On Thu, 24 Jun 2004 14:34:52 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > How about just having every l/b driver containing a pointer to the
> > fbinfo that it is associated with?  Isn't there some way you can keep
> > the pointer that you need around within the place that you need to use
> > it from eventually?
> It's not a question of b/l driver needing the framebuffer driver; it's the
> other way around: the framebuffer driver needs the b/l drivers (needs so
> much that it can fail initialization in some cases if it doesn't find the
> corresponding b/l device).

Ok, then put a pointer in the fb driver to the backlight.
And a pointer in the backlight to the fb.  What's wrong with that?

> If you'll ask why not embed the b/l controls directly into the framebuffer
> drivers, the reason is simple: some video controllers just don't have a
> predefined way of controlling the b/l, so in every implementation it's
> different.

Just do it for the ones that you do know, what's wrong with that?

thanks,

greg k-h
