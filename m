Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTFEIUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTFEIUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:20:44 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:19590 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264500AbTFEIUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:20:43 -0400
Date: Thu, 5 Jun 2003 09:38:15 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605083815.GA16879@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605021452.GA15711@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 07:14:52PM -0700, Greg KH wrote:

 > > p.s. I'll send these as patches in response to this email to lkml for
 > > those who want to see them.
 > 
 > I don't think everyone really wants to see all 63 different
 > pci_for_each_dev() removal patches

I'm puzzled why you did..

-	pci_for_each_dev(device)
+	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)

when you could have just added whatever locking pci_find_device() does
to pci_for_each_dev()  You'd then not have had to touch any of these
drivers, and it'd look a damn sight better to look at IMO.

		Dave

