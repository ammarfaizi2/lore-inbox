Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272201AbRIKAA4>; Mon, 10 Sep 2001 20:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272199AbRIKAAq>; Mon, 10 Sep 2001 20:00:46 -0400
Received: from hermes.domdv.de ([193.102.202.1]:34054 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272198AbRIKAAd>;
	Mon, 10 Sep 2001 20:00:33 -0400
Message-ID: <XFMail.20010911020024.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200109102346.f8ANkAY23472@aslan.scsiguy.com>
Date: Tue, 11 Sep 2001 02:00:24 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
Cc: (Frank Schneider) <SPATZ1@t-online.de>
Cc: <SPATZ1@t-online.de (Frank Schneider)>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Sep-2001 Justin T. Gibbs wrote:
>>> MD (line 3475 of drivers/md/md.c) uses 0 too.  Change it to INT_MAX
>>> and MD will always get shutdown prior to any child devices it might
>>
>>I don't believe INT_MAX to be a good idea. What happens if anything else
>>needs
>>to shutdown prior to md (think of tux, knfsd)?
> 
> Your examples are processes (albeit in the kernel) which should have
> received a signal long before the notifier chain is called.
> 

Granted. I could, however, imagine a fs to require a reboot notifier and that
would need definitely be processed before md.

>>As a suggestion it would be a
>>good idea if someone with a broader overview would define some reboot
>>priorities in include/linux/notifier.h.
> 
> And expand the codes that are used for the notifier.  The current set
> of codes are not well defined and most drivers treat all of them the
> same.
> 

Just posted sort of this request to the list.

> --
> Justin
> 

Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
