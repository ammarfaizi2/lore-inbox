Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVAMRwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVAMRwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVAMRv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:51:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:24789 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261238AbVAMRus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:50:48 -0500
Subject: Re: [PATCH] release_pcibus_dev() crash
From: John Rose <johnrose@austin.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200501130933.59041.jbarnes@engr.sgi.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com>
	 <200501121655.42947.jbarnes@engr.sgi.com>
	 <1105636311.30960.8.camel@sinatra.austin.ibm.com>
	 <200501130933.59041.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1105638551.30960.16.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 13 Jan 2005 11:49:11 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe, did you read Documentation/filesystems/sysfs-pci.c?  You need to do 
> more than just enable HAVE_PCI_LEGACY, you also need to implement some 
> functions.

This sounds like more than I bargained for.  I'll leave the patch as-is,
since I don't currently have the means to test a fix for the legacy IO
stuff.  Also because it doesn't crash on my architecture :)

If you get some time, my suggestion is to scrap
pci_remove_legacy_files(), and free the pci_bus->legacy_io field in
pci_remove_bus().  The binary sysfs files will be cleaned up
automatically as the class device is deleted, as described in the
parent.

Thanks-
John

