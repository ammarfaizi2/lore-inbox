Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSFTOcO>; Thu, 20 Jun 2002 10:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSFTOcN>; Thu, 20 Jun 2002 10:32:13 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:32786 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S314551AbSFTOcM>;
	Thu, 20 Jun 2002 10:32:12 -0400
Message-ID: <3D11E76E.6000007@epfl.ch>
Date: Thu, 20 Jun 2002 16:32:14 +0200
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] Split up agpgart into per implementation files.
References: <fa.ep8m4pv.1gkki2v@ifi.uio.no> <3D11CF69.3030103@epfl.ch> <20020620160612.I29373@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Thanks for doing this..  I goofed the Makefile, and it doesn't build
> correctly as modules under 2.5. Fixed one is at http://www.codemonkey.org.uk/Makefile
> Just drop it into drivers/char/agp/ after applying my patch.
> Due to build system differences, I'm not sure if your 2.4 patch also
> suffers the same problem..

Not sure about that... the Makefile you supplied was looking like a 2.4 
one (and looks correct from what I understand from the Docs). I must say 
that I used kbuild-2.5 port to 2.4 to build the module (kbuild-2.5 makes 
the build of a single module really easy), so I did not test the 
original Makefile (kernel-Makefile guru around while it builds ?).


> Oh, and agp.h has the definition of PFX below code which uses it,
> and should be moved around..
> 

Damn, you're right. Why the h&*( the compiler did not yell about this one ??
A corrected version can be found at 
http://ltswww.epfl.ch/~aspert/patches/agpgart-split-2.4.19-pre10-ac2-2.diff.bz2

a+

-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

