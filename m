Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFEJAc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTFEJAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:00:31 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:50823 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264536AbTFEJA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:00:28 -0400
Date: Thu, 5 Jun 2003 10:18:02 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605091802.GA17356@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de> <20030605084933.GI2329@kroah.com> <20030605085938.GC16879@suse.de> <20030605090645.GA2887@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605090645.GA2887@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 02:06:45AM -0700, Greg KH wrote:
 > > so why not..
 > > 
 > > #define pci_for_each_dev(dev) \
 > > 	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL)
 > > 
 > > ?
 > > 
 > > Seems to be the same change you made tree-wide, with minimal
 > > interruption to drivers.
 > 
 > But that would have changed the way that pci_for_each_dev() works.
 > It would require that dev=NULL before the function is called.

trivial to fix.

 > And having
 > the same function work subtly different on different kernel versions
 > would not be the best thing.

ditto.
 
 > Getting rid of it entirely was the better
 > option, and now that Linus has pulled it, we don't have to worry about
 > it anymore :)

The fact that a tree-wide 'cleanup' like this goes in just a few hours
after its posted before chance to comment is another argument, but
concentrating on the technical point here, I still think this is a
step backwards.

		Dave
