Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTKSOlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTKSOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:41:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8841 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264088AbTKSOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:41:54 -0500
Date: Mon, 17 Nov 2003 09:51:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       vojtech@ucw.cz
Subject: Re: Corrected drivermodel for i8042.c
Message-ID: <20031117085123.GF643@openzaurus.ucw.cz>
References: <20031116131134.GA301@elf.ucw.cz> <200311161520.03425.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311161520.03425.dtor_core@ameritech.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +static int i8042_resume_port(struct serio *port)
> > +{
> > +	struct serio_dev *dev = port->dev;
> > +	if (dev) {
> > +		dev->disconnect(port);
> > +		dev->connect(port, dev);
> > +	}
> > +}
> 
> You want to do that event if there was nothing attached to the port
> as a mouse might get plugged in while the box is suspended. I think
> serio_rescan() is more appropriate (it will do a disconnect if needed
> for you).

I tried doing _rescan() but could not figure it out :-(.

> Overall there is a problem with disconnect/connect method as it will 
> cause a new input device created for the same hardware if old input
> device is held open by some process. If ever serio_reconnect patches
> will make in the tree then serio_reconnect() can be used instead of

Where can I get _reconnect() patches?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

