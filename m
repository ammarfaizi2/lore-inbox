Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261504AbREUN5f>; Mon, 21 May 2001 09:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbREUN5Z>; Mon, 21 May 2001 09:57:25 -0400
Received: from geos.coastside.net ([207.213.212.4]:48117 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261497AbREUN5R>; Mon, 21 May 2001 09:57:17 -0400
Mime-Version: 1.0
Message-Id: <p05100311b72ecde57fcd@[207.213.214.37]>
In-Reply-To: <15112.60362.447922.780857@pizda.ninka.net>
In-Reply-To: <20010520044013.A18119@athlon.random>
 <3B07AF49.5A85205F@uow.edu.au>	<20010520154958.E18119@athlon.random>
 <3B07CF20.2ABB5468@uow.edu.au>	<20010520163323.G18119@athlon.random>
 <15112.26868.5999.368209@pizda.ninka.net>
 <20010521034726.G30738@athlon.random>
 <15112.48708.639090.348990@pizda.ninka.net>
 <20010521105944.H30738@athlon.random>
 <15112.55709.565823.676709@pizda.ninka.net>
 <20010521115631.I30738@athlon.random>
 <15112.59880.127047.315855@pizda.ninka.net>
 <15112.60362.447922.780857@pizda.ninka.net>
Date: Mon, 21 May 2001 06:55:29 -0700
To: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: alpha iommu fixes
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:19 AM -0700 2001-05-21, David S. Miller wrote:
>This is totally wrong in two ways.
>
>Let me fix this, the IOMMU on these machines is per PCI bus, so this
>figure should be drastically lower.
>
>Electrically (someone correct me, I'm probably wrong) PCI is limited
>to 6 physical plug-in slots I believe, let's say it's 8 to choose an
>arbitrary larger number to be safe.
>
>Then we have:
>
>max bytes per bttv: max_gbuffers * max_gbufsize
>		    64           * 0x208000      == 133.12MB
>
>133.12MB * 8 PCI slots == ~1.06 GB
>
>Which is still only half of the total IOMMU space available per
>controller.

8 slots (and  you're right, 6 is a practical upper limit, fewer for 
66 MHz) *per bus*. Buses can proliferate like crazy, so the slot 
limit becomes largely irrelevant. A typical quad Ethernet card, for 
example (and this is true for many/most multiple-device cards), has a 
bridge, its own internal PCI bus, and four "slots" ("devices" in PCI 
terminology).
-- 
/Jonathan Lundell.
