Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAPXN>; Fri, 1 Dec 2000 10:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129449AbQLAPXD>; Fri, 1 Dec 2000 10:23:03 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:1796 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S129210AbQLAPW4>;
	Fri, 1 Dec 2000 10:22:56 -0500
Date: Fri, 1 Dec 2000 14:52:11 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: Jamie Manley <jamie@homebrewcomputing.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre24 and drm/agpgart static?
In-Reply-To: <20001129203752.A15218@homebrewcomputing.com>
Message-ID: <Pine.LNX.4.21.0012011450270.1317-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Jamie Manley wrote:

> Finally got around to trying the 2.2.18pre series and the agp/drm
> backport and noticed something odd at bootup.  Here's an extract from
> dmesg:
> 
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 440M
> agpgart: Detected Intel 440BX chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> 
> A bit later:
> 
> [drm] The mga drm module requires the agpgart module to function correctly
> Please load the agpgart module before you load the mga module
> 
> Although XFree86 seems to be happy enough loading the dri and drm
> modules.
> 
> Is this supposed to only work with modules?  .config snippet:
> 
> CONFIG_AGP=y
> CONFIG_AGP_INTEL=y

Probably you have modversions enabled (CONFIG_MODVERSION=y). Disable that
and try again, or build as modules. 2.4 fixed this problem in the proper
way, but I don't know what's going to happen about 2.2 ...

john

-- 
"Penguins are so sensitive to my needs."
	- Lyle Lovett 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
