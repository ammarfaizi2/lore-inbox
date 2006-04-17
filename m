Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDQUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDQUAm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWDQUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:00:42 -0400
Received: from sc-outsmtp2.homechoice.co.uk ([81.1.65.36]:19721 "HELO
	sc-outsmtp2.homechoice.co.uk") by vger.kernel.org with SMTP
	id S1750834AbWDQUAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:00:41 -0400
Subject: Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa AICA on Sega
	Dreamcast
From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060417012913.GA16821@linux-sh.org>
References: <1145232784.12804.2.camel@localhost.localdomain>
	 <20060417012913.GA16821@linux-sh.org>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 21:00:36 +0100
Message-Id: <1145304037.9244.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > +	/* AICA has no capture ability */
> > +	if ((err =
> > +	     snd_pcm_new(dreamcastcard->card, "AICA PCM", pcm_index, 1, 0,
> > +			 &pcm)) < 0)
> > +		return err;
> 
> Weird notation, linux kernel style would be:
> 
> 	err = snc_pcm_new(...);
> 	if (unlikely(err < 0))
> 		return err;
> 
> please refactor accordingly.
> 

Actually this sort of formulation is common in the kernel as any grep
will show. In fact I copied it directly from the guide to writing ALSA
drivers:

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x447.htm

But I am happy to change it.

