Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSHJWw0>; Sat, 10 Aug 2002 18:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSHJWvm>; Sat, 10 Aug 2002 18:51:42 -0400
Received: from diale094.ppp.lrz-muenchen.de ([129.187.28.94]:36765 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317362AbSHJWvk>; Sat, 10 Aug 2002 18:51:40 -0400
Subject: Re: mmapping large files hits swap in 2.4?
From: Daniel Egger <degger@fhm.edu>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0208101437380.838-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.33.0208101437380.838-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 11 Aug 2002 00:19:59 +0200
Message-Id: <1029018000.2539.7.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sam, 2002-08-10 um 20.49 schrieb Mark Hahn:

> > It is just that it seems the mmaped region is not really bakked by
> > the underlying file but by swap space which was exactly what I 
> > was trying to avoid by using a file.

> why do you think that?

Because the amount of free swap shrinks continously with mmaped memory
being touched. If I understood the concept of mmap correctly the system
should buffer read/writes to the mapped memory location with real RAM
and page out to the file.

My problem actually is that although I have enough memory to buffer the
whole area the kernel decides to hit hard on the disc which makes the
performance suck.

-- 
Servus,
       Daniel

