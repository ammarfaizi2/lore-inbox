Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274973AbTHFJMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274977AbTHFJMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:12:22 -0400
Received: from [195.141.226.27] ([195.141.226.27]:54799 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S274973AbTHFJMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:12:20 -0400
Subject: Re: [Dri-devel] [trunk] Regression with latest 2.4.22-rc1 kernel
	(r200)
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: DRI-Devel <dri-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
In-Reply-To: <200308060725.56259.Dieter.Nuetzel@hamburg.de>
References: <200308060725.56259.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=UTF-8
Organization: Debian, XFree86
Message-Id: <1060161135.32133.26.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 11:12:16 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 07:25, Dieter Nützel wrote:
> The 2.4.22-rc1 radeon.o module is outdate of course.
> But the DRI CVS radeon.o module wouldn't load any longer.
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 941M
> agpgart: Detected AMD 760MP chipset
> agpgart: AGP aperture is 64M @ 0xe8000000
> 
> SunWave1 /opt/Mesa# modprobe radeon
> /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: unresolved symbol 
> flush_tlb_all
> /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: insmod 
> /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o failed
> /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: insmod radeon 
> failed

The kernel basically needs to export flush_tlb_all.

However, it's probably not really needed for your hardware (it's only
needed for AGP bridges which don't provide direct CPU access to the
aperture), so if somebody knows a more sophisticated way to handle this,
I'm all ears.


-- 
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer

