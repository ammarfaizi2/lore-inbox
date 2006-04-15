Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWDOTfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDOTfI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWDOTfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:35:08 -0400
Received: from sc-outsmtp1.homechoice.co.uk ([81.1.65.35]:62737 "HELO
	sc-outsmtp1.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1751293AbWDOTfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:35:06 -0400
Subject: Re: [Alsa-devel] Re: Patch for AICA sound support on SEGA Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hvetqac7i.wl%tiwai@suse.de>
References: <1144075522.11511.20.camel@localhost.localdomain>
	 <s5hvetqac7i.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 20:34:07 +0100
Message-Id: <1145129647.9504.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 17:52 +0200, Takashi Iwai wrote:

> > +static void __exit aica_exit(void)
> > +{
> > +
> > +	if (likely(dreamcastcard->card)) {
> 
> You don't need such an optimization in this place at all.
> 
> > +		snd_aicapcm_free(dreamcastcard);
> > +		snd_card_free(dreamcastcard->card);
> > +		kfree(dreamcastcard);
> > +		if (likely(pd)) {
> > +			struct device_driver *drv = (&pd->dev)->driver;
> > +			device_release_driver(&pd->dev);
> > +			driver_unregister(drv);
> > +			platform_device_unregister(pd);
> > +		}
> 
> This should be in remove callback.
> 

What is the remove callback?

