Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVHPNiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVHPNiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVHPNit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:38:49 -0400
Received: from [81.2.110.250] ([81.2.110.250]:5594 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965224AbVHPNis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:38:48 -0400
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <58cb370e050816030248e6283c@mail.gmail.com>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <20050811203437.GA9265@infradead.org>
	 <58cb370e050816030248e6283c@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Aug 2005 15:05:52 +0100
Message-Id: <1124201152.17555.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-16 at 12:02 +0200, Bartlomiej Zolnierkiewicz wrote:
> On 8/11/05, Christoph Hellwig <hch@infradead.org> wrote:
> > On Thu, Aug 11, 2005 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > > IA64 boxes only have PCI IDE devices, so there's no need to blindly poke
> > > around in I/O port space.  Poking at things that don't exist causes MCAs
> > > on HP ia64 systems.
> > 
> > Maybe it should instead depend on those systems where it is available.
> > Anything but X86?
> 
> Don't forget that arch specific drivers use IDE_GENERIC *indirectly*
> to probe for devices.

Just about everything wants IDE GENERIC. Most of them want the probe
address providing function to simply be "return 0" or the two 'magic'
PCI bus legacy addresses. Probably only ia-32 wants to poke other
addresses and even that now checks for non-PCI first

