Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUGVPKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUGVPKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUGVPKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:10:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3782 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266560AbUGVPKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:10:20 -0400
Subject: Re: pci_bus_lock question
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Mike Wortman <wortman@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040722070830.GB21907@kroah.com>
References: <1090447841.544.7.camel@sinatra.austin.ibm.com>
	 <1090448467.544.10.camel@sinatra.austin.ibm.com>
	 <20040722070830.GB21907@kroah.com>
Content-Type: text/plain
Message-Id: <1090509081.1648.5.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 22 Jul 2004 10:11:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to remove a bus from the pci_root_buses() list, and I need to do
so from a module.  Would it be preferable to export the pci_bus_lock
symbol or create wrappers in the PCI core that safely add/remove buses
to/from this list?

I'm guessing the latter :)

Thanks-
John

On Thu, 2004-07-22 at 02:08, Greg KH wrote:
> On Wed, Jul 21, 2004 at 05:21:08PM -0500, John Rose wrote:
> > But then, most of these violations are in __init functions.  I think I
> > just answered my own question :)
> 
> Yes, we don't protect the lists in those __init functions, as it isn't
> needed at that point in time.
> 
> thanks,
> 
> greg k-h
> 

