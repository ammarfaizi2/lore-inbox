Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbTGAELY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265460AbTGAELY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:11:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265038AbTGAELX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:11:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI domain stuff
Date: 30 Jun 2003 21:25:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bdr2fn$2gg$1@cesium.transmeta.com>
References: <1057010214.1277.11.camel@albertc> <1057014182.4048.3887.camel@cube> <20030630231515.GA27813@kroah.com> <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030701040531.GB23597@parcelfarce.linux.theplanet.co.uk>
By author:    Matthew Wilcox <willy@debian.org>
In newsgroup: linux.dev.kernel
>
> On Mon, Jun 30, 2003 at 04:15:15PM -0700, Greg KH wrote:
> > > AFAIK, sysfs won't support mmap.
> > 
> > What do you want to mmap?  The PCI config space?
> 
> We need to support mmaping device resources.  I think this actually
> merits being a first class sysfs concept -- turn a struct resource into
> an mmapable file.  The current fugly ioctl really has to go.
> 

mmapping can be extremely expensive, though, if the data is expensive
to generate.  It also has concurrency issues if things can change and
data can cross page boundaries.

      -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
