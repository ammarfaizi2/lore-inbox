Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268469AbTGIR5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbTGIR5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:57:18 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:57268 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S268469AbTGIR5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:57:14 -0400
Date: Wed, 9 Jul 2003 13:38:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make synaptics support optional
Message-ID: <20030709113855.GC223@elf.ucw.cz>
References: <20030708104551.GA209@elf.ucw.cz> <20030709095544.GA852@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030709095544.GA852@vitelus.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On Tue, Jul 08, 2003 at 12:45:51PM +0200, Pavel Machek wrote:
> > --- /usr/src/tmp/linux/drivers/input/mouse/synaptics.c	2003-06-24 12:27:47.000000000 +0200
> > +++ /usr/src/linux/drivers/input/mouse/synaptics.c	2003-07-08 12:32:36.000000000 +0200
> > @@ -213,6 +213,9 @@
> >  {
> >  	struct synaptics_data *priv;
> >  
> > +#ifndef CONFIG_MOUSE_SYNAPTICS
> > +	return -1;
> > +#endif;
> >  	psmouse->private = priv = kmalloc(sizeof(struct synaptics_data), GFP_KERNEL);
> >  	if (!priv)
> >  		return -1;
> > 
> 
> Why not adjust the Makefiles?

It was that way once in history, but later it was changed to "always
include". I wanted minimal change.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
