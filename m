Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWGYXIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWGYXIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 19:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWGYXIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 19:08:17 -0400
Received: from mga06.intel.com ([134.134.136.21]:8857 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030239AbWGYXIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 19:08:16 -0400
X-IronPort-AV: i="4.07,181,1151910000"; 
   d="scan'208"; a="104255124:sNHT8442740432"
Date: Tue, 25 Jul 2006 15:57:42 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060725155742.A15626@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060725203028.GA1270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060725203028.GA1270@kroah.com>; from gregkh@suse.de on Tue, Jul 25, 2006 at 01:30:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    +       data = kmalloc(sizeof(*data), GFP_KERNEL);
>    +       data->drv = drv;
>    +       data->dev = dev;
>    +
> +	if (drv->multithread_probe) {
            ^^^^^^^^^^^^^^^^^^^^^^
	 if (drv->multithread_probe && !cmdline_mtprobe) {

Also I think providing cmdline option to override the default 
multithread probe behaviour would be good. Something like above
which is useful while debugging the boot issues.

Cheers ,
Anil S Keshavamurthy
