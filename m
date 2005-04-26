Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDZPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDZPOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDZPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:14:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:7296 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261568AbVDZPON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:14:13 -0400
Date: Tue, 26 Apr 2005 11:14:10 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       <alexn@dsv.su.se>, Greg KH <greg@kroah.com>, <gud@eth.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, Jeff Garzik <jgarzik@pobox.com>,
       <cramerj@intel.com>, Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <1114487537.7182.26.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0504261112320.12725-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Benjamin Herrenschmidt wrote:

> The problem is, as far as I understand what David told me a while ago,
> some USB chips simply _cannot_ disable DMA without actually suspending
> the bus, which itself is a complex process that takes some time and can
> involve all sort of problems with devices / drivers that don't deal with
> suspended busses properly. I suspect other kind of chips may be
> similarily busted by design.

That's correct.  However, during shutdown we don't really need to take the 
time and we don't care about problems with drivers not handling suspended 
buses properly.  (USB devices, at least, _can_ handle such things -- it's 
part of the spec.)

Alan Stern

