Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265766AbRGFB42>; Thu, 5 Jul 2001 21:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRGFB4I>; Thu, 5 Jul 2001 21:56:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35090 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265729AbRGFB4B>; Thu, 5 Jul 2001 21:56:01 -0400
Date: Thu, 5 Jul 2001 21:23:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: David Whysong <dwhysong@physics.ucsb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <Pine.LNX.4.30.0107051730330.13297-100000@sal.physics.ucsb.edu>
Message-ID: <Pine.LNX.4.21.0107052120460.1030-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jul 2001, David Whysong wrote:

> Jes Sorensen (jes@sunsite.dk) wrote:
> 
> >You ran out of memory, ie. there were no more free blocks of 16
> >consecutive pages available in the system. This is what happens on a
> >system with little memory or which is loaded with memory intensive
> >applications.
> 
> I'm seeing the same thing here on a machine with 256 MB RAM and 1.5
> gigabytes of swap. There is no chance I am using anywhere near that
> much virtual memory.
> 
> Something is wrong with the MM in 2.4.6-pre9.

David, 

The messages are "harmless". The SCSI layer is trying to allocate big
chunks of memory (for the scattergather tables IIRC) just as an
optimization. 

If its not possible to allocate big chunks, the SCSI code will use lower
order allocations. (smaller chunks) 

