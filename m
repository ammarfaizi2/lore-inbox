Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVEOJsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVEOJsz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVEOJsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:48:55 -0400
Received: from mail.dif.dk ([193.138.115.101]:30693 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262056AbVEOJsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:48:52 -0400
Date: Sun, 15 May 2005 11:52:51 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Valdis.Kletnieks@vt.edu
Cc: Borislav Petkov <petkov@uni-muenster.de>, Edgar Toernig <froese@gmx.de>,
       jmerkey <jmerkey@utah-nac.org>,
       Scott Robert Ladd <lkml@coyotegulch.com>, linux-kernel@vger.kernel.org
Subject: Re: Automatic .config generation 
In-Reply-To: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.62.0505151148220.2387@dragon.hyggekrogen.localhost>
References: <200505150742.j4F7gds1020180@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005 Valdis.Kletnieks@vt.edu wrote:

> On Sun, 15 May 2005 09:03:42 +0200, Borislav Petkov said:
> > On Thursday 12 May 2005 23:17, Edgar Toernig wrote:
> > > jmerkey wrote:
> > > > Scott Robert Ladd wrote:
> > > > >Is there a utility that creates a .config based on analysis of
> the
> > > > >target system?
> > how about /proc/config.gz.. although this was pretty recent IIRC.
> That describes the currently running kernel *as built* - so for instance
> booting a RedHat kernel on almost anything will show 3 zillion things
> built as modules - including 2.5 zillion things that aren't needed in
> the
> current config (for instance, every single sound card driver may be
> included).
> What is desired is a utility that will do an lspci/lsusb/etc and build
> up
> a .config that matches *the current hardware* (for instance, only
> including
> a module for the one sound card that's actually installed).
> 
What's the big gain? Where's the harm in just building all the sound 
modules - you only load one in the end anyway, and the space taken by the 
other modules is negligible with the disk sizes of today I'd say (ok, 
there's some extra build time involved, but that shouldn't be a big deal 
either). Or just use good old "make menuconfig" to only enable the module 
you want. Besides, it's not as if you have to redo your kernel config from 
scratch every time you want a new kernel. Make your favorite config once, 
build and install that kernel and then when you want a newer kernel simply 
either cd linux-<version>; zcat /proc/config.gz > .config ; make oldconfig 
and then build the new kernel using your previous config.

-- 
Jesper Juhl


