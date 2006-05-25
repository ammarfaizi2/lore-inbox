Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965173AbWEYO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965173AbWEYO6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 10:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWEYO6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 10:58:03 -0400
Received: from mx1.suse.de ([195.135.220.2]:40404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965173AbWEYO6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 10:58:03 -0400
Date: Thu, 25 May 2006 07:55:46 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Shaohua Li <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] request_firmware without a device
Message-ID: <20060525145546.GB1129@kroah.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com> <20060525040134.GA29974@kroah.com> <1148532550.32046.107.camel@sli10-desk.sh.intel.com> <1148552781.4734.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148552781.4734.13.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 12:26:21PM +0200, Marcel Holtmann wrote:
> Hi Shaohua,
> 
> > > > The patch allows calling request_firmware without a 'struct device'.
> > > > It appears we just need a name here from 'struct device'. I changed it
> > > > to use a kobject as Patrick suggested.
> > > > Next patch will use the new API to request firmware (microcode) for a CPU.
> > > 
> > > But a cpu does have a struct device.  Why not just use that?
> > It's a sysdev, no 'struct device' in it, IIRC.
> 
> do we really need to differentiate between sysdev and device anymore. I
> recall a plan to unify all devices, but I might be wrong.

I don't think we need to keep them different anymore, they should be
made the same.  Then issues like this will not happen.

And it will make your driver code smaller :)

thanks,

greg k-h
