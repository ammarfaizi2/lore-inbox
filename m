Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUDPXl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbUDPXl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:41:57 -0400
Received: from palrel12.hp.com ([156.153.255.237]:36741 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263227AbUDPXkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:40:31 -0400
Date: Fri, 16 Apr 2004 16:39:44 -0700
From: Grant Grundler <iod00d@hp.com>
To: Greg KH <greg@kroah.com>
Cc: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>,
       lhcs-devel@lists.sourceforge.net, lhms-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net,
       pcihpd-discuss@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-largesys-devel@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [RFC] New sysfs tree for hotplug
Message-ID: <20040416233944.GF24556@cup.hp.com>
References: <20040415170939.0ff62618.tokunaga.keiich@jp.fujitsu.com> <20040416223436.GB21701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416223436.GB21701@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 03:34:36PM -0700, Greg KH wrote:
> >  Recent large machines have many PCI devices and some boards that
> > contain devices (e.g. CPU, memory, and/or I/O devices).  A certain PCI
> > device (PCI1) might be connected with other one (PCI2), which means that
> > there is a dependency between PCI1 and PCI2.
> 
> You have this today?

I interpreted his comments to mean PCI-PCI Bridges.
eg something like a 4-port NIC which usually has a PCI-PCI bridge
to "isolate" multiple PCI devices (NICs):
 +-[60]---01.0-[61]--+-04.0  Digital Equipment Corporation DECchip 21142/43
 |                   +-05.0  Digital Equipment Corporation DECchip 21142/43
 |                   +-06.0  Digital Equipment Corporation DECchip 21142/43
 |                   \-07.0  Digital Equipment Corporation DECchip 21142/43
...

I thought this was already handled though so I may be misunderstanding.
Keiichiro, an example would be very helpful in understanding.

...
> Hm, no.  What about usb, firewire, scsi and any other future bus that
> can be "hotpluggable".  The kernel doesn't treat them differently, and
> we shouldn't either.

SCSI has a heirarchy as well. Ie LUNs can be removed without
removing the target (RAID controllers). Normal JBOD use equates
LUNs and targets.

grant
