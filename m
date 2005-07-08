Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVGHLnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVGHLnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVGHLnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:43:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31206 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262578AbVGHLnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:43:40 -0400
Date: Fri, 8 Jul 2005 13:45:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Grant Coady <grant_lkml@dodo.com.au>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050708114503.GG7050@suse.de>
References: <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org> <20050708084817.GB7050@suse.de> <20050708102056.GA7172@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708102056.GA7172@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08 2005, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > But! I used hdparm -t solely, 2.6 was always ~5% faster than 2.4. But 
> > using -Tt slowed down the hd speed by about 30%. So it looks like some 
> > scheduler interaction, perhaps the memory timing loops gets it marked 
> > as batch or something?
> 
> to check whether that could be the case, could you try:
> 
> 	nice -n -20 hdparm -t /dev/hdc
> 
> does that produce different results?

Same result, see my next mail, it turned out to be a read-ahead bug.

-- 
Jens Axboe

