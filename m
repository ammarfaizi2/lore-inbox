Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbWJCVJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbWJCVJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWJCVJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:09:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45458 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030553AbWJCVJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:09:28 -0400
Subject: Re: [PATCH 00/43] V4L/DVB updates for 2.6.19
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610031349500.3952@g5.osdl.org>
References: <20061003182228.PS25158600000@infradead.org>
	 <Pine.LNX.4.64.0610031349500.3952@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 03 Oct 2006 18:08:49 -0300
Message-Id: <1159909729.4787.54.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Ter, 2006-10-03 às 13:50 -0700, Linus Torvalds escreveu:
> 
> On Tue, 3 Oct 2006, mchehab@infradead.org wrote:
> > 
> > Please pull these from master branch at:
> >         kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
> 
> What about this?
> 
>   drivers/media/dvb/dvb-usb/Kconfig:72:warning: 'select' used by config 
>   symbol 'DVB_USB_DIB0700' refer to undefined symbol 'DVB_DIB7000M'
> 
> Hmm?
We are working on this. 

There are some Dib0700 boards that have a newer frontend (DIB7000M).
Unfortunately, the frontend driver were not finished yet and will go
only to 2.6.20.

However, there are several already supported DIB0700 that don't require
the newer frontend and should go to 2.6.19. So, it is just a matter of
fixing Kconfig, removing the (still) unused symbol.

I'll send you the fix until tomorrow, after having an ack from Patrick
(the author of DIB drivers).

> 
> 		Linus
Cheers, 
Mauro.

