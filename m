Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbTB1JCu>; Fri, 28 Feb 2003 04:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTB1JCu>; Fri, 28 Feb 2003 04:02:50 -0500
Received: from smtp.dslextreme.com ([66.51.205.17]:31455 "EHLO
	co1.dslextreme.com") by vger.kernel.org with ESMTP
	id <S267677AbTB1JCr>; Fri, 28 Feb 2003 04:02:47 -0500
Date: Fri, 28 Feb 2003 01:14:21 -0800
From: Paul Laufer <paul@laufernet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       niteowl@intrinsity.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 kernel bugs
Message-ID: <20030228091421.GA617@hal9000.laufernet.com>
Mail-Followup-To: Paul Laufer <paul@laufernet.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, niteowl@intrinsity.com,
	linux-kernel@vger.kernel.org
References: <20030206224900.GA15328@codemonkey.org.uk> <Pine.LNX.4.33L2.0302061504330.10714-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0302061504330.10714-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SOUND_SB is fixed as of 2.5.62 or so. Work is being done on
SOUND_AWE32_SYNTH but the structure of the driver doesn't fit the new
PnP API and is going to require quite a bit of rewrite. Not sure how
many people still use these old ISA sound cards... I only had a
handful of volunteers this time around to help test the soundblaster
fixes. During 2.3 there was significantly more interest for this once
wildly popular sound card. Other drivers for cards like the PAS16 that
weren't popular to begin with (and are 10+ years old) may have trouble
finding someone willing to update it.

Paul

On Thu, Feb 06, 2003 at 03:06:31PM -0800 or thereabouts, Randy.Dunlap wrote:
> On Thu, 6 Feb 2003, Dave Jones wrote:

[Snip]
 
> I did a 'make allyesconfig' build about 10 days ago.  I kept a list of
> modules that I had to disable due to syntax errors and another list of
> linker errors.  Here's that list, for 2.5.59:
> 
> 
> make some things build during allyesconfig testing:
> 	syntax errors:

[snip long list]

> ###
> make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
> make -f scripts/Makefile.build obj=arch/i386/boot/compressed \
>                                 IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
>   arch/i386/boot/tools/build -b arch/i386/boot/bootsect arch/i386/boot/setup arch/i386/boot/vmlinux.bin CURRENT > arch/i386/boot/bzImage
> Root device is (3, 4)
> Boot sector 512 bytes.
> Setup is 4880 bytes.
> System is 8384 kB
> System is too big. Try using modules.
> make[1]: *** [arch/i386/boot/bzImage] Error 1
> make: *** [bzImage] Error 2
> 
> 
> -- 
> ~Randy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
