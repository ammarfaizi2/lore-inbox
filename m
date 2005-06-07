Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVFGIEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVFGIEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 04:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVFGIEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 04:04:23 -0400
Received: from web25804.mail.ukl.yahoo.com ([217.12.10.189]:26473 "HELO
	web25804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261688AbVFGIEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 04:04:14 -0400
Message-ID: <20050607080404.96919.qmail@web25804.mail.ukl.yahoo.com>
Date: Tue, 7 Jun 2005 10:04:04 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Advices for a lcd driver design. (suite)
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050606194437.GB3155@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Pavel Machek <pavel@ucw.cz> a écrit :

> Hi!
> 
> > 
> > I posted an email 1 month ago because I was looking for advices to design
> > a driver for a lcd device (128x64 pixels) with a t6963c controller.
> 
> Ugh, whats wrong with standard handling via framebuffer?
> 

well I already looked at framebuffers and choose to not use them because
t6963c controller does not have a frame buffer memory that can be accessed
by using mmap. It must be accessed through data write commands. So I decided
to not use them in order to save code space and speed up things.

am I wrong in my choice ?

> > I have finally choosen a console implementation to interact with the lcd.
> It
> > allows me to reuse code that deals with escape character or to start a
> getty on
> > it. Unfortunately this implemenatation doens't support lcd's graphical
> mode.
> > So I wrote another small driver that can be accessed through "/dev/lcd". It
> > drives the lcd only in graphical mode. That means that a "echo foo >
> /dev/lcd"
> > command won't work as expected.
> 
> Look at framebuffer, that's what you want. See for example vesafb.
> 

Does frame buffer have such mechanism ? if so could you point me the code that
handles it ?

cheers,

           Francis



	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com
