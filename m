Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTGXNSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 09:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTGXNSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 09:18:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:63191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265182AbTGXNSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 09:18:15 -0400
Date: Thu, 24 Jul 2003 09:27:46 -0400
From: Greg KH <greg@kroah.com>
To: Marcelo Penna Guerra <eu@marcelopenna.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes 2.6.0-test1
Message-ID: <20030724132746.GD4565@kroah.com>
References: <10586300964092@kroah.com> <200307231443.56168.eu@marcelopenna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307231443.56168.eu@marcelopenna.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 02:43:55PM -0300, Marcelo Penna Guerra wrote:
> Hi,
> 
> This code doesn't work well. I was porting this code to 2.5 myself, so I did 
> some fixes to the code in 2.6.0-test1-ac3.
> 
> On Saturday 19 July 2003 12:54, Greg KH wrote:
> 
> > +	smbus->adapter.algo_data = smbus;
> > +*/
> 
> The problem is here. If you leave this line commented out, you'll have 
> problems when inserting the chip module.
> 
> >  	smbus->adapter = nforce2_adapter;
> 
> Also, I don't see the point in commenting out all this lines just to introduce 
> a nforce2_adapter struct. If this is the correct aprouch, just remove the 
> duplicate code instead of just commenting it out.
> 
> Attached is a patch to fix this problems. I can't test it very well as I can 
> only see the sensors in my board with i2c-isa, but everything loads fine.
> This patch also moves the PCI ids to the pci_ids.h file.

I'd like to see someone who has this hardware test these changes before
taking them.

Anyone want to verify that things still work properly with this patch?

thanks,

greg k-h
