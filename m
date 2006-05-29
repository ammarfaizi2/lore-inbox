Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWE2HBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWE2HBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWE2HBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:01:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53712 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751260AbWE2HBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:01:17 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Arjan van de Ven <arjan@infradead.org>
To: bidulock@openss7.org
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
In-Reply-To: <20060529005705.C20649@openss7.org>
References: <1148653797.3579.18.camel@laptopd505.fenrus.org>
	 <20060528130320.GA10385@osiris.ibm.com>
	 <1148835799.3074.41.camel@laptopd505.fenrus.org>
	 <1148838738.21094.65.camel@mindpipe>
	 <1148839964.3074.52.camel@laptopd505.fenrus.org>
	 <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org>
	 <1148878368.3291.40.camel@laptopd505.fenrus.org>
	 <447A883C.5070604@opensound.com>
	 <1148883077.3291.47.camel@laptopd505.fenrus.org>
	 <20060529005705.C20649@openss7.org>
Content-Type: text/plain
Date: Mon, 29 May 2006 09:01:10 +0200
Message-Id: <1148886070.3291.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 00:57 -0600, Brian F. G. Bidulock wrote:
> Arjan,
> 
> On Mon, 29 May 2006, Arjan van de Ven wrote:
> > external modules shouldn't care, they really really should inherit the
> > cflags from the kernel's makefiles at which point.. the thing is moot.
> 
> Yes, and ultimately the kernel's makefile (if present) are the best
> place to get CFLAGS from.  However, the task of ensuring that the
> correct Makefile is present and that the correct configuration
> information is feeding it (back to .config) is distribution specific
> and not always straightforward.

eh dude what are you thinking? Documentation/kbuild very much gives you
a FULLY standardized way of doing this. On all distributions.
The only tricky part is finding the build tree, for the current kernel
that is
/lib/modules/`uname -r`/build
(as per Linus' decree from like 4 to 5 years ago)
for non-current kernels that's a bit more complex, so just ask the user.
Once you have that the rest comes for free.

