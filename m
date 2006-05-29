Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWE2MXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWE2MXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWE2MXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:23:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3714 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750703AbWE2MXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:23:52 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <447A9D28.9010809@opensound.com>
References: <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org>
	 <1148878368.3291.40.camel@laptopd505.fenrus.org>
	 <447A883C.5070604@opensound.com>
	 <1148883077.3291.47.camel@laptopd505.fenrus.org>
	 <20060529005705.C20649@openss7.org>  <447A9D28.9010809@opensound.com>
Content-Type: text/plain
Date: Mon, 29 May 2006 14:23:48 +0200
Message-Id: <1148905428.3291.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 00:05 -0700, 4Front Technologies wrote:
> Brian F. G. Bidulock wrote:
> > Arjan,
> > 
> > On Mon, 29 May 2006, Arjan van de Ven wrote:
> >> external modules shouldn't care, they really really should inherit the
> >> cflags from the kernel's makefiles at which point.. the thing is moot.
> > 
> > Yes, and ultimately the kernel's makefile (if present) are the best
> > place to get CFLAGS from.  However, the task of ensuring that the
> > correct Makefile is present and that the correct configuration
> > information is feeding it (back to .config) is distribution specific
> > and not always straightforward.
> > 
> > --brian
> > 
> > 
> 
> 
> How about external modules that have a kernel dependant part and kernel 
> independant part?.

tough luck :)

>  Kernel independant part could live in a separate tree and
> has its own makefiles.

as long as those makefiles inherit the proper CFLAGs it's no big deal.
If not then you need to glue them together properly, but thankfully the
GPL gives you the freedom to tinker with the sources you get so you can
do that.

> But regparm requires that ALL parts linked into the module need to have regparm 
> defined. So it's another headache to write makefiles for the kernel independant 
> part to figure out if the distro support regparm or not.

just inherit the cflags. You need to have matching cflags and compiler
anyway for many other reasons; this one is no exception.


