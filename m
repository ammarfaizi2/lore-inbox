Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTKRN23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKRN22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:28:28 -0500
Received: from gaia.cela.pl ([213.134.162.11]:30981 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262608AbTKRN2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:28:21 -0500
Date: Tue, 18 Nov 2003 14:26:41 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Christian Axelsson <smiler@lanil.mine.nu>
cc: Pontus Fuchs <pof@users.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <3FBA15B7.7030906@lanil.mine.nu>
Message-ID: <Pine.LNX.4.44.0311181422300.29639-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pontus Fuchs wrote:
> > Hi,
> > 
> > Since some vendors refuses to release specs or even a binary
> > Linux-driver for their WLAN cards I desided to try to solve it myself by
> > making a kernel module that can load Ndis (windows network driver API)
> > drivers. I'm not trying to implement all of the Ndis API but rather
> > implement the functions needed to get these unsupported cards working.
> 
> Sounds like a plan!

Definetely agree - question though, are you loading these drivers into 
ring 0 (kernel space)?  As far as I know linux only supports ring 0 
(kernel) and 3 (userspace).  However this would seem to be the perfect 
place to load the binary modules in ring 1 (or even userspace if that was 
possible...).  I can't say I trust any binary only and/or windows driver 
to not make a mess of my kernel :)  actually the driver may actually be 
errorless - it's just designed for a different operating system and thus 
some unexplainable misshaps could easily happen...

While we're at it, loading binary only modules into ring 1 would probably 
also be a good idea for the NV module et al.  Although I have no idea how 
hard it would be to make ring 1 function (and whether there actually is 
any point to doing it in ring 1 instead of ring 3 with iopl/ioperm anyway) 
and how big the performance penalty for non-ring 0 would be...

Cheers,
MaZe.


