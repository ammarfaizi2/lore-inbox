Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285243AbRLVARR>; Fri, 21 Dec 2001 19:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285227AbRLVAQ5>; Fri, 21 Dec 2001 19:16:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285230AbRLVAQx>; Fri, 21 Dec 2001 19:16:53 -0500
Subject: Re: Concerning a driver rewrite (NOT THE KERNEL)
To: camel_3@hotmail.com (victor1 torres)
Date: Sat, 22 Dec 2001 00:26:58 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <F134DovvQ0Puz63Bma4000031b8@hotmail.com> from "victor1 torres" at Dec 21, 2001 06:45:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ha0A-00026D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You driver also seems to be assuming the sound
> driver has initialised the codec bus and codecs.) How could I fix it if the 
> sound codec is not initialised so that the modem codec could initialised  
> the codec bus and codecs?

As far as I can tell from a scan of the docs you need the drivers to
co-operate because if that isn't done if the modem driver inits the AC97
then it will break running audio (and vice versa). The sound driver also
has the interrupt line and status handling so that appears to need to 
become shared code - or with the sound driver calling out to the modem
driver.

My i810 board doesn't have a modem or an AMR slot but I can certainly help
integrate the pieces. Right now Doug Ledford is doing major reworking on
the i810 driver (and having tried to fix audio bugs in that before I 
really appreciate him taking on that battle) but after that I'm happy to
give you a hand
