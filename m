Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272163AbTHDTZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHDTZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:25:43 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:31194 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272163AbTHDTZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:25:40 -0400
Date: Mon, 4 Aug 2003 21:25:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030804192515.GC157@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <1059686596.7187.153.camel@gaston> <20030731220300.GB487@elf.ucw.cz> <1059697660.8184.36.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059697660.8184.36.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you mail me a patch? [Where does PCI do its "second round"? From a
> > quick look I did not see that.]
> 
> I just comment out the init code in drivers/pci/power.c

Hmm, in such case whole power.c file can be
killed. pci_register_driver() should take care of registering proper
callbacks.

Apm needs to be fixed to do save_state/resume.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
