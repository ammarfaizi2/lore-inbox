Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263539AbRFAOio>; Fri, 1 Jun 2001 10:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263541AbRFAOie>; Fri, 1 Jun 2001 10:38:34 -0400
Received: from gw-yyz.somanetworks.com ([216.126.67.39]:29070 "EHLO
	somanetworks.com") by vger.kernel.org with ESMTP id <S263539AbRFAOiT>;
	Fri, 1 Jun 2001 10:38:19 -0400
Date: Fri, 1 Jun 2001 10:37:49 -0400
From: Mark Frazer <mark@somanetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
Message-ID: <20010601103749.C5248@somanetworks.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106011503030.18082-100000@kenzo.iwr.uni-heidelberg.de> <E155pmD-0000Zv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E155pmD-0000Zv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 01, 2001 at 03:19:45PM +0100
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> [01/06/01 10:32]:
> > No way! If I implement a HA application which depends on link status, I
> > want the info to be accurate, I don't want to know that 30 seconds ago I
> > had good link.
> > 
> > IMHO, rate limiting is the only solution.
> 
> Please re-read your comment. Then think about it. Then tell me how rate limiting
> differs from caching to the application.
> 

I'd argue for rate limiting as the application only gets back new data,
never a cached value n times in a row.

With caching, you'd have to let the application know when the cached
value was last read and how long it will be cached for.  With rate
limiting, you'd just block the app and get the new data to the app
once the timer has expired.  Or, if the app doesn't read the data
until after the timer has expired, it will not block at all.

Seems to me that you'd have less redundant application processing with
rate limiting.
