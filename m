Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315920AbSENRiS>; Tue, 14 May 2002 13:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSENRiS>; Tue, 14 May 2002 13:38:18 -0400
Received: from skunk.directfb.org ([212.84.236.169]:386 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S315920AbSENRiQ>; Tue, 14 May 2002 13:38:16 -0400
Date: Tue, 14 May 2002 19:37:14 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any1 have a clue?
Message-ID: <20020514173714.GA903@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <200205141916.51818.mcp@linux-systeme.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marc-Christian Petersen (mcp@linux-systeme.de):
> Hi there :-)
> 
> anyone have a clue what "disabled" is in 2.4.18 tree?
> I want to integrate the vmwarefb driver posted on this list for 2.4.19pre8 
> into 2.4.18 ... Or does anyone test this on 2.4.19pre8 with the same problem?
> 
> cc  -D__KERNEL__ -I/usr/src/linux-2.4.18/include  -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
> -Wno-unused -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  
> -DKBUILD_BASENAME=vmwarefb  -c -o vmwarefb.o vmwarefb.c
> vmwarefb.c: In function `init_module':
> vmwarefb.c:1513: `disabled' undeclared (first use in this function)
> vmwarefb.c:1513: (Each undeclared identifier is reported only once
> vmwarefb.c:1513: for each function it appears in.)
> make[3]: *** [vmwarefb.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.18/drivers/video/vmware'
> make[2]: *** [_modsubdir_vmware] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.4.18/drivers/video'
> make[1]: *** [_modsubdir_video] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.4.18/drivers'
> make: *** [_mod_drivers] Error 2

Sorry, I didn't check if the module version compiles.
'disabled' is a static integer in the driver. It seems that
the module parameter definitions should be after its declaration.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
