Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284814AbRLPUuf>; Sun, 16 Dec 2001 15:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284810AbRLPUuZ>; Sun, 16 Dec 2001 15:50:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24777 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284809AbRLPUuK>;
	Sun, 16 Dec 2001 15:50:10 -0500
Date: Sun, 16 Dec 2001 15:50:08 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Otto Wyss <otto.wyss@bluewin.ch>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <3C1D060B.9475C9F8@bluewin.ch>
Message-ID: <Pine.GSO.4.21.0112161542420.937-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Dec 2001, Otto Wyss wrote:

> Well a simple solution would be if Linux supports the multiple streams file
> format. Assume the kernel and all necessary modules for booting (if not all
> modules) are combined into a single file. The boot loader (i.e. lilo) simply
> loads this file and starts the first stream (the kernel). It doesn't need to
> know the full multiple stream format (maybe nothing at all). The kernel of
> course needs this functionality to load the rest of the modules for a minimal
> working system. 
> 
> I assume it's no problem to integrate the building of this boot file into either
> the Linux compilation or better into a separate setup phase (possibly together
> with good hardware/module detection).
> 
> Advantages:
> - A simple boot loader can handle it without much tweaking
> - The multiple streams file format is a standard concept usable anywhere

ITYM useless.

> - No ramdisk is necessary
> - This concept needs possibly less kernel functionality than initrd
> - No change in the current compilation process except for the additional setup phase
> 
> Disadvantages:
> - Someone else has to do it, I'm not a kernel/driver developer
> 
> Why did nobody else have this simple idea? I don't know, maybe the multiple
> streams file format isn't widely known in the Linux community.

Ewww....

"Forked files" crap _is_ known.  And not welcome.

There is a bog-standard way to combine several files in one - cpio.  Or tar.
No need to bring Apple Shit-For-Design(tm)(r) when standard tools are quite
enough.

