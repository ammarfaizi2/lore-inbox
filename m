Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVCAAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVCAAOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVCAAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:14:36 -0500
Received: from peabody.ximian.com ([130.57.169.10]:38864 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261831AbVCAAOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:14:34 -0500
Subject: Re: [RFC] PCI bridge driver rewrite
From: Adam Belay <abelay@novell.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200502281538.18881.jbarnes@sgi.com>
References: <1109226122.28403.44.camel@localhost.localdomain>
	 <200502241502.15163.jbarnes@sgi.com>
	 <1109633268.28403.77.camel@localhost.localdomain>
	 <200502281538.18881.jbarnes@sgi.com>
Content-Type: text/plain
Date: Mon, 28 Feb 2005 19:13:17 -0500
Message-Id: <1109635997.28403.123.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-28 at 15:38 -0800, Jesse Barnes wrote:
> On Monday, February 28, 2005 3:27 pm, Adam Belay wrote:
> > How can we specify which bus to target?
> 
> Maybe we could have a list of legacy (ISA?) devices for drivers like vgacon to 
> attach to?  The bus info could be stuffed into the legacy device structure 
> itself so that the platform code would know what to do.

Are these devices actually legacy, or PCI with compatibility interfaces?

I think a "struct isa_device" would be be useful.  Would a pointer to
the "struct pci_bus" do the trick?

> 
> > Also is the legacy IO space mapped to IO Memory on the other side of the
> > bridge?
> 
> How do you mean?  Legacy I/O port accesses just become strongly ordered memory 
> transactions, afaik, and legacy memory accesses are dealt with the same way.
> 
> Jesse

I was just wondering if we have to reserve a memory range for this?

Thanks,
Adam


