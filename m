Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278496AbRJPCJi>; Mon, 15 Oct 2001 22:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278497AbRJPCJ3>; Mon, 15 Oct 2001 22:09:29 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35811 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278496AbRJPCJL>;
	Mon, 15 Oct 2001 22:09:11 -0400
Date: Mon, 15 Oct 2001 22:09:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Tim Hockin <thockin@sun.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alan@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] fix NFS root in 2.4.12
In-Reply-To: <3BCB94E4.AB6703D9@sun.com>
Message-ID: <Pine.GSO.4.21.0110152207520.11608-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Oct 2001, Tim Hockin wrote:

> Linus, Alan,
> 
> This one liner fixes NFS root for kernel 2.4.12.  Please apply.

>-	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", data);
>+	vfsmnt = do_kern_mount("nfs", root_mountflags, "/dev/root", NULL, data);

Had you actually tried to compile that? do_kern_mount() is defined as

struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data)

Where did you find 5th argument?

