Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbTAZUqs>; Sun, 26 Jan 2003 15:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbTAZUqs>; Sun, 26 Jan 2003 15:46:48 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:14736 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266976AbTAZUqr>;
	Sun, 26 Jan 2003 15:46:47 -0500
Date: Sun, 26 Jan 2003 21:55:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
Message-ID: <20030126215549.E3694@ucw.cz>
References: <200301261439.PAA08423@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200301261439.PAA08423@harpo.it.uu.se>; from mikpe@csd.uu.se on Sun, Jan 26, 2003 at 03:39:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 03:39:44PM +0100, Mikael Pettersson wrote:
> On Sat, 25 Jan 2003 15:02:16 +0100, Vojtech Pavlik wrote:
> >Do the symptoms persist when you disable AT keyboard support completely?
> >(You'll need a different way to control the machine - USB or Ethernet
> >for the test.)
> 
> Disabling CONFIG_KEYBOARD_ATKBD (but keeping SERIO_I8042 and
> MOUSE_PS2 enabled) eliminates the BIOS keyboard error on my
> Latitude when rebooting after running 2.5.59.

Hmm, interesting. Can you try disabling some of the probes for extended
keyboards in atkbd.c to see if some of them could confuse your keyboard
so that the BIOS doesn't like it after boot? Also you may want to kill
the keyboard reset on reboot ... (atkbd_cleanup) ...

-- 
Vojtech Pavlik
SuSE Labs
