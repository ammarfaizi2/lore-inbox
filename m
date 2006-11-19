Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756776AbWKSQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbWKSQuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 11:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbWKSQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 11:50:20 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1756776AbWKSQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 11:50:19 -0500
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
From: Arjan van de Ven <arjan@infradead.org>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061119152421.GB19613@rhun.ibm.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061117142145.GX31879@stusta.de>
	 <20061117143236.GA23210@devserv.devel.redhat.com>
	 <20061118000629.GW31879@stusta.de>
	 <1163929632.31358.481.camel@laptopd505.fenrus.org>
	 <20061119095258.GK3735@rhun.zurich.ibm.com>
	 <20061119140600.GG31879@stusta.de>  <20061119152421.GB19613@rhun.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 19 Nov 2006 17:50:09 +0100
Message-Id: <1163955010.31358.529.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-19 at 17:24 +0200, Muli Ben-Yehuda wrote:
> On Sun, Nov 19, 2006 at 03:06:00PM +0100, Adrian Bunk wrote:
> 
> > unmaintained != not used
> > 
> > As an example, some people might be unhappy if the floppy driver that is 
> > unmaintained for ages and not in a good state was removed.
> 
> I understand. However, if it was slated to be removed, said people
> might be inclined to start maintaining it. We have a bar for inclusion
> of new code into the tree - why shouldn't a quality bar also be
> applied to old code in the tree?

this bypasses the convenient fact that there are 2 types of
unmaintained:

1) Drivers that barely, if at all, limp along and nobody has hw for
2) Drivers that no one person is the declared maintainer, but which do
get fixed when they break by "someone"

floppy.c is of the later kind; the hardware is widespread enough to make
that feasible I suppose; while the former kind are mostly ISA slot cards
that virtually nobody has (or only people who can't or don't want to
care about the linux kernel driver; a bunch of serial expander drivers
and a whole lot of the ISDN drivers falls in this category)

marking the category 1) drivers that limp along as "don't warn on
deprecated" is sort of fair; they're not far enough down deathrow yet
that they can be removed entirely, yet they also shouldn't clutter up
the build logs and they shouldn't prevent us from deprecating APIs that
are truely broken (*_sleep_on(), cli() etc) in 2.6 kernels...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

