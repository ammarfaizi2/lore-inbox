Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129983AbQK3FJw>; Thu, 30 Nov 2000 00:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131526AbQK3FJm>; Thu, 30 Nov 2000 00:09:42 -0500
Received: from rocko.intermag.com ([216.218.196.2]:56338 "EHLO
        rocko.intermag.com") by vger.kernel.org with ESMTP
        id <S129983AbQK3FJ1>; Thu, 30 Nov 2000 00:09:27 -0500
Date: Wed, 29 Nov 2000 20:37:52 -0800
From: Jamie Manley <jamie@homebrewcomputing.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre24 and drm/agpgart static?
Message-ID: <20001129203752.A15218@homebrewcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally got around to trying the 2.2.18pre series and the agp/drm
backport and noticed something odd at bootup.  Here's an extract from
dmesg:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe0000000

A bit later:

[drm] The mga drm module requires the agpgart module to function correctly
Please load the agpgart module before you load the mga module

Although XFree86 seems to be happy enough loading the dri and drm
modules.

Is this supposed to only work with modules?  .config snippet:

CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=y

System:
RedHat 7.0 + errata
kgcc used to build kernel, with binutils: GNU ld version 2.10.91
PIII 750
512MB RAM
Matrox g400 (OEM version)

Please cc me on any replies, as I am not subscribed.  I do my best to
follow web archives...

Jamie

-- 
Jamie					        http://www.intermag.com
And I said, "This must be the place." -- Laurie Anderson, "Big Science"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
