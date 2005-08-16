Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVHPNtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVHPNtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbVHPNtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:49:24 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:5682 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965231AbVHPNtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:49:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqlP427HxWziLyvR0vUA7KJUIIwZEhM0wAY/Sl19VdQuRXFQMi1H3IWDYv4DPjmHshq90rQloWoEunfzt0unVQrIUMfWOPO/bE9bFdEG4EDkxvLDKKBG8G943bMOEk98/Vv61ZdZ5HBS1CxZrIJfp8oHqTdt7C40iRuN413YZYw=
Message-ID: <58cb370e05081606497e4d9907@mail.gmail.com>
Date: Tue, 16 Aug 2005 15:49:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <20050816134029.GA5113@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
	 <1124196958.17555.8.camel@localhost.localdomain>
	 <20050816134029.GA5113@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/05, Matthew Wilcox <matthew@wil.cx> wrote:
> On Tue, Aug 16, 2005 at 01:55:58PM +0100, Alan Cox wrote:
> > On Maw, 2005-08-16 at 11:38 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
> > >   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)
> >
> > IA64 systems can support PCI->Cardbus/PCMCIA cards so they do actually
> > need this support. They could also do with cardbus IDE support but that
> > means a whole pile of patches still although the refcounting stuff means
> > its a lot closer to doable now
> 
> Then IDE_ARCH_OBSOLETE_INIT needs to be added back for all other
> architectures that support PCI too ...

Rather ide-cs needs to be fixed to use ide_std_init_ports() instead of
ide_init_hwif_ports() (please see my reply to Alan).

Bartlomiej
