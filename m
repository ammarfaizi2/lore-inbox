Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWDWQEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWDWQEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 12:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWDWQED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 12:04:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37024 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751417AbWDWQEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 12:04:01 -0400
Date: Sun, 23 Apr 2006 09:02:35 -0700
From: Greg KH <greg@kroah.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Bert Thomas <bert@brothom.nl>, linux-kernel@vger.kernel.org
Subject: Re: PCI device driver writing newbie trouble
Message-ID: <20060423160235.GA32232@kroah.com>
References: <4447A2E7.6000407@brothom.nl> <20060422060045.GA18067@kroah.com> <84144f020604230050q71001601qadd7572a9fb169ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020604230050q71001601qadd7572a9fb169ba@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 10:50:38AM +0300, Pekka Enberg wrote:
> On Thu, Apr 20, 2006 at 04:04:07PM +0100, Bert Thomas wrote:
> > > static const struct pci_device_id cif50_ids[] = {
> > >         {
> > >         .vendor = 0x10B5,
> > >         .device = 0x9050,
> > >         .subvendor = PCI_ANY_ID, //0x10B5,
> > >         .subdevice = PCI_ANY_ID, //0x1080,
> > >         .class = PCI_ANY_ID,
> > >         .class_mask = PCI_ANY_ID
> > >         },
> 
> On 4/22/06, Greg KH <greg@kroah.com> wrote:
> > Try the PCI_DEVICE() macro here instead.
> >
> > But that should not matter, this should work, I don't know why it
> > doesn't sorry.
> 
> No device class will ever match the above class and class_mask.
> Changing them to zero makes it work according to Bert.

Ah, yeah, that would work, good catch.  If you used the PCI_DEVICE()
macro, it would have also worked :)

thanks,

greg k-h
