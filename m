Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSJ0Ugf>; Sun, 27 Oct 2002 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJ0Ugf>; Sun, 27 Oct 2002 15:36:35 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:36860 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262604AbSJ0Uge>; Sun, 27 Oct 2002 15:36:34 -0500
Date: Sun, 27 Oct 2002 12:42:48 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Greg KH <greg@kroah.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021027124248.A8019@lucon.org>
References: <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com> <20021026165315.A15269@lucon.org> <3DBB2BE7.70208@pobox.com> <3DBB2DB9.3000803@pobox.com> <20021026172526.A15641@lucon.org> <20021027174249.GA12811@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021027174249.GA12811@kroah.com>; from greg@kroah.com on Sun, Oct 27, 2002 at 09:42:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 09:42:49AM -0800, Greg KH wrote:
> On Sat, Oct 26, 2002 at 05:25:26PM -0700, H. J. Lu wrote:
> > On Sat, Oct 26, 2002 at 08:05:13PM -0400, Jeff Garzik wrote:
> > > Jeff Garzik wrote:
> > > 
> > > > s/__devinit/__init/ and the implementation looks ok to me
> > > 
> > > 
> > > 
> > > ...except if your patch can be called in hotplug paths...
> > 
> > There are plenty of __devini in arch/i386/kernel/pci-pc.c. I will leave
> > mine alone.
> 
> That is because those functions can be called in PCI hotplug paths,
> since yours is only called during init, it should be marked as such.
> 

Are you telling me that pcibios_sort will be called by PCI hotplug?


H.J.
