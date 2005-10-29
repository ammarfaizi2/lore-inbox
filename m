Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVJ2T6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVJ2T6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJ2T6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:58:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:52891 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751227AbVJ2T6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:58:23 -0400
Date: Sat, 29 Oct 2005 12:57:49 -0700
From: Greg KH <gregkh@suse.de>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] toshiba_ohci1394_dmi_table should be __devinitdata, not __devinit
Message-ID: <20051029195749.GB14978@suse.de>
References: <52fyqlorj8.fsf@cisco.com> <200510290744.00642.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510290744.00642.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 07:43:59AM -0700, Jesse Barnes wrote:
> On Friday, October 28, 2005 9:50 pm, Roland Dreier wrote:
> > I don't really understand why gcc gives the error it does, but
> > without this patch, when building with CONFIG_HOTPLUG=n, I get errors
> > like:
> >
> >       CC      arch/x86_64/pci/../../i386/pci/fixup.o
> >     arch/x86_64/pci/../../i386/pci/fixup.c: In function
> > `pci_fixup_i450nx': arch/x86_64/pci/../../i386/pci/fixup.c:13: error:
> > pci_fixup_i450nx causes a section type conflict
> >
> > The change is obviously correct: an array should be declared
> > __devinitdata rather that __devinit.
> 
> Oops, yeah I think this is correct.  We should also mark 
> toshiba_line_size as __devinitdata.  Patch relative to yours.

Why?  Is it really worth it?  2 bytes?  Ick.

It's time to just make CONFIG_HOTPLUG always on to keep messes like this
from happening...

thanks,

greg k-h
