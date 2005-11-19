Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVKSIoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVKSIoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 03:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbVKSIoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 03:44:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26543 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750971AbVKSIog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 03:44:36 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1132351635.5238.12.camel@localhost.localdomain>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
	 <1132342590.25914.86.camel@localhost.localdomain>
	 <1132348998.2830.80.camel@laptopd505.fenrus.org>
	 <1132351635.5238.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 19 Nov 2005 09:44:25 +0100
Message-Id: <1132389865.2829.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 22:07 +0000, Alan Cox wrote:
> On Gwe, 2005-11-18 at 22:23 +0100, Arjan van de Ven wrote:
> > 1) accessing non-ram memory (eg PCI mmio space) by X and the likes
> >    (ideally should use sysfs but hey, changing X for this will take 
> >    forever)
> 
> Once sysfs supports the relevant capabilities fixing X actually doesn't
> look too horrible

I think the kernel already supports this since at least july if not
earlier. If there's something missing... someone needs to speak up..

(yes vga arbitrage is missing but well that's not there today by any
means either so not a regression)

> , the PCI mapping routines are abstracted and done by
> PCITAG (ie PCI device). You would need the ISA hole too in some cases.

this may need /dev/mem a bit longer, but hopefully is rarer. Once the
pci side is fixed I bet this only is easy to do as well


