Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTJWTEd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTJWTEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:04:33 -0400
Received: from mail-3.tiscali.it ([195.130.225.149]:7910 "EHLO
	mail-3.tiscali.it") by vger.kernel.org with ESMTP id S261724AbTJWTEb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:04:31 -0400
Date: Thu, 23 Oct 2003 21:04:21 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Eric Anholt <eta@lclark.edu>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Jon Smirl" <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] DRM and pci_driver conversion
Message-ID: <20031023190421.GA4567@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <1066703516.646.24.camel@leguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066703516.646.24.camel@leguin>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Mon, Oct 20, 2003 at 07:31:56PM -0700, Eric Anholt ha scritto: 
> I recently committed a change to the DRM for Linux in DRI CVS that
> converted it to use pci_driver and that probe system.  Unfortunately,
> we've found that there is a conflict between the DRM now and at least
> the radeon framebuffer.  Both want to attach to the same device, and
> with pci_driver, the second one to come along doesn't get probe called
> for that device.  Is there any way to mark things shared, or in some
> other way get the DRM to attach to a device that's already attached to,
> in the new model?

AFAIK no,  pci_dev only  stores one pointer  to the  driver. Two drivers
fiddling with the same hw can be dangerous. What will happen if radeonfb
starts using hw  accel, touching registers without  DRM knowing it? What
is (IMHO) needed is a common  layer that works with hardware and exposes
an interface to both radeonfb and DRM. I think that Jon Smirl is working
on something like this.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)
