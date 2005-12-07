Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVLGQBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVLGQBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVLGQBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:01:48 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:51331 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751168AbVLGQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:01:48 -0500
Date: Wed, 7 Dec 2005 11:01:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Arjan van de Ven <arjan@infradead.org>
cc: Oliver Neukum <oliver@neukum.org>, <linux-usb-devel@lists.sourceforge.net>,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
 spin lock to atomic_t.
In-Reply-To: <1133968943.2869.26.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.44L0.0512071059420.21143-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2005, Arjan van de Ven wrote:

> > On the other hand, Oliver needs to be careful about claiming too much.  In 
> > general atomic_t operations _are_ superior to the spinlock approach.
> 
> No they're not. Both are just about equally expensive cpu wise,
> sometimes the atomic_t ones are a bit more expensive (like on parisc
> architecture). But on x86 in either case it's a locked cycle, which is
> just expensive no matter which side you flip the coin... 

You're overgeneralizing.

Sure, a locked cycle has a certain expense.  But it's a lot less than the 
expense of a contested spinlock.  On the other hand, many times UP systems 
can eliminate spinlocks entirely.  There are lots of variables and many 
possible tradeoffs.

Alan Stern

