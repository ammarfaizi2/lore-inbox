Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWIPIou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWIPIou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 04:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWIPIou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 04:44:50 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:1670 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S964802AbWIPIot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 04:44:49 -0400
Date: Sat, 16 Sep 2006 10:44:34 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Doug Ledford <dledford@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060916084434.GA5161@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de> <1157490066.3463.73.camel@mulgrave.il.steeleye.com> <20060906110147.GA12101@aepfle.de> <1157551480.3469.8.camel@mulgrave.il.steeleye.com> <20060907091517.GA21728@aepfle.de> <1157637874.3462.8.camel@mulgrave.il.steeleye.com> <1158378424.2661.150.camel@fc6.xsintricity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1158378424.2661.150.camel@fc6.xsintricity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, Doug Ledford wrote:

> Sorry for my belated response, but this usually happens when you access
> an aic chipset too soon after a chip reset.  Try putting a delay before
> whatever access is causing this to see if it make s difference.  Common
> problems include after a chip reset, touching any register will cause
> the card to reset, etc.

I put a ssleep(1) before the ahc_inb(ahc, SBLKCTL);
Does not help. Is it possible that the card loses some of its features
during reset and something needs to be done to reenable them?
