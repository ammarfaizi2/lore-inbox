Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261916AbSIYFNA>; Wed, 25 Sep 2002 01:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261917AbSIYFNA>; Wed, 25 Sep 2002 01:13:00 -0400
Received: from bs1.dnx.de ([213.252.143.130]:8928 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S261916AbSIYFM7>;
	Wed, 25 Sep 2002 01:12:59 -0400
Date: Wed, 25 Sep 2002 07:18:01 +0200
From: Robert Schwebel <robert@schwebel.de>
To: "Michael D. Crawford" <crawford@goingware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Conserving memory for an embedded application
Message-ID: <20020925051801.GQ10741@pengutronix.de>
References: <3D91413C.1050603@goingware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3D91413C.1050603@goingware.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 12:53:16AM -0400, Michael D. Crawford wrote:
> I am helping my client design an embedded hardware device that we may
> run Linux on. An important concern is to minimize the amount of ROM
> and flash ram that the device has, both to save manufacturing cost and
> to minimize power consumption.

IMHO this isn't worth the efford. Flash is slow and (per kbyte) more
expensive than RAM, so I would'n waste too much time on this if you
don't plan to make more than >10000 pieces of your device. If you care
for power consumption use another architecture than x86. 

> It would also be helpful if a filesystem image containing a user program 
> could be burned into flash, and then the program run directly out of flash. 

Use jffs2 for the root file system. 

> Also, what is the minimum amount of physical ram that you think I can
> get any version of the kernel later than 2.0 or so to run in?  I heard
> somewhere that someone can boot an x86 system with as little as 2MB of
> RAM. Is that the case?

This depends on which drivers you need, how much stuff you need in
userspace and how memory hungry your application is. Running a 2.4
kernel with busybox/uclibc in 2 MB RAM is possible. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
