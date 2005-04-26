Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDZJoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDZJoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVDZJoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:44:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55184 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261438AbVDZJlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:41:25 -0400
Date: Tue, 26 Apr 2005 11:41:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <ambx1@neo.rr.com>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       alexn@dsv.su.se, greg@kroah.com, gud@eth.net,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       jgarzik@pobox.com, cramerj@intel.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050426094103.GD4175@elf.ucw.cz>
References: <1114458325.983.17.camel@localhost.localdomain> <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org> <20050425145831.48f27edb.akpm@osdl.org> <20050425221326.GC15366@redhat.com> <20050425232330.GG27771@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425232330.GG27771@neo.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I've been considering for a while that, in addition to ->probe and ->remove, we
> have the following:
> 
> "struct device" -->
> ->attach - binds to the device and allocates data structures
> ->probe - detects and sets up the hardware
> ->start - begins transactions (like DMA)
> ->stop - stops transactions
> ->remove - prepares the hardware for no driver control
> ->detach - frees stuff and unbinds the device

No.

Stop trying to add more hooks to struct device, we have too many
already.

									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
