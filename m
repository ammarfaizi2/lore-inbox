Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbTDBWI3>; Wed, 2 Apr 2003 17:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbTDBWI3>; Wed, 2 Apr 2003 17:08:29 -0500
Received: from AMarseille-201-1-1-205.abo.wanadoo.fr ([193.252.38.205]:8488
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263178AbTDBWI1>; Wed, 2 Apr 2003 17:08:27 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr <vandrove@vc.cvut.cz>
In-Reply-To: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049322054.578.3.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 03 Apr 2003 00:20:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Let really good. I applied it to my local tree but haven't passed it to BK 
> fbdev yet. The only thing I like to see changed is get_EDID. At present it 
> accepts a struct pci_dev. Now for generic support for the intel platform 
> we can get this from the BIOS. You already have a patch that does this. 
> It doesn't need a struct pci_dev in this case. It is possible to get this 
> info from the i2c bus but I never seen any drivers do this. What data would
> we have to pass in get the EDID inforamtion? So the question is how 
> generic will get_EDID end up being or will we have to have driver specfic 
> hooks since I don't pitcure i2c approaches being the same for each video 
> card. Petr didn't you attempt this with the matrox driver at one time?

get_EDID() has to be a driver specific hook

EDID via BIOS is a way to get it, BIOS emulation in userland is another,
on PPC, I can retreive it from the firmware device-tree in a different
way with some cards, and finally, I plan to implement i2c sooner or
later with some drivers...

Ben.

