Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262007AbREPSXs>; Wed, 16 May 2001 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261989AbREPSXi>; Wed, 16 May 2001 14:23:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3556 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261988AbREPSXX>;
	Wed, 16 May 2001 14:23:23 -0400
Date: Wed, 16 May 2001 14:23:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Rohland <cr@sap.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <m3wv7h5p7q.fsf@linux.local>
Message-ID: <Pine.GSO.4.21.0105161416120.26191-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 May 2001, Christoph Rohland wrote:

> Why do you use ramfs? Most of it is duplicated in tmpfs and ramfs is a
> minimal _example_ fs. There was some agreement that this should stay
> so.

Because what I need is an absolute minimum. Heck, I don't even use
regular files (in the full variant of patch, that is). They might
become useful, but I can live with mkdir() and mknod(). Moreover,
I want it mounted very early. Right now I'm doing that after initcalls,
but there's a very good reason to move the thing as early as possible.
So the fewer things it uses - the better.

