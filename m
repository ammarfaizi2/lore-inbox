Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278038AbRJVHnB>; Mon, 22 Oct 2001 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278052AbRJVHmv>; Mon, 22 Oct 2001 03:42:51 -0400
Received: from rj.sgi.com ([204.94.215.100]:22415 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278045AbRJVHml>;
	Mon, 22 Oct 2001 03:42:41 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Albert Bartoszko <albertb@nt.kegel.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: Your message of "Mon, 22 Oct 2001 02:47:39 -0400."
             <Pine.GSO.4.21.0110220242290.2294-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 22 Oct 2001 17:42:28 +1000
Message-ID: <23368.1003736548@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 02:47:39 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>Check that your modules.conf contains
>
>post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
>pre-remove binfmt_misc umount /proc/sys/binfmt_misc
>
>That should've been there for quite a while, actually.  Keith?

It is not hard wired in the standard modutils, because there is no way
of overriding it.  If the kernel changes the way that binfmt_misc is
handled then users would be stuffed.

RedHat hard code binfmt_misc into their version of modutils but I won't
take the patch, users have to edit modules.conf themselves.

