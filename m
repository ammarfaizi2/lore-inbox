Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270735AbTGUVvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270737AbTGUVvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:51:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:8387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270735AbTGUVve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:51:34 -0400
Date: Mon, 21 Jul 2003 15:10:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>,
       <ole.rohne@cern.ch>
Subject: Re: More powermanagment hooks for pci
In-Reply-To: <20030721213506.GH436@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0307211505530.22018-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, there are likely more drivers that need to quiesce PCI card
> before resume. (I was wrong, 8390too does *not* need it, radeonfb
> does). It looks like bug not to have the hook in the first place...

You also didn't credit the original author.. 

> Patrick, can you comment? I was trying to add power_on hook to PCI
> devices...

I know. I'm thinking of adding power_{off,on} to the core and getting rid
of the level parameter to the suspend/resume functions (like how I changed
system devices). That would require an additional hook to the PCI drivers
so that the call is propogated down to the low-level driver. If that's the
case, then we should add both to struct pci_driver at once.


	-pat

