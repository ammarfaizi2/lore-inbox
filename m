Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVLTTXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVLTTXw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVLTTXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:23:52 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:37569 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1750949AbVLTTXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:23:51 -0500
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20051220191412.GA4578@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 20 Dec 2005 17:23:16 -0200
Message-Id: <1135106596.7822.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2005-12-20 às 20:14 +0100, Adrian Bunk escreveu:
> On Tue, Dec 20, 2005 at 10:24:55AM -0800, Linus Torvalds wrote:
> > 

> What did work was to leave sound/sound_core.c alone and make the 
> module_init() in drivers/media/video/saa7134/saa7134-alsa.c a 
> late_initcall() (plus disabling building of saa7134-oss.o because
> otherwise saa7134-alsa.o wouldn't do anything).
	We have already a patch to solve -oss and -alsa conflict against
v4l-dvb tree. I'll prepare it against -git and submit in a few minutes
to ML for you to test.

> > That should make sure that the sound core gets to initialize before normal 
> > drivers do.
> > 
> > 		Linus
> 
> cu
> Adrian
> 
Cheers, 
Mauro.

