Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269268AbTCBSh2>; Sun, 2 Mar 2003 13:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269269AbTCBSh2>; Sun, 2 Mar 2003 13:37:28 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:45325 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269268AbTCBSh1>; Sun, 2 Mar 2003 13:37:27 -0500
Subject: Re: [PATCH] kernel source spellchecker
From: Steven Cole <elenstev@mesatop.com>
To: "Jared Daniel J. Smith" <linux@trios.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030302165127Z269240-29902+1551@vger.kernel.org>
References: <20030302165127Z269240-29902+1551@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 02 Mar 2003 11:46:33 -0700
Message-Id: <1046630795.10138.495.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 11:56, Jared Daniel J. Smith wrote:
> Regarding these two cautious comments:
> 
> ==========================================================================
> I wouldn't go that far. Better give a list of speling mistakes (file/line)
> and fix them by hand. It won't need to be done more than occasionally, so
> the overhead is not too bad. --Dr. Horst H. von Brand 
> 
> It might also be worth adding a list of 'suspect' spellings -- which
> require human intervention. Such items might include 'indices=indexes'
> and 'erratum=errata' although you can't do it automatically because
> sometimes the right-hand side is actually correct. --David Woodhouse
> ==========================================================================
> 
> I fully agree.
> 
> I have tried to automatically spell-check long, complex texts for years,
> with numerous algorithms; all of them fail for one reason or another,
> and I find that the only proper way to do it is the tedious work by hand.
> 
> Even a single lost pun because of overenthusiastic spellchecking is
> not worth the cleanup. I would prefer to see typos than lose a single
> intentional 'misspelling'. It would be best if you posted all changes 
> somewhere so that they could be verified manually.

More agreement. In this case it's better to commit a sin of omission
than one of commission.  In my recent cleanups, here are three cases
which were left alone:

./arch/sparc/kernel/head.S: * Sun people can't spell worth damn. "compatability" indeed.
./drivers/net/myri_sbus.h:      u32     shakedown;              /* DarkkkkStarrr Crashesss...   */
./drivers/scsi/FlashPoint.c:      return(0);  /*We WON! Yeeessss! */

> 
> Consider the following:
> 
[snip]
> 
> Converted=Coverted
> is it a pun on something 'hidden' or is it something transformed?
> 
./drivers/media/radio/radio-aimslab.c: * Coverted to new API by Alan Cox <Alan.Cox@linux.org>
./drivers/media/radio/radio-gemtek.c: *    Coverted to new API by Alan Cox <Alan.Cox@linux.org>
./drivers/media/radio/radio-rtrack2.c: * Coverted to new API by Alan Cox <Alan.Cox@linux.org>

Alan's humor can be subtle.  Better to ask him. AC added to cc list.
I just hope he doesn't start to pun "yn Cymraeg"

Steven


