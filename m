Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSHUEmP>; Wed, 21 Aug 2002 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317845AbSHUEmP>; Wed, 21 Aug 2002 00:42:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:50391 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317836AbSHUEmP>;
	Wed, 21 Aug 2002 00:42:15 -0400
Message-Id: <5.1.0.14.2.20020821063744.00b89b78@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Aug 2002 06:43:46 +0200
To: root@chaos.analogic.com, Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Alloc and lock down large amounts of memory
Cc: Gilad Ben-Yossef <gilad@benyossef.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020820163301.27264A-100000@chaos.analogic.c
 om>
References: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:47 PM 8/20/2002 -0400, Richard B. Johnson wrote:
>On Tue, 20 Aug 2002, Bhavana Nagendra wrote:
>
> > >
> > > Curiosity:  why do you want to do device DMA buffer
> > > allocation from userland?
> >
> > I need 256M memory for a graphics operation.  It's a requiremment,
> > can't change it. There will be other reasonably sized allocs in kernel
> > space, this is a special case that will be done from userland. As
> > discussed earlier in this thread, there's no good way of alloc()ing
> > and pinning that much in DMA memory space, is there?
> >
> > Gilad, I looked at mm/memory.c and map_user_kiobuf() lets me
> > map user memory into kernel memory and pins it down.  A scatter
> > gatter mapping (say, pci_map_sg()) will create a seemingly
> > contiguous buffer for DMA purposes.  Does that sound right to you?
> >
> > Bhavana
>
>You have to cheat. You can tell the kernel that you only have, say
>128 Meg of RAM.

Why not just use early allocation?  (if he has eg a 16G box, chopping
it down enough to get at 256M of DMA ram just ain't gonna work:)

         -Mike

