Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287953AbSAHRqB>; Tue, 8 Jan 2002 12:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288020AbSAHRpm>; Tue, 8 Jan 2002 12:45:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31230 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287953AbSAHRpf>; Tue, 8 Jan 2002 12:45:35 -0500
Date: Tue, 08 Jan 2002 01:41:55 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: jamesclv@us.ibm.com, Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] MAX_MP_BUSSES increase
Message-ID: <15640000.1010482915@flay>
In-Reply-To: <200201080914.g089EHq21694@butler1.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.21.0112261341470.9842-100000@freak.distro.conectiva> <200201080914.g089EHq21694@butler1.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There's a problem with that -- despite its name, CONFIG_MULTIQUAD is used for 
> the old NUMA-Q hardware.  It turns on some memory mapped port I/O code that 
> doesn't have any purpose for other machines.  The PCI bus overflow happens on 
> our new Foster-based boxes that may or may not contain multiple quad CPU 
> boards.
> 
> Still, CONFIG_MULTIQUAD is better than nothing.  It just may take a little 
> bit of redefinition, so long as we can coax the various distros to build 
> their installation and working kernels with CONFIG_MULTIQUAD turned on....

That's not a good idea. You're going to introduce extra switches to every port
IO path, and every IPI (for everybody, not just yourself). CONFIG_MULTIQUAD 
is also used to alter the way that PCI config space writes are done (in later 
patches). I suggest you use a different config option, or construct it dynamically.

Martin.

