Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbTCOCGC>; Fri, 14 Mar 2003 21:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCOCGC>; Fri, 14 Mar 2003 21:06:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18918 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261297AbTCOCGB>; Fri, 14 Mar 2003 21:06:01 -0500
Date: Fri, 14 Mar 2003 18:05:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] NUMAQ subarchification
Message-ID: <247240000.1047693951@flay>
In-Reply-To: <3E7285E7.8080802@us.ibm.com>
References: <1047676332.5409.374.camel@mulgrave> <3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This patch adds a new file, arch/i386/kernel/summit.c, for 
>>> summit-specific code.  Adds some structures to mach_mpparse.h.  Also 
>>> adds a hook in setup_arch() to dig out the PCI info, and stores it in 
>>> the mp_bus_id_to_node[] array, where it can be read by the topology 
>>> functions.
>> 
>> Wouldn't this file be better in arch/i386/mach-summit in keeping with
>> all the other subarch stuff?
>> 
>> While you're creating a separate file for summit, could you move the
>> summit specific variables (mpparse.c:x86_summit is the only one, I
>> think) into it so we can clean all the summit references out of the main
>> line?
>> 
>> Thanks,
>> 
>> James
> 
> While I was at it, I subarchified (I'll cc Websters with the new word ;) numaq as well.  Copied mach-defaults setup.c, topology.c, and Makefile.   Moved arch/i386/kernel/numaq.c into mach-numaq.  Compiles.


No, *please* don't do this. Subarch for .c files is *broken*.

Last time I looked (and I don't think anyone has fixed it since) 
it requires copying files all over the place, making an unmaintainable
nightmare. Either subarch needs fixing first, or we don't use it.

Let's just stick with your original patch - it's fine.

M.

