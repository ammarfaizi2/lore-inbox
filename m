Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSAPRyq>; Wed, 16 Jan 2002 12:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284902AbSAPRyh>; Wed, 16 Jan 2002 12:54:37 -0500
Received: from waste.org ([209.173.204.2]:34740 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285161AbSAPRyZ>;
	Wed, 16 Jan 2002 12:54:25 -0500
Date: Wed, 16 Jan 2002 11:54:06 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <Pine.GSO.4.21.0201152252170.4339-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0201161151050.26762-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Alexander Viro wrote:

> On Tue, 15 Jan 2002, Rob Landley wrote:
>
> > Let's focus on how to separate the volatile parts of initramfs that have to
> > stay in the kernel tree, and the non-volatile parts that can talk to the rest
> > of the kernel through cleanly defined APIs the kernel must support.
> >
> > If a section of code can't talk to the kernel through a stable API, it can
> > never be moved out of the kernel tree, and there's not too much point in
> > moving it out of the kernel proper, really...
>
> The whole fscking point is to _avoid_ special API.  System calls.  Normal,
> usual system calls and nothing else.
>
> And frankly, moving out of the kernel tree is the least of my worries -
> if it's a normal userland code it's fine with me.
>
> I don't see any problems with having the first component of image
> generated when you build the kernel - as the matter of fact you
> want that, since there is no reason to have nfsroot code there if you
> don't support NFS, etc.

This is an argument for the script called by 'make install' to peek at the
config, not for the kernel to build any of the user space boot tools.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

