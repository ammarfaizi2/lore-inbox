Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVI1Rw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVI1Rw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVI1Rw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:52:57 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:51368 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750835AbVI1Rw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:52:56 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20050928171052.GA45082@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
	 <1127919909.4852.7.camel@mulgrave>
	 <20050928160744.GA37975@dspnet.fr.eu.org>
	 <1127924686.4852.11.camel@mulgrave>
	 <20050928171052.GA45082@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 12:51:49 -0500
Message-Id: <1127929909.4852.34.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 19:10 +0200, Olivier Galibert wrote:
> On Wed, Sep 28, 2005 at 11:24:46AM -0500, James Bottomley wrote:
> > On Wed, 2005-09-28 at 18:07 +0200, Olivier Galibert wrote:
> > > scsi1:0:0:0: Attempting to abort cmd ffff8101b1cdf880: 0x28 0x0 0x0
> > > 0xbc 0x0 0x3f 0x0 0x0 0x8 0x0
> > 
> > Hmm, that message doesn't appear in the current kernel driver.
> > 
> > Is this a non-standard kernel or non-standard aic79xx driver?
> 
> Just reproduced the exact same message with a vanilla 2.6.13.2.
> Checking the just-untarred sources, it _is_ in aix79xx_osm.c, in
> ahd_linux_abort.  You must have typoed "Attempting" in your grep :-)

Oh .. apparently that message got removed between 2.6.13 and current git
head.

Is there any chance you could try this with the latest git snapshot and
post all the messages from the time the aic79xx is detected to the time
this message appears ... what I'm trying to ascertain is if anything
went wrong in negotiating with the device (2.6.13 unfortunately is a bit
terse on the negotiation messages ... git head will be slightly more
verbose).

Thanks,

James


