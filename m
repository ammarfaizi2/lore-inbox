Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270741AbTGUVWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbTGUVWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:22:48 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:11740 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270741AbTGUVUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 17:20:21 -0400
Date: Mon, 21 Jul 2003 23:35:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, ole.rohne@cern.ch
Subject: Re: More powermanagment hooks for pci
Message-ID: <20030721213506.GH436@elf.ucw.cz>
References: <20030720212943.GA724@elf.ucw.cz> <20030721164432.GA10931@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721164432.GA10931@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Apparently, some pci driver (8390too) need to do something at poweron
> > before interrupts are enabled. Please apply,
> 
> Sorry, but I'm not going to apply this.  I'm pretty sure that Pat has
> some changes like this pending in his power management stuff, that I
> think we should wait for.
> 
> And yes, I have the same laptop that would benifit from this patch, but
> a change like this for just one driver isn't ok.

Well, there are likely more drivers that need to quiesce PCI card
before resume. (I was wrong, 8390too does *not* need it, radeonfb
does). It looks like bug not to have the hook in the first place...

Patrick, can you comment? I was trying to add power_on hook to PCI
devices...

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
