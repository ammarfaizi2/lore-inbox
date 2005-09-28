Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbVI1RYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbVI1RYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVI1RYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:24:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751455AbVI1RYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:24:23 -0400
Subject: Re: Infinite interrupt loop, INTSTAT = 0
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20050928171052.GA45082@dspnet.fr.eu.org>
References: <20050928134514.GA19734@dspnet.fr.eu.org>
	 <1127919909.4852.7.camel@mulgrave>
	 <20050928160744.GA37975@dspnet.fr.eu.org>
	 <1127924686.4852.11.camel@mulgrave>
	 <20050928171052.GA45082@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 19:24:08 +0200
Message-Id: <1127928249.2893.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
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
> 
> Want be to try to BUG() it or something to get a stack trace?  The
> crash happens a handful of seconds after the card dumping, time enough
> for a well-placed dmesg in an xterm.
> 
> Incidentally, how can one get a backtrace without crashing the kernel
> in the operation?

WARN_ON(1)



