Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311601AbSCNMcx>; Thu, 14 Mar 2002 07:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311602AbSCNMcn>; Thu, 14 Mar 2002 07:32:43 -0500
Received: from ns.suse.de ([213.95.15.193]:56589 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311601AbSCNMcY>;
	Thu, 14 Mar 2002 07:32:24 -0500
Date: Thu, 14 Mar 2002 13:32:23 +0100
From: Dave Jones <davej@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020314133223.B19636@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314032801.C1273@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314032801.C1273@dualathlon.random>; from andrea@suse.de on Thu, Mar 14, 2002 at 03:28:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 03:28:01AM +0100, Andrea Arcangeli wrote:
 > Only in 2.4.19pre3aa2: 21_pte-highmem-f00f-1
 > 
 > 	vmalloc called before smp_init was an hack, right way
 > 	is to use fixmap. CONFIG_M686 doesn't mean much these
 > 	days, but it's ok and probably most vendors will use it
 > 	for the smp kernels, so it will save 4096 of the vmalloc space.
 > 	I just didn't wanted to clobber the code with || CONFIG_K7 ||
 > 	CONFIG_... | ... given all the other f00f stuff is also
 > 	conditional only to M686 and probably nobody bothered to compile
 > 	it out for my same reason 

 Brian Gerst had a patch a few months back to introduce a CONFIG_F00F
 if a relevant CONFIG_Mxxx was chosen[1]. It never got applied anywhere, but makes
 more sense than the CONFIG_M686 we currently use. 
 
[1] 386/486/586. With addition of my Vendor choice menu, we could even further
    narrow it down to Intel only.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
