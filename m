Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbUKJE2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbUKJE2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUKJE2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:28:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49166 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261858AbUKJE2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:28:30 -0500
Date: Wed, 10 Nov 2004 04:28:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH/RFC 1/4]device core changes
Message-ID: <20041110042822.A13318@flint.arm.linux.org.uk>
Mail-Followup-To: Li Shaohua <shaohua.li@intel.com>,
	Greg KH <greg@kroah.com>,
	ACPI-DEV <acpi-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Len Brown <len.brown@intel.com>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com> <20041108225810.GB16197@kroah.com> <1099961418.15294.11.camel@sli10-desk.sh.intel.com> <1099971341.15294.48.camel@sli10-desk.sh.intel.com> <20041109045843.GA4849@kroah.com> <1099990981.15294.57.camel@sli10-desk.sh.intel.com> <20041110012443.GA9496@kroah.com> <1100051137.7825.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1100051137.7825.6.camel@sli10-desk.sh.intel.com>; from shaohua.li@intel.com on Wed, Nov 10, 2004 at 09:45:37AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 09:45:37AM +0800, Li Shaohua wrote:
> On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > Maybe your other patches weren't so bad...  If we implement them, can we
> > drop the platform notify stuff?
> Currently only ARM use 'platform_notify', and we can easily convert it
> to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
> is we will have many '#ifdef ..' if many platforms implement their
> per-bus 'platform_bind'.

Except none of the merged ARM platforms use platform_notify, and I haven't
seen any suggestion in the ARM world of why it would be needed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
