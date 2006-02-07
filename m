Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWBGAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWBGAlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWBGAlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:41:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:24742 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964807AbWBGAls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:41:48 -0500
Date: Tue, 7 Feb 2006 01:41:47 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
       Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060207004147.GA21620@MAIL.13thfloor.at>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Arjan van de Ven <arjan@infradead.org>, Mark Lord <lkml@rtr.ca>,
	Ulrich Mueller <ulm@kph.uni-mainz.de>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
	Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>
References: <43C40803.2000106@rtr.ca> <20060201222314.GA26081@MAIL.13thfloor.at> <uhd7irpi7@a1i15.kph.uni-mainz.de> <Pine.LNX.4.61.0602022144190.30391@yvahk01.tjqt.qr> <43E3DB99.9020604@rtr.ca> <Pine.LNX.4.61.0602041204490.30014@yvahk01.tjqt.qr> <1139153913.3131.42.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602052212430.330@yvahk01.tjqt.qr> <1139174355.3131.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602061554550.31522@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 03:56:34PM +0100, Jan Engelhardt wrote:
> >> >> What userspace programs do depend on it?
> >> >
> >> >there is a lot of userspace that assumes they can do 2Gb or even close
> >> >to 3Gb of memory allocations. Databases, java, basically anything with
> >> >threads. Sure for most of these its a configuration option to reduce
> >> >this, but that still doesn't mean it's a good idea to change from the
> >> >existing behavior...
> >> > 
> >> Not to mention that these (almost(*)) fail anyway when you have less than 2 
> >> GB of RAM.
> >
> >it's not really overcommit... it can also be file mmaps or shared mmaps
> >of say tmpfs files (the later is common with oracle actually)
> 
> So, just as I did in the sample patch, the manual split shall depend on 
> EMBEDDED. Those who run fat databases with big malloc/mmap assumptions 
> don't probably belong to the group using CONFIG_EMBEDDED.

*sigh* well, the embeded folks are unlikely to have 1-3GB
why not use EXPERIMENTAL if you 'think' the option will
hurt the database folks who do not know to configure their
kernel ...

best,
Herbert

> Jan Engelhardt
> -- 
