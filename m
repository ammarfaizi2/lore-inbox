Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSBJUeR>; Sun, 10 Feb 2002 15:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSBJUeJ>; Sun, 10 Feb 2002 15:34:09 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:31752 "HELO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with SMTP
	id <S289084AbSBJUd6>; Sun, 10 Feb 2002 15:33:58 -0500
Date: Sun, 10 Feb 2002 21:33:59 +0100
From: Jan Hudec <bulb@ucw.cz>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How do I get "make install" to handle GRUB?
Message-ID: <20020210213359.A32719@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1013371603.29598.4.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013371603.29598.4.camel@turbulence.megapathdsl.net>; from miles@megapathdsl.net on Sun, Feb 10, 2002 at 12:06:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have GRUB installed with RH 7.2.  I build and test 
> the development kernel series.  How can I get "make install"
> to work with GRUB?  It seems like maybe we need a "install-grub"
> target or we need to have a way to automatically determine the
> bootloader being used and then do corresponding install method.

GRUB package should have provided /sbin/installkernel script to take
care of this properly - or some other package should have.
(In debian it's in debianutils).

Anyway - you can always provide this script yourself. Makefile gives it
four arguments: version, path to zImage, path to System.map, intall-direcotry
(the install directory is whatever is defined in kernel Makefile and if you
are not using the default (/), you can override it here)

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
