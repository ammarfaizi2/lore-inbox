Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWGZH1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWGZH1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWGZH07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:26:59 -0400
Received: from mx1.suse.de ([195.135.220.2]:56975 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932169AbWGZH07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:26:59 -0400
Date: Wed, 26 Jul 2006 00:22:48 -0700
From: Greg KH <gregkh@suse.de>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726072248.GA6249@suse.de>
References: <20060725203028.GA1270@kroah.com> <20060725155742.A15626@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725155742.A15626@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 03:57:42PM -0700, Keshavamurthy Anil S wrote:
> >    +       data = kmalloc(sizeof(*data), GFP_KERNEL);
> >    +       data->drv = drv;
> >    +       data->dev = dev;
> >    +
> > +	if (drv->multithread_probe) {
>             ^^^^^^^^^^^^^^^^^^^^^^
> 	 if (drv->multithread_probe && !cmdline_mtprobe) {
> 
> Also I think providing cmdline option to override the default 
> multithread probe behaviour would be good. Something like above
> which is useful while debugging the boot issues.

As this is going to be a bus specific option, one would think that the
individual busses would provide such a switch, if they wanted to or not.

thanks,

greg k-h
