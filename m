Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJ0Rin>; Sun, 27 Oct 2002 12:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJ0Rin>; Sun, 27 Oct 2002 12:38:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:43528 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261238AbSJ0Rim>;
	Sun, 27 Oct 2002 12:38:42 -0500
Date: Sun, 27 Oct 2002 09:42:49 -0800
From: Greg KH <greg@kroah.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
Message-ID: <20021027174249.GA12811@kroah.com>
References: <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org> <3DBB1E29.5020402@pobox.com> <20021026165315.A15269@lucon.org> <3DBB2BE7.70208@pobox.com> <3DBB2DB9.3000803@pobox.com> <20021026172526.A15641@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021026172526.A15641@lucon.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2002 at 05:25:26PM -0700, H. J. Lu wrote:
> On Sat, Oct 26, 2002 at 08:05:13PM -0400, Jeff Garzik wrote:
> > Jeff Garzik wrote:
> > 
> > > s/__devinit/__init/ and the implementation looks ok to me
> > 
> > 
> > 
> > ...except if your patch can be called in hotplug paths...
> 
> There are plenty of __devini in arch/i386/kernel/pci-pc.c. I will leave
> mine alone.

That is because those functions can be called in PCI hotplug paths,
since yours is only called during init, it should be marked as such.

thanks,

greg k-h
