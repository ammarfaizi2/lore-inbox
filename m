Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265777AbUFXWka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUFXWka (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUFXWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:34:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:37558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265783AbUFXVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:24 -0400
Date: Thu, 24 Jun 2004 14:34:52 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Backlight and LCD module patches [1]
Message-ID: <20040624213452.GC2477@kroah.com>
References: <20040617223514.2e129ce9.zap@homelink.ru> <20040617194739.GA15983@kroah.com> <20040618015504.661a50a9.zap@homelink.ru> <20040617220510.GA4122@kroah.com> <20040618095559.20763766.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618095559.20763766.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 09:55:59AM +0400, Andrew Zabolotny wrote:
> On Thu, 17 Jun 2004 15:05:10 -0700
> Greg KH <greg@kroah.com> wrote:
> > Then you need to have a way to corrispond those devices together,
> > becides just a name.  Use the pointer that you have provided to link
> > them together some way.
> 
> There's no place to stuff that pointer into, because the load order of the
> framebuffer and lcd/backlight modules are not important (that's the reason for
> the notification chain), and at the time l/b modules are loaded there can be
> even no corresponding platform device (on my PDA for example, where platform
> device is also registered from a module).
> 
> How about passing a pointer to struct dev, and a pointer to struct fbinfo to
> every l/b driver and asking them if they are for this device or not?

Ick, no.

How about just having every l/b driver containing a pointer to the
fbinfo that it is associated with?  Isn't there some way you can keep
the pointer that you need around within the place that you need to use
it from eventually?

thanks,

greg k-h
