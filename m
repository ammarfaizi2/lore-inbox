Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbTJOTOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTJOTOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:14:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264140AbTJOTOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:14:04 -0400
Date: Wed, 15 Oct 2003 12:13:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Matthew Wilcox <willy@debian.org>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_get_slot()
In-Reply-To: <20031015184104.GA22373@kroah.com>
Message-ID: <Pine.LNX.4.44.0310151213050.1661-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Oct 2003, Greg KH wrote:
> 
> The check of:
> 	if (dev->bus->number == bus && dev->devfn == devfn)
> in pci_find_slot() doesn't check for the domain?

No, and it doesn't even have anything to check _against_. We don't pass 
the domain down to it.

		Linus

