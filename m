Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbUKTA1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbUKTA1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKTA0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:26:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:10896 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262820AbUKTAXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:23:11 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: brking@us.ibm.com
Cc: Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <419E804E.2050004@us.ibm.com>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <20041119213232.GB13259@kroah.com>  <419E72EF.4010100@us.ibm.com>
	 <1100904402.3811.52.camel@gaston>  <419E804E.2050004@us.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 11:23:00 +1100
Message-Id: <1100910180.3812.63.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I guess what I was having difficulty with was how to go from bus/devfn
> to pci_dev in the bus macros (to access the saved_config_space) and do this
> safely at interrupt level. The spinlock protecting the devices list on the
> pci_bus struct is never acquired with irqsave and all the existing
> functions to search for a given pci device are not callable from
> interrupt context.

Hrm... true, that is a problem...

Ben.


