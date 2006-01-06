Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWAFLsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWAFLsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWAFLsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:48:30 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60169 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964915AbWAFLsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:48:30 -0500
Date: Fri, 6 Jan 2006 11:48:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, schwidefsky@de.ibm.com
Cc: Greg K-H <greg@kroah.com>
Subject: Re: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
Message-ID: <20060106114822.GA11071@flint.arm.linux.org.uk>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
	schwidefsky@de.ibm.com, Greg K-H <greg@kroah.com>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105142951.13.01@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 02:29:51PM +0000, Russell King wrote:
> The long-term idea is to remove the device_driver methods entirely.

With the three additional patches I've just posted, this leaves:

	ccw_driver
	css_driver
	pcie_port_service_driver
	scsi_driver

using the generic device_driver probe/remove/shutdown/suspend/resume
methods.

I'm not sure what's going on with the PCIE code - my attempts to
contact the PCIE folk about their suspend/resume implementation has
been met by silence.

The scsi_driver business looks like being a pig to solve - so can
SCSI folk please look at what's required to unuse these fields.

Could the s390 folk also look at what's required for ccw_driver and
css_driver please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
