Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270739AbTGUV5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270743AbTGUV5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:57:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:20676 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270739AbTGUV5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:57:22 -0400
Date: Tue, 22 Jul 2003 00:12:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>,
       ole.rohne@cern.ch
Subject: Re: More powermanagment hooks for pci
Message-ID: <20030721221205.GJ436@elf.ucw.cz>
References: <20030721213506.GH436@elf.ucw.cz> <Pine.LNX.4.44.0307211505530.22018-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307211505530.22018-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, there are likely more drivers that need to quiesce PCI card
> > before resume. (I was wrong, 8390too does *not* need it, radeonfb
> > does). It looks like bug not to have the hook in the first place...
> 
> You also didn't credit the original author.. 

Sorry, Ole was the original author AFAIK.

> > Patrick, can you comment? I was trying to add power_on hook to PCI
> > devices...
> 
> I know. I'm thinking of adding power_{off,on} to the core and getting rid
> of the level parameter to the suspend/resume functions (like how I changed
> system devices). That would require an additional hook to the PCI drivers
> so that the call is propogated down to the low-level driver. If that's the
> case, then we should add both to struct pci_driver at once.

Should I modify patch to add both?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
