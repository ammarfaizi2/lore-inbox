Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262046AbVAUAOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbVAUAOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVAUAOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:14:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36071 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262213AbVAUAMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:12:20 -0500
Date: Thu, 20 Jan 2005 16:03:42 -0800
From: Greg KH <greg@kroah.com>
To: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>
Cc: linux-kernel@vger.kernel.org, bryder@sgi.com, kuba@mareimbrium.org,
       ftdi-usb-sio-devel@lists.sourceforge.net, edwin@harddisk-recovery.nl
Subject: Re: Bug when using custom baud rates....
Message-ID: <20050121000342.GA14469@kroah.com>
References: <20050120145422.GB18037@bitwizard.nl> <20050120150857.GH13036@kroah.com> <20050120152256.GA3614@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120152256.GA3614@bitwizard.nl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 04:22:56PM +0100, Rogier Wolff wrote:
> On Thu, Jan 20, 2005 at 07:08:58AM -0800, Greg KH wrote:
> > On Thu, Jan 20, 2005 at 03:54:22PM +0100, Rogier Wolff wrote:
> > > Hi,
> > > 
> > > When using custom baud rates, the code does: 
> > > 
> > > 
> > >        if ((new_serial.baud_base != priv->baud_base) ||
> > >             (new_serial.baud_base < 9600))
> > >                 return -EINVAL;
> > > 
> > > Which translates to english as: 
> > > 
> > > 	If you changed the baud-base, OR the new one is
> > > 	invalid, return invalid. 
> > > 
> > > but it should be:
> > > 
> > > 	If you changed the baud-base, OR the new one is
> > > 	invalid, return invalid. 
> > 
> > You mean AND, not OR here, right?  :)
> 
> :-) Sorry. Too noisy here. 
> 
> > > Patch attached. 
> > 
> > Have a 2.6 patch?
> 
> Patch told me: 
>    patching file drivers/usb/serial/ftdi_sio.c
>    Hunk #1 succeeded at 1137 (offset 156 lines).
> 
> but the resulting patch is attached. 

Applied, thanks.

greg k-h
