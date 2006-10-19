Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbWJSJZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbWJSJZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 05:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbWJSJZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 05:25:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17848
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030365AbWJSJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 05:25:43 -0400
Date: Thu, 19 Oct 2006 02:25:41 -0700 (PDT)
Message-Id: <20061019.022541.85409562.davem@davemloft.net>
To: alan@redhat.com
Cc: eiichiro.oiwa.nm@hitachi.com, jesse.barnes@intel.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061019092256.GC5980@devserv.devel.redhat.com>
References: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
	<20061019.013732.30184567.davem@davemloft.net>
	<20061019092256.GC5980@devserv.devel.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@redhat.com>
Date: Thu, 19 Oct 2006 05:22:56 -0400

> On Thu, Oct 19, 2006 at 01:37:32AM -0700, David Miller wrote:
> > defined to do this kind of thing, for example with the
> > pcibios_bus_to_resource() interface, used by routines such as
> > drivers/pci/quirks.c:quirk_io_region().
> 
> pci_iomap() ?

Yep, but that interface needs a BAR.

The "0xc0000" usage here for the VGA rom stuff, and some of the quirk
examples, want something a little bit different.

I suppose we could create something that cooked up a fake PCI
device and a BAR, but that is a bit too much for what we're
trying to do here I'm afraid.

