Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbTCOUsa>; Sat, 15 Mar 2003 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbTCOUsa>; Sat, 15 Mar 2003 15:48:30 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:22312
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261541AbTCOUs3>; Sat, 15 Mar 2003 15:48:29 -0500
Date: Sat, 15 Mar 2003 15:55:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: bert hubert <ahu@ds9a.nl>
cc: dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, "" <wrlk@riede.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: Any hope for ide-scsi (error handling)?
In-Reply-To: <Pine.LNX.4.50.0303151534220.9158-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303151554230.9158-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net> <20030315202509.GA4374@outpost.ds9a.nl>
 <Pine.LNX.4.50.0303151534220.9158-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Mar 2003, Zwane Mwaikambo wrote:

> On Sat, 15 Mar 2003, bert hubert wrote:
> 
> > A construct like this was suggested for use in swsusp too to make sure that
> > only *one* request is outstanding for a controler. This was also mentioned
> > to be the unclean way and that there are taskfile interfaces which are
> > cleaner.

[snip]

> Ok so at event [1] we have a ->handler set on cpu0 so we pass that check. 
> Then cpu1 acquires ide_lock and NULLs it out. cpu0 blocks on the lock in 
> ide_set_handler and when cpu1 releases it it re-assigns ->handler. What 
> happens then?

Skip that, i forgot swsusp doesn't do SMP.

	Zwane

