Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbRLTC5K>; Wed, 19 Dec 2001 21:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285881AbRLTC5A>; Wed, 19 Dec 2001 21:57:00 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:23780 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S285878AbRLTC4w>;
	Wed, 19 Dec 2001 21:56:52 -0500
Date: Thu, 20 Dec 2001 03:56:46 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200112200256.DAA18860@harpo.it.uu.se>
To: bcrl@redhat.com
Subject: Re: aio
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2001 19:21:36 -0500, Benjamin LaHaise wrote:
>People are throwing money at the problem.  We're now at a point that in 
>order to provide the interested people with something they can use, we 
>need some kind of way to protect their applications against calling an 
>unsuspecting new mmap syscall instead of the aio syscall specified in 
>the kernel they compiled against.

One option is to use a mechanism where the kernel selects the aio
syscall number from any of the available numbers, and publishes it
in some easily accessible location. User-space then needs to grab it
from that location at app/lib init time before doing any actual work.
(This of course goes away when/if you do get an official syscall number.)

This is at least how I intend to do the "ioctl on device" to "real
syscall" transition for my x86 performance counters driver.

/Mikael
