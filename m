Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSHUE3c>; Wed, 21 Aug 2002 00:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSHUE3c>; Wed, 21 Aug 2002 00:29:32 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:63173 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317799AbSHUE3c>;
	Wed, 21 Aug 2002 00:29:32 -0400
Message-Id: <5.1.0.14.2.20020821060719.00b7bd48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 21 Aug 2002 06:31:04 +0200
To: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       Gilad Ben-Yossef <gilad@benyossef.com>
From: Mike Galbraith <efault@gmx.de>
Subject: RE: Alloc and lock down large amounts of memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <23B25974812ED411B48200D0B774071701248C6A@exchusa03.intense
 3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:08 PM 8/20/2002 -0500, Bhavana Nagendra wrote:
> >
> > Curiosity:  why do you want to do device DMA buffer
> > allocation from userland?
>
>I need 256M memory for a graphics operation.  It's a requiremment,
>can't change it. There will be other reasonably sized allocs in kernel
>space, this is a special case that will be done from userland. As
>discussed earlier in this thread, there's no good way of alloc()ing
>and pinning that much in DMA memory space, is there?

Not that I know of.  It seems to me that any interface that tried
to provide this would have to know what kind of device is going
to DMA from/to that ram.

Usually, when someone needs a large gob of contiguous ram,
folks suggest doing the allocation in kernel, and early.

         -Mike

