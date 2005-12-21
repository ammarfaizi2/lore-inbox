Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVLUUtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVLUUtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLUUtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:49:21 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:23468 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1751182AbVLUUtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:49:20 -0500
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <s5hslsmzg2y.wl%tiwai@suse.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
	 <20051220202325.GA3850@stusta.de>
	 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org>
	 <43A86DCD.8010400@superbug.co.uk> <20051220211359.GA5359@stusta.de>
	 <Pine.LNX.4.64.0512201405550.4827@g5.osdl.org>
	 <s5hslsmzg2y.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 21 Dec 2005 18:49:00 -0200
Message-Id: <1135198140.7419.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2005-12-21 às 15:21 +0100, Takashi Iwai escreveu:
> > So I'd much rather either fix one single sound driver (that can't
> mess up 
> > anything else), or fix the sound _core_ to just initialize in the
> right 
> > place. Moving _all_ sound drivers earlier sounds risky as hell, for
> no 
> > good reason.
> 
> Agreed, it looks too radical at this stage
Agreed.
> 
> Another workaround is to move the relevant module to sound/* directory
> in order to get a sane initialization order.  It's nothing but a
> workaround, though. 
hmmm... this may break saa7134 code, since alsa stuff is dependent of
saa7134.ko.

Cheers, 
Mauro.

