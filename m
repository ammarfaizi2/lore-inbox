Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290343AbSAPEBZ>; Tue, 15 Jan 2002 23:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290345AbSAPEBO>; Tue, 15 Jan 2002 23:01:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30612 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290343AbSAPEBH>;
	Tue, 15 Jan 2002 23:01:07 -0500
Date: Tue, 15 Jan 2002 23:01:01 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Rob Landley <landley@trommello.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] klibc requirements, round 2
In-Reply-To: <20020116034128.CRCI26021.femail12.sdc1.sfba.home.com@there>
Message-ID: <Pine.GSO.4.21.0201152252170.4339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, Rob Landley wrote:

> Let's focus on how to separate the volatile parts of initramfs that have to 
> stay in the kernel tree, and the non-volatile parts that can talk to the rest 
> of the kernel through cleanly defined APIs the kernel must support.
> 
> If a section of code can't talk to the kernel through a stable API, it can 
> never be moved out of the kernel tree, and there's not too much point in 
> moving it out of the kernel proper, really...

The whole fscking point is to _avoid_ special API.  System calls.  Normal,
usual system calls and nothing else.

And frankly, moving out of the kernel tree is the least of my worries -
if it's a normal userland code it's fine with me.

I don't see any problems with having the first component of image
generated when you build the kernel - as the matter of fact you
want that, since there is no reason to have nfsroot code there if you
don't support NFS, etc.

