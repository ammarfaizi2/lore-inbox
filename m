Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263141AbVFXQmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbVFXQmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVFXQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:42:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:63375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263151AbVFXQls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:41:48 -0400
Date: Fri, 24 Jun 2005 09:39:40 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Quadriplegic Leprechaun <quadriplegic_leprechaun@ukonline.co.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1: PCI compile error with CONFIG_HOTPLUG=n
Message-ID: <20050624163940.GA30685@kroah.com>
References: <42BBBBC0.2050702@ukonline.co.uk> <20050624092454.GE26545@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624092454.GE26545@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 11:24:54AM +0200, Adrian Bunk wrote:
> On Fri, Jun 24, 2005 at 08:52:32AM +0100, Quadriplegic Leprechaun wrote:
> 
> > Hi,
> 
> Hi,
> 
> > With the attached config, I get an undefined symbol error when building 
> > the following kernel:
> > 
> > $ head Makefile
> > VERSION = 2
> > PATCHLEVEL = 6
> > SUBLEVEL = 12
> > EXTRAVERSION = -mm1
> > NAME=Woozy Numbat
> > 
> > And this is the error I get:
> > [ ... lots of output snipped ... ]
> >  LD      vmlinux
> > arch/i386/pci/built-in.o(.init.text+0x101e): In function `pcibios_init':
> > common.c: undefined reference to `pci_assign_unassigned_resources'
> > make: *** [vmlinux] Error 1
> 
> thanks for this report.
> 
> @Ivan, Greg:
> gregkh-pci-pci-assign-unassigned-resources.patch breaks compilation with 
> CONFIG_HOTPLUG=n.

Known problem, see the patch on lkml to fix this already.

thanks,

greg k-h
