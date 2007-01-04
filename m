Return-Path: <linux-kernel-owner+w=401wt.eu-S965103AbXAEAbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbXAEAbl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbXAEAbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:31:40 -0500
Received: from avg194.internetdsl.tpnet.pl ([83.18.32.194]:38203 "EHLO
	server.galeria-m.art.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965103AbXAEAbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:31:40 -0500
X-Greylist: delayed 2537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 19:31:40 EST
Subject: Re: [Sdhci-devel] sdhci ubuntu problem.
From: emilus <emilus@galeria-m.art.pl>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Alex Dubov <oakad@yahoo.com>, sdhci-devel <sdhci-devel@list.drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <459C1E71.5010805@drzeus.cx>
References: <1167089660.5837.6.camel@wpilap> <45951D8D.2090200@drzeus.cx>
	 <1167408325.4306.10.camel@wpilap> <4597A4C5.8030008@drzeus.cx>
	 <1167780471.3666.17.camel@localhost>  <459C1E71.5010805@drzeus.cx>
Content-Type: text/plain; charset=utf-8
Date: Fri, 05 Jan 2007 00:47:27 +0100
Message-Id: <1167954447.4964.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 03-01-2007, śro o godzinie 22:21 +0100, Pierre Ossman napisał(a):
> emilus wrote:
> > Uff... 
> > I just change system back to debian because of other problems with
> > Ubuntu.
> > And suprise ... SD doesn't work! I'm very suprised...
> > There was no problem before. Card reader works with 2GB cards too and
> > everything was fine.
> > So I have installed the newest kernel 2.6.19 without succes.
> > but I found that there is a specific drivers for my TI (in 2.6.19) so I
> >   
> 
> Ah... didn't notice that it was a TI controller you had. Then you
> usually need an ugly setpci hack for it to work with sdhci. But the new
> tifm_sd driver is the preferred solution.
> 
> > try it. And nothing better... but.
> > when card is inserted in card reader at boot time sth. happen.
> > I attach dmesg with it.
> >   
> 
> As you have ndiswrapper rearing its ugly head just above, I would guess
> it starts up your wlan card at interrupt 21 and kills it. I would
> suggest trying without ndiswrapper loaded.
> 
> As this is now a tifm_sd related issue, I would recommend that Alex
> Dubov takes over and the list of choice being the kernel mailing list
> (both cc:d).

Ok...
I started fight with tifm driver. I made a 2.6.18 kernel from debian by
debian way with mmc debug enabled and downloaded tifm source v. 0.6.
I made this module separately just by make/make install.
I put 

tifm_7xx1
tifm_sd 

into /etc/modules.
and everything working perfect.
there is no ndiswrapper problem with irq.

thx for help
ew

