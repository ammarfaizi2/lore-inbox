Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbREOVJI>; Tue, 15 May 2001 17:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbREOVI6>; Tue, 15 May 2001 17:08:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7909 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261532AbREOVIn>;
	Tue, 15 May 2001 17:08:43 -0400
Date: Tue, 15 May 2001 17:08:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <Pine.GSO.4.21.0105151657580.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0105151702530.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Alexander Viro wrote:

> On 15 May 2001, Kai Henningsen wrote:
> 
> > viro@math.psu.edu (Alexander Viro)  wrote on 15.05.01 in <Pine.GSO.4.21.0105150550110.21081-100000@weyl.math.psu.edu>:
> > 
> > > ... and Multics had all access to files through equivalent of mmap()
> > > in 60s. "Segments" in ls(1) got that name for a good reason.
> > 
> > Where's something called "segments" connected with ls(1)? I can't seem to  
> > find the reference.
> 
> ls == list segments. Name came from Multics.

Basically, they had the whole address space consisting of mmaped files.
address was (segment << 18) + offset (both up to 18 bits) and primitive
was "attach segment (== file) to address space". Each segment had its
own page table, BTW. Directories were special segments and contained
references to other segments (both files and directories). Root had fixed
ID. You could lookup segment by name.

