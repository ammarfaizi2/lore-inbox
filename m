Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTLOKHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbTLOKHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:07:35 -0500
Received: from mail.kroah.org ([65.200.24.183]:37254 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263485AbTLOKHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:07:32 -0500
Date: Mon, 15 Dec 2003 02:07:24 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031215100724.GA1950@kroah.com>
References: <3FDCC171.9070902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FDCC171.9070902@intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 10:00:49PM +0200, Vladimir Kondratiev wrote:
> Please, ignore previous submission with the same subject. Patch file 
> attached was wrong one. Now correct patch attached.
> 
> Hi,
> PCI-Express platforms will soon appear on the market. It is worth to
> support it.

Yes it is worth it, any chance to get access to hardware to test this
out on?

> Following is patch for 2.4.23 kernel. I tested it on my host, it works
> properly.
> I did it for i386 only, I have no other architecture to test.
> 
> It was patch on the same subject from* Seshadri, Harinarayanan*
> (/harinarayanan.seshadri@intel.com/
> <mailto:harinarayanan.seshadri@intel.com>)
> http://www.cs.helsinki.fi/linux/linux-kernel/2003-17/0247.html
> My version differ in several aspects: it is for 2.4 (vs. 2.6); it do not
> ioremap/unmap page for each transaction.
> 
> How about inclusion in 2.4.24?

No, we need to get this into 2.6 first.  Can you please forward port
this to 2.6, clean up the formatting and address the issues everyone
else has made so far and post it?

>  * command line argument "pci=exp" to force PCI Express, similar to "conf1" and "conf2"

We should be able to do this automatically, and not force this on the
boot command line, correct?

> +/**
> + * RRBAR (memory base for PCI-E config space) resides here.
> + * Initialized to default address. Actually, it is platform specific, and
> + * value may vary.
> + * I don't know how to detect it properly, it is chipset specific.
> + */
> +static u32 rrbar_phys=0xe0000000UL;

How about information on how to detect it as per chipset type?  We need
to do this automatically some how.

> +/**
> + * Initializes PCI Express method for config space access.
> + * 
> + * There is no standard method to recognize presence of PCI Express,

Are you sure?  I thought there was (don't have my spec in front of me
right now...)

thanks,

greg k-h
