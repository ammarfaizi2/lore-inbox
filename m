Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbUKJByt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbUKJByt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbUKJByF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:54:05 -0500
Received: from fmr06.intel.com ([134.134.136.7]:17062 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261830AbUKJBvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:51:37 -0500
Subject: Re: [PATCH/RFC 1/4]device core changes
From: Li Shaohua <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20041110012443.GA9496@kroah.com>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com>
	 <20041108225810.GB16197@kroah.com>
	 <1099961418.15294.11.camel@sli10-desk.sh.intel.com>
	 <1099971341.15294.48.camel@sli10-desk.sh.intel.com>
	 <20041109045843.GA4849@kroah.com>
	 <1099990981.15294.57.camel@sli10-desk.sh.intel.com>
	 <20041110012443.GA9496@kroah.com>
Content-Type: text/plain
Message-Id: <1100051137.7825.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 09:45:37 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > > 
> > > Hm, hopefully Pat will chime in about what would be best for this, as he
> > > created the platform_notify interface.
> > Ok, an updated version. Use 'platform_notify', but add a 'type' in 
> > 'struct bus_type'. Using bus_type->name to identify the bus type is
> > pretty much ugly and slow. 
> 
> No, no "type" for a bus, sorry.
> 
> Maybe your other patches weren't so bad...  If we implement them, can we
> drop the platform notify stuff?
Currently only ARM use 'platform_notify', and we can easily convert it
to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
is we will have many '#ifdef ..' if many platforms implement their
per-bus 'platform_bind'.

Thanks,
Shaohua

