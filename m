Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311791AbSCNVRs>; Thu, 14 Mar 2002 16:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311793AbSCNVRi>; Thu, 14 Mar 2002 16:17:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11781 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311791AbSCNVRS>; Thu, 14 Mar 2002 16:17:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.19pre3aa2
Date: 14 Mar 2002 13:16:53 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6r405$8ae$1@cesium.transmeta.com>
In-Reply-To: <20020314032801.C1273@dualathlon.random> <20020314133223.B19636@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020314133223.B19636@suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Thu, Mar 14, 2002 at 03:28:01AM +0100, Andrea Arcangeli wrote:
>  > Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1
>  > 
>  > 	vmalloc called before smp_init was an hack, right way
>  > 	is to use fixmap. CONFIG_M686 doesn't mean much these
>  > 	days, but it's ok and probably most vendors will use it
>  > 	for the smp kernels, so it will save 4096 of the vmalloc space.
>  > 	I just didn't wanted to clobber the code with || CONFIG_K7 ||
>  > 	CONFIG_... | ... given all the other f00f stuff is also
>  > 	conditional only to M686 and probably nobody bothered to compile
>  > 	it out for my same reason 
> 
>  Brian Gerst had a patch a few months back to introduce a CONFIG_F00F
>  if a relevant CONFIG_Mxxx was chosen[1]. It never got applied anywhere, but makes
>  more sense than the CONFIG_M686 we currently use. 
>  
> [1] 386/486/586. With addition of my Vendor choice menu, we could even further
>     narrow it down to Intel only.
> 

One thing: I would again like to see "compatibility" and
"optimization" be separated out.  The current CPU type menu is a bit
of both.

It's actually quite useful these days to compile for 386 or 486, but
optimize for 686.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
