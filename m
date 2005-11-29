Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVK2G2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVK2G2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVK2G2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:28:46 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:21157 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751262AbVK2G2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:28:45 -0500
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Latest GIT: USB ehci_hcd broken (spinlock corruption)
Date: Mon, 28 Nov 2005 22:28:37 -0800
User-Agent: KMail/1.7.1
Cc: benh@kernel.crashing.org, mbuesch@freenet.de, stern@rowland.harvard.edu,
       greg@kroah.com, linux-kernel@vger.kernel.org
References: <200511271234.27708.mbuesch@freenet.de> <200511280840.39002.david-b@pacbell.net> <20051128140704.6a3539f2.akpm@osdl.org>
In-Reply-To: <20051128140704.6a3539f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511282228.37203.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 2:07 pm, Andrew Morton wrote:
> David Brownell <david-b@pacbell.net> wrote:
> >
> > Rename the EHCI "reset" routine so it better matches what it does (setup);
> >  and move the one-time data structure setup earlier, before doing anything
> >  that implicitly relies on it having been completed already.
> > 
> >  --- g26.orig/drivers/usb/host/ehci-pci.c	2005-11-12 10:38:26.000000000 -0800
> >  +++ g26/drivers/usb/host/ehci-pci.c	2005-11-28 08:22:59.000000000 -0800
> 
> This fixes the hang on my test box.  I don't know if USB still works though..

Worked for me ... this should get merged to Linus' tree ASAP.  (Whoops, this
fix missed RC3.)

- Dave
