Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWKFB0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWKFB0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 20:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWKFB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 20:26:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56496 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1423146AbWKFB0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 20:26:19 -0500
X-Sasl-enc: W+n+78wqE8bvoA91dzBwXyqqjPfws+eum9YX1FWS9yIV 1162776379
Date: Sun, 5 Nov 2006 23:26:10 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Message-ID: <20061106012610.GA9309@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net> <1162773394.5473.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162773394.5473.18.camel@localhost.localdomain>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006, Richard Purdie wrote:
> that other devices would have a similar set of constraints (all the
> existing users at the time did). On such hardware, deinitialising
> anything you initialised is the norm and makes sense but the PC/ACPI
> world is different.

Yes, and we don't *init* the hardware with the backlight class either in
ACPI drivers...  AFAIK, anyway.

> Setting backlightdevice->props->update_status = NULL before
> unregistering is a horrible idea and I don't want to see hacks like that
> so yes, lets move it back into the drivers. 

Sure thing.  I am not at all interested into having such a horrible hack in
my local version of ibm-acpi for a second longer than strictly needed, so I
will help if I am able to.

> > Since the commit that introduced this behaviour (commit
> > 6ca017658b1f902c9bba2cc1017e301581f7728d) apparently did so because the
> > corgi_bl.c driver powered off the backlight, the attached patch also makes
> > sure that the corgi_bl.c driver will not have its behaviour changed.
> 
> Those commits were designed to standardise several behaviours amongst
> several drivers and this specific case was added to the core rather than
> coding it in each of several drivers. We therefore really need to update
> those other drivers too (locomo at the very least).

Do you have a list of them?  I can try to produce (untested) patches for
the ones in-tree, if you want me to.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
