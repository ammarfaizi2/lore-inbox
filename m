Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVJDNXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVJDNXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 09:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJDNXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 09:23:12 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:33664 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932454AbVJDNXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 09:23:11 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20051004084533.GA59492@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
	 <1127919909.4852.7.camel@mulgrave>
	 <20050928160744.GA37975@dspnet.fr.eu.org>
	 <1127924686.4852.11.camel@mulgrave>
	 <20050928171052.GA45082@dspnet.fr.eu.org>
	 <1127929909.4852.34.camel@mulgrave>
	 <20050928183324.GA51793@dspnet.fr.eu.org>
	 <1128175434.4921.9.camel@mulgrave>
	 <20051003134210.GA10641@dspnet.fr.eu.org>
	 <1128356144.4606.11.camel@mulgrave>
	 <20051004084533.GA59492@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 09:23:01 -0400
Message-Id: <1128432181.4782.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-04 at 10:45 +0200, Olivier Galibert wrote:
> > But anyway, let's proceed on the theory that the array is having a hard
> > time.  What I need you to do is lower the speed of the array target in
> > the aic bios.  Unfortunately, the driver won't honour that setting at
> > the moment:  I'll see if I can work up the code that will do it.  The
> > attached patch will perform this artificially (for every device on every
> > aic79xx).
> 
> The mounts worked with your patch.  I'm going to start actually using
> the raid, that's going to tell us how stable it actually is.  I have
> no problems with doing other tests.

OK, that sort of confirms the theory that there's a bad interaction at
u320.  What I'll try to do is to implement the bios parameter routines
for the aic79xx and you can set it to u160 in the bios.  Since I can't
test this, would you be a guinea pig when I come up with it?

James


