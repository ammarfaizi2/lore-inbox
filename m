Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272187AbRIJXhy>; Mon, 10 Sep 2001 19:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272182AbRIJXho>; Mon, 10 Sep 2001 19:37:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:37893 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S272164AbRIJXh1>;
	Mon, 10 Sep 2001 19:37:27 -0400
Message-ID: <XFMail.20010911013717.ast@domdv.de>
X-Mailer: XFMail 1.4.6-3 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200109102306.f8AN6iY21834@aslan.scsiguy.com>
Date: Tue, 11 Sep 2001 01:37:17 +0200 (CEST)
Organization: D.O.M. Datenverarbeitung GmbH
From: Andreas Steinmetz <ast@domdv.de>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <SPATZ1@t-online.de (Frank Schneider)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> MD (line 3475 of drivers/md/md.c) uses 0 too.  Change it to INT_MAX
> and MD will always get shutdown prior to any child devices it might

I don't believe INT_MAX to be a good idea. What happens if anything else needs
to shutdown prior to md (think of tux, knfsd)? As a suggestion it would be a
good idea if someone with a broader overview would define some reboot
priorities in include/linux/notifier.h.


Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH
