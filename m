Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVBPBBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVBPBBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVBPBBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:01:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:30607 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261668AbVBPBBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:01:04 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502151645.27774.jbarnes@sgi.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <9e473391050215163621dafa65@mail.gmail.com>
	 <200502151645.27774.jbarnes@sgi.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 12:00:03 +1100
Message-Id: <1108515603.13376.57.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 16:45 -0800, Jesse Barnes wrote:
> On Tuesday, February 15, 2005 4:36 pm, Jon Smirl wrote:
> > You're removing the check for 55AA at the start of the ROM.
> 
> No, the check is still there, I just removed the printk if 0xaa55 isn't found 
> (my box returns 0x303 instead).
> 
> > I though 
> > the PCI standard was that all ROMs had to start with the no matter
> > what object code they contain. Then if you look for PCIR there is a
> > field in the stucture that says what language the ROM is in. Maybe the
> > problem is in the BIOS_IN16() function and things are getting byte
> > swapped wrong.
> 
> I thought the signature described what type of ROM was there?  E.g. 0xaa55 
> means x86 ROM, x0303 means OF ROM, etc.?
> 
> At any rate, not having a ROM at all (which my case may be) isn't an error 
> either, so I think removing the printk is appropriate regardless.

No, they all haev 0xaa55, then a header that says the type of ROM...

Ben.


