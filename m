Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSLRAf3>; Tue, 17 Dec 2002 19:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSLRAf3>; Tue, 17 Dec 2002 19:35:29 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62104 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267072AbSLRAf2>;
	Tue, 17 Dec 2002 19:35:28 -0500
Date: Wed, 18 Dec 2002 00:42:26 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: kill pdev_enable_device()
Message-ID: <20021218004226.GA3204@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20021217201938.A16940@jurassic.park.msu.ru> <3DFFA5DD.4030804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFFA5DD.4030804@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 05:31:57PM -0500, Jeff Garzik wrote:
 > Ivan Kokshaysky wrote:
 > >- So, if we don't touch the PCI command registers, there is no point in
 > >  using pdev_enable_device(). Most drivers properly use
 > >  pci_enable_device() anyway.
 > Not only that, a driver _should_ be calling pci-enable-device, it's an 
 > API requirement.  J Random Driver should have a good reason _not_ to 
 > call pci_enable_device() ...

What about the xircom issue that was discussed in the last days ?
Sounds like the solution isn't a full on pci_enable_device() as
pcmcia 'knows better than us' at that stage aparently.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
