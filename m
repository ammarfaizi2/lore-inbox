Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSBJVc5>; Sun, 10 Feb 2002 16:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSBJVcl>; Sun, 10 Feb 2002 16:32:41 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:16652 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289761AbSBJVcQ>;
	Sun, 10 Feb 2002 16:32:16 -0500
Date: Sun, 10 Feb 2002 00:05:54 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, davej@suse.de,
        eike@bilbo.math.uni-mannheim.de, linux-kernel@vger.kernel.org
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
Message-ID: <20020209230554.GB1589@elf.ucw.cz>
In-Reply-To: <20020208.074857.88474129.davem@redhat.com> <E16ZDqh-0004AV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16ZDqh-0004AV-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    That is incorrect. The warning occurs because someone made bogus changes to
> >    the vesa driver without understanding what was going on. The vesa frame
> >    buffer returned by the BIOS is a physical cpu address not a bus address
> >    and nothing to do with magic PCI mappings.
> > 
> > There were no changes made, in fact the VESA driver by your own
> > definition was buggy before my changes went in. :-) It was using
> > bus_to_virt and virt_to_bus all along Alan.
> 
> My error then. That or someone broke it around 2.0 8). It should be using
> phys_to_virt. Its the usual weirdness of talking to the BIOS which talks in
> CPU physical addresses.

Hm, I wonder where it goes in /proc/driver hierarchy...? Probably
/proc/driver/legacy?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
