Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRCGJK2>; Wed, 7 Mar 2001 04:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130457AbRCGJKT>; Wed, 7 Mar 2001 04:10:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31969 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130448AbRCGJKL>;
	Wed, 7 Mar 2001 04:10:11 -0500
Date: Wed, 7 Mar 2001 04:09:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeremy Elson <jelson@circlemud.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another? 
In-Reply-To: <200103070854.f278sBw06566@servo.isi.edu>
Message-ID: <Pine.GSO.4.21.0103070402160.2127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Jeremy Elson wrote:

> Well, because it's a character device :-).  i.e,. the framework allows
> you to write a userspace program that services callbacks for character
> devices.  Inside the kernel, all open()/release()/ioctl()/etc calls
> for the device are proxied out to userspace where a library calls a
> userspace callback, and the result goes back to the kernel where it is
> then returned to the calling process.

Double ugh. Why bother with ioctl() when you can just have a second
channel and do read()/write() on it?

> The problem is just that to return data (instead of just a retval), as
> is needed for read and some ioctls, it leads to 3 copies as I
> described earlier. 
> 
> BTW, where are the zerocopy patches for pipes?  Maybe I'm missing
> something but it seems that pipes inside the kernel are still
> implememented by copying into the kernel and then copying out.
> Whatever method the zerocopy pipes use is probably what I'm looking
> for though.

Ask DaveM or look through l-k archives for URL of recent variant...
							Cheers,
								Al

