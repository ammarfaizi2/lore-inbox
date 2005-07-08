Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbVGHKVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbVGHKVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 06:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVGHKVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 06:21:46 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58789 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262449AbVGHKVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 06:21:32 -0400
Date: Fri, 8 Jul 2005 12:20:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Grant Coady <grant_lkml@dodo.com.au>,
       Ondrej Zary <linux@rainbow-software.org>,
       =?iso-8859-1?Q?Andr=E9?= Tomt <andre@tomt.net>,
       Al Boldi <a1426z@gawab.com>,
       "'Bartlomiej Zolnierkiewicz'" <bzolnier@gmail.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [git patches] IDE update
Message-ID: <20050708102056.GA7172@elte.hu>
References: <1120567900.12942.8.camel@linux> <42CA84DB.2050506@rainbow-software.org> <1120569095.12942.11.camel@linux> <42CAAC7D.2050604@rainbow-software.org> <20050705142122.GY1444@suse.de> <6m8mc1lhug5d345uqikru1vpsqi6hciv41@4ax.com> <Pine.LNX.4.58.0507051748540.3570@g5.osdl.org> <nljmc1h40t2bv316ufij10o2am5607hpse@4ax.com> <Pine.LNX.4.58.0507052209180.3570@g5.osdl.org> <20050708084817.GB7050@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708084817.GB7050@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> But! I used hdparm -t solely, 2.6 was always ~5% faster than 2.4. But 
> using -Tt slowed down the hd speed by about 30%. So it looks like some 
> scheduler interaction, perhaps the memory timing loops gets it marked 
> as batch or something?

to check whether that could be the case, could you try:

	nice -n -20 hdparm -t /dev/hdc

does that produce different results?

	Ingo
