Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVIFMOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVIFMOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 08:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVIFMOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 08:14:23 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:39262 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964837AbVIFMOW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 08:14:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LMTMdsXSUb0rT4MqOEUuptTn6YWEegXuAVHiQEoOUAYDhuRW+0dt1bVt0E5W0Od1gEC9HAwjRH7OWmlxI+GgePrjmsLYepFgkxKtMeWTQMIFdDxnF52OIP5WLsoE4mpYZSqS92z4IxV1Y8TfyaFYIb/EQnKdL/klY0cW/UmyFyg=
Message-ID: <84144f02050906051451664c28@mail.gmail.com>
Date: Tue, 6 Sep 2005 15:14:21 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [-mm patch 2/5] SharpSL: Add cxx00 support to the Corgi LCD driver
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <84144f0205090605107a76dd78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1126007628.8338.127.camel@localhost.localdomain>
	 <84144f0205090605107a76dd78@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Richard Purdie <rpurdie@rpsys.net> wrote:
> > +/*
> > + * Corgi/Spitz Touchscreen to LCD interface
> > + */
> > +unsigned long inline corgi_get_hsync_len(void)
> > +{
> > +       if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
> > +#ifdef CONFIG_PXA_SHARP_C7xx
> > +               return w100fb_get_hsynclen(&corgifb_device.dev);
> > +#endif
> > +       } else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
> > +#ifdef CONFIG_PXA_SHARP_Cxx00
> > +               return pxafb_get_hsync_time(&pxafb_device.dev);
> > +#endif
> > +       }
> > +       return 0;
> > +}

On 9/6/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Please consider making two version of corgi_get_hsync_len() instead
> for both config options. The above is hard to read.

Uhm, forget it. I didn't realize both config options can be enabled at
the same time. Sorry for the noise.

                                          Pekka
