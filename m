Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272192AbRIJXqO>; Mon, 10 Sep 2001 19:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272188AbRIJXqF>; Mon, 10 Sep 2001 19:46:05 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:59666 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272192AbRIJXpx>; Mon, 10 Sep 2001 19:45:53 -0400
Message-Id: <200109102346.f8ANkAY23472@aslan.scsiguy.com>
To: Andreas Steinmetz <ast@domdv.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SPATZ1@t-online.de (Frank Schneider)
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors) 
In-Reply-To: Your message of "Tue, 11 Sep 2001 01:37:17 +0200."
             <XFMail.20010911013717.ast@domdv.de> 
Date: Mon, 10 Sep 2001 17:46:10 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> MD (line 3475 of drivers/md/md.c) uses 0 too.  Change it to INT_MAX
>> and MD will always get shutdown prior to any child devices it might
>
>I don't believe INT_MAX to be a good idea. What happens if anything else needs
>to shutdown prior to md (think of tux, knfsd)?

Your examples are processes (albeit in the kernel) which should have
received a signal long before the notifier chain is called.

>As a suggestion it would be a
>good idea if someone with a broader overview would define some reboot
>priorities in include/linux/notifier.h.

And expand the codes that are used for the notifier.  The current set
of codes are not well defined and most drivers treat all of them the
same.

--
Justin
