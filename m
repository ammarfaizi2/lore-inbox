Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270677AbTHOSFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270678AbTHOSFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:05:00 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:52157 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S270677AbTHOSE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:04:59 -0400
To: Greg KH <greg@kroah.com>
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <3F397FFB.9090601@pobox.com>
	<20030812171407.09f31455.rddunlap@osdl.org>
	<3F3986ED.1050206@pobox.com>
	<20030812173742.6e17f7d7.rddunlap@osdl.org>
	<20030813004941.GD2184@redhat.com>
	<32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
	<3F39AFDF.1020905@pobox.com>
	<20030813031432.22b6a0d6.davem@redhat.com>
	<20030813173150.GA3317@kroah.com> <m31xvpe2ar.fsf@defiant.pm.waw.pl>
	<20030813212611.GA6652@kroah.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 15 Aug 2003 00:46:04 +0200
In-Reply-To: <20030813212611.GA6652@kroah.com>
Message-ID: <m365kz5043.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> > +	{ PCI_DEVICE(BROADCOM, TIGON3_5700) },
> > +	{ PCI_DEVICE(BROADCOM, TIGON3_5701) },
> > 
> Someone else mentioned that to me, but that's just mean as this file
> shows that not all device ids are in the pci id table.

PCI_VENDOR_ID_xxx can be #defined in the driver as well, no problem here.
Grepping - yes, real problem.

Using one 32-bit value for two 16-bit vendor and device IDs may be
worth considering, too. Some potential problems, though, not 2.6 I think.
-- 
Krzysztof Halasa
Network Administrator
