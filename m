Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbVJ0TqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbVJ0TqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 15:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbVJ0TqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 15:46:14 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:55516 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932217AbVJ0TqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 15:46:14 -0400
Date: Thu, 27 Oct 2005 13:46:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       pcihpd-discuss@lists.sourceforge.net, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com, greg@kroah.com,
       len.brown@intel.com
Subject: Re: [Pcihpd-discuss] Re: [patch 0/3] pci: store PCI_INTERRUPT_PIN in pci_dev
Message-ID: <20051027194611.GC8201@parisc-linux.org>
References: <1130441405.5996.23.camel@whizzy> <1130441897.3027.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130441897.3027.18.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 09:38:17PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-10-27 at 12:30 -0700, Kristen Accardi wrote:
> > Store the value of PCI_INTERRUPT_PIN in the pci_dev structure for use
> > later.  This is useful for pci hotplug.  When a device is "surprise"
> > removed, the pci config space is no longer available.  However,
> > the pin value is needed to correctly disable the irq for the device.
> 
> Hmmm maybe it's just me..... but... isn't that both advisory and
> entirely unrelated to any kind of real interrupt thing? Eg dev->irq is
> there already and works even in the sight of IO-APICs etc etc...

With surprise hotplug, we can't read the pin from the card any more...
