Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932780AbWBUVcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbWBUVcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932794AbWBUVcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:32:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:15282 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932780AbWBUVcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:32:06 -0500
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/6] PCI legacy I/O port free driver (take2) - Add device_flags into pci_device_id
Date: Tue, 21 Feb 2006 22:31:55 +0100
User-Agent: KMail/1.8.2
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
References: <43FAB283.8090206@jp.fujitsu.com> <200602212159.52106.ak@suse.de> <20060221211004.GA12784@kroah.com>
In-Reply-To: <20060221211004.GA12784@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602212231.55879.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 February 2006 22:10, Greg KH wrote:
> On Tue, Feb 21, 2006 at 09:59:51PM +0100, Andi Kleen wrote:
> > On Tuesday 21 February 2006 21:56, Greg KH wrote:
> > 
> > > I don't think you can add fields here, after the driver_data field.  It
> > > might mess up userspace tools a lot, as you are changing a userspace
> > > api.
> > 
> > User space should look at the ASCII files (modules.*), not the binary
> > As long as the code to generate these files still works it should be ok.
> 
> Does it?  

I assume Kenji-San tested that.

> Shouldn't the tools export this information too, if it really 
> should belong in the pci_id structure?

No - is driver_data exported? 
 
> So, is _every_ pci driver going to have to be modified to support this
> new field if they are supposed to work on this kind of hardware? 

There is 100% source compatibility because fields are only added at the
end of the structure.

And the drivers will still work on this hardware even without modification.

It's only an optimization that can be added to selected drivers.

-Andi
