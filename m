Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVBCKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVBCKsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVBCKpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:45:00 -0500
Received: from aun.it.uu.se ([130.238.12.36]:24015 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262909AbVBCKm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:42:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16898.9.429645.633109@alkaid.it.uu.se>
Date: Thu, 3 Feb 2005 11:42:17 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: tglx@linutronix.de
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>, albert_herranz@yahoo.es,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 MMCR0_PMXE saga.
In-Reply-To: <1107413930.21196.637.camel@tglx.tec.linutronix.de>
References: <20050203044702.GA1089@redhat.com>
	<1107413930.21196.637.camel@tglx.tec.linutronix.de>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner writes:
 > On Wed, 2005-02-02 at 23:47 -0500, Dave Jones wrote:
 > > I'm at a loss to explain whats been happening with this symbol.
 > 
 > The macro was duplicated in -mm1.
 > I sent a patch against -mm1
 > The patch went upstream without the perfctr-ppc.patch, which contained
 > the macro define in regs.h.
 > 
 > So a bit of confusion came up

The sane thing to do is to split -mm's perfctr-ppc.patch so that
the new symbolic constants can go into -linus w/o having to drag
in the experimental perfctr stuff from -mm.

This wasn't an issue before because the -linus kernel didn't
acquire any use of PMXE until very recently.

/Mikael
