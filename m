Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbULPPWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbULPPWI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbULPPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:22:08 -0500
Received: from motgate.mot.com ([129.188.136.100]:30971 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S261939AbULPPWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:22:06 -0500
In-Reply-To: <1103173505.6052.282.camel@localhost>
References: <1103173505.6052.282.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <31B0C50E-4F76-11D9-8900-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: <mochel@digitalimplant.org>, "Greg KH" <greg@kroah.com>,
       <ambx1@neo.rr.com>, <len.brown@intel.com>, <shaohua.li@intel.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [RFC] Device Resource Management
Date: Thu, 16 Dec 2004 09:21:44 -0600
To: "Robert Love" <rml@ximian.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two issues that we have discussed for embedded usage would be making 
resources 64-bit always.  We are starting to see more and more systems 
with greater than 32-bits of physical address space while still having 
32-bit effective.  The second is sharing resources.  On several devices 
the IO memory region for one device may reside inside another.  One 
example of this is the registers used to control ethernet MII PHYs 
exist inside of an ethernet controllers register block.

Also, I liked having a name in resource.  It allows us to find the 
specific resource we need if we have multiple resources of a given type 
without assuming order.  And thus adding a device_find_iores_bynames().

- kumar

