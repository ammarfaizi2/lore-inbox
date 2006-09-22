Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWIVWbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWIVWbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWIVWbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 18:31:08 -0400
Received: from ns1.suse.de ([195.135.220.2]:22984 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965226AbWIVWbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 18:31:06 -0400
Date: Fri, 22 Sep 2006 15:30:47 -0700
From: Greg KH <greg@kroah.com>
To: Ryan Moszynski <ryan.m.lists@gmail.com>
Cc: David Kubicek <dave@awk.cz>, linux-kernel@vger.kernel.org
Subject: Re: /drivers/usb/class/cdc-acm.c patch question, please cc
Message-ID: <20060922223047.GA21772@kroah.com>
References: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbf7c10b0609221445q1329eb5bsfe304c02f7f336db@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 05:45:21PM -0400, Ryan Moszynski wrote:
> using
> 2.6.18
> 
> quick version of this question:
> 
> how could i change line 1 to line 2 without breaking anything while
> providing the
> functionality of the patch i'm trying to apply?
> 
> 
> 	/* line 1  /drivers/usb/class/cdc-acm.c line 918
> 	readsize = le16_to_cpu(epread->wMaxPacketSize)* ( quirks ==
> SINGLE_RX_URB ? 1 : 2);
> 	
>        /* line 2
> 	readsize = (le16_to_cpu(epread->wMaxPacketSize) >
> maxszr)?le16_to_cpu(epread->wMaxPacketSize):maxszr;
> 
> 
> 
> 
> 
> long version:
> 
> since 2.6.14 i have been applying the following patch and recompiling
> my kernel so
> that i can use my verizon kpc650 evdo card with my laptop.  I've
> applied this patch
> succesfully on 2.6.14 and 2.6.15.  It works great and I have no problems.  
> I am
> trying to apply the patch to 2.6.18 but it fails, and i don't want to
> break anything,
> though I do need the functionality of the patch, since evdo is my only form 
> of
> internet(i live out in the sticks.) Without this patch, after setting
> up the needed
> config files, i can websurf, but if i try to download anything, the
> connection closes.
> 
> The rest of this patch, other than the chunk of which this line is a part,
> applies successfully.

Try the 2.6.18 kernel with no patch, it should have a driver for this
device already.

If not, let me know, and I'll work on something, you should not have to
modify the usb-serial core to get this device to actually use a sane
data rate.

thanks,

greg k-h
