Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUFDWqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUFDWqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUFDWqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:46:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:47815 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266023AbUFDWqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:46:23 -0400
Date: Fri, 4 Jun 2004 13:30:13 -0700
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pokey the Penguin <pokey@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psmouse/usb interaction fix
Message-ID: <20040604203013.GA13414@kroah.com>
References: <20040531174012.BA07D2B2B58@ws5-7.us4.outblaze.com> <20040531180341.GA17125@kroah.com> <20040531200120.GA1747@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531200120.GA1747@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 10:01:21PM +0200, Vojtech Pavlik wrote:
> On Mon, May 31, 2004 at 11:03:42AM -0700, Greg KH wrote:
> 
> > > The patch is ported from a SuSE kernel to 2.6.7-rc2. It's been
> > > around for at least two minor releases. The maintainer was
> > > contacted regarding merging but failed to respond.
> > > 
> > > Patch vital to certain laptop users. Please apply.
> > 
> > But this breaks users who want BIOS usb support instead of native Linux
> > support, right?  Sure, there are not many people who want that, but I do
> > know people who rely on this (like installer kernels, and early boot
> > issues with USB keyboards.)
>  
> I wrote the patch, SuSE 9.1 is shipping with it - too many BIOSes get
> the USB support wrong - don't expect keyboards and mice which don't
> honor the SET_IDLE command, etch. In my experience the BIOS USB support
> causes much more pain than good, namely preventing the normal PS/2 mice
> and keyboards to work properly.

I agree that lots of BIOSes get the USB support wrong, but this patch
really scares me.  How about we see how it works out in a few SuSE
releases before adding it to the main kernel tree?

thanks,

greg k-h
