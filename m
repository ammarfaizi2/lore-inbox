Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKGRb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKGRb4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUKGRbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:31:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261669AbUKGRaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:30:04 -0500
Date: Sun, 7 Nov 2004 18:29:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small input cleanup
Message-ID: <20041107172929.GM14308@stusta.de>
References: <20041107031256.GD14308@stusta.de> <200411062249.54887.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411062249.54887.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 10:49:54PM -0500, Dmitry Torokhov wrote:

> Hi,

Hi Dmitry,

> On Saturday 06 November 2004 10:12 pm, Adrian Bunk wrote:
> > The patch below does the following cleanups under drivers/input/ :
> > - make some needlessly global code static
> > - remove the completely unused EXPORT_SYMBOL'ed function gameport_rescan
> 
> It will be used (but in some transformed) once I finish gameport sysfs
> support, but it probably need not be exported.
>  
> > - make the EXPORT_SYMBOL'ed function ps2_sendbyte static since it isn't
> >   used outside the file where it's defined
> 
> libps2 is a library for communicating with standard PS/2 device and while
> the function is not currently used it is part of the interface. I would
> like to leave the function as is.

my personal opinions:
- if gameport_rescan will not be needed in it's current form, there's
  no need for it (you can always add the "real" function when it's 
  required
- could ps2_sendbyte be #ifdef 0'ed until it's required?
  this way, it wouldn't make the kernel bigger today

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

