Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbVI1RNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbVI1RNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVI1RNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:13:05 -0400
Received: from xenotime.net ([66.160.160.81]:19941 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751423AbVI1RNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:13:04 -0400
Date: Wed, 28 Sep 2005 10:13:03 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Olivier Galibert <galibert@pobox.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Re: Infinite interrupt loop, INTSTAT = 0
In-Reply-To: <20050928171052.GA45082@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.58.0509281012320.14803@shark.he.net>
References: <20050928134514.GA19734@dspnet.fr.eu.org> <1127919909.4852.7.camel@mulgrave>
 <20050928160744.GA37975@dspnet.fr.eu.org> <1127924686.4852.11.camel@mulgrave>
 <20050928171052.GA45082@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Olivier Galibert wrote:

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

call dump_stack();

-- 
~Randy
