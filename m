Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUFIJ7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUFIJ7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 05:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUFIJ7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 05:59:10 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:43227 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265938AbUFIJ7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 05:59:07 -0400
References: <200406082125.i58LP8rC016229@melkki.cs.helsinki.fi>
            <s5hr7sp14i7.wl@alsa2.suse.de>
In-Reply-To: <s5hr7sp14i7.wl@alsa2.suse.de>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA: Remove subsystem-specific malloc (7/8)
Date: Wed, 09 Jun 2004 12:59:05 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.40C6DF69.00003420@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

At Wed, 9 Jun 2004 00:25:08 +0300, Pekka J Enberg wrote:
> > --- linux-2.6.6/sound/arm/sa11xx-uda1341.c	2004-06-08 23:57:25.623550760 +0300
> > +++ alsa-2.6.6/sound/arm/sa11xx-uda1341.c	2004-06-05 20:30:06.000000000 +0300
> > @@ -1010,6 +1010,7 @@ static int __init sa11xx_uda1341_init(vo
> >  static void __exit sa11xx_uda1341_exit(void)
> >  {
> >  	snd_card_free(sa11xx_uda1341->card);
> > +	kfree(sa11xx_uda1341);
> >  }

On 6/9/2004, "Takashi Iwai" <tiwai@suse.de> wrote:
> this causes double-free.
> sa11xx_uda1341 is already released in snd_sa11xx_uda1341_free(),
> invoked from snd_card_free().

You're right. Sorry about that one. 

                 Pekka 
