Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbVLMUa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbVLMUa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbVLMUa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:30:59 -0500
Received: from sd291.sivit.org ([194.146.225.122]:38926 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751256AbVLMUa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:30:58 -0500
Subject: sonypi searching new maintainer (Was: Re: [RFT] Sonypi: convert to
	the new platform device interface)
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Mattia Dongili <malattia@linux.it>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
References: <200512130219.41034.dtor_core@ameritech.net>
	 <20051213183248.GA3606@inferi.kami.home>
	 <d120d5000512131104x260fdbf2mcc58fb953559fec5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 13 Dec 2005 21:30:55 +0100
Message-Id: <1134505855.9642.28.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 13 décembre 2005 à 14:04 -0500, Dmitry Torokhov a écrit :

> On 12/13/05, Mattia Dongili <malattia@linux.it> wrote:
>                            ^^^^^^^^
> > this should be irq_list->irq
> >
> > other than that seems to work here on a type2 model:

Thanks you very much for testing Mattia. Oh, and thanks to you too
Dmitry for your continuous maintenance :)

This is probably an appropriate moment to announce my resignation from
the sonypi maintainership.

After five years, I found myself less and less interested in working on
this driver, and more and more frustrated by the Sony complete lack of
support. They ignored all the requests for documentation I and several
others made, both from outside and from inside Sony. They also keep
changing the hardware interfaces, so it has become increasingly
difficult to support the newer Vaios in sonypi. 

At this point, I wouldn't recommend anyone buying a Sony laptop. Other
manufacturers are more Linux-friendly and overall their laptops are much
better supported under Linux than the Sony's.

I already did the switch myself a few months ago, buying an Apple
Powerbook, and today I am very glad I did.

I am still answering to the sonypi related questions for the time being
but if someone is interested in taking over, just contact me. Otherwise,
I will submit a patch marking the driver as unmaintained in a few days.
 
The meye driver (MotionEye camera for the PictureBook C1 series) is also
going the same path, but since the hardware is not produced anymore (and
hasn't been for a long time now), I don't expect it to find another
maintainer.

> > sonypi: unknown event port1=0x0f,port2=0x05
[...]
> > Oh, there seems to be a spurious interrupt happening at modules
> > insertion (I suspect sonypi_enable triggering and ignoring it), but this
> > happens with the old module too and I never noticed it before. Wouldn't
> > make more sense to print the warning even if verbose=0 to be able to
> > catch it timely? I mean it's since 2.4 times I don't enable verbose mode
> > in sonypi...
> >
> Probably, let's see what Stelian will say.

This is the "ok I'm loaded" event. I am not sure this event is available
on all the sonypi supported platforms, that's why it hasn't been defined
as a known event. And it doesn't make much sense to forward it anyways.

I would leave it like it is now.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

