Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277976AbRJVGrn>; Mon, 22 Oct 2001 02:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277950AbRJVGrd>; Mon, 22 Oct 2001 02:47:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56509 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277976AbRJVGr2>;
	Mon, 22 Oct 2001 02:47:28 -0400
Date: Mon, 22 Oct 2001 02:47:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Albert Bartoszko <albertb@nt.kegel.com.pl>
cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <010801c15abe$ced47240$0100050a@abartoszko>
Message-ID: <Pine.GSO.4.21.0110220242290.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Albert Bartoszko wrote:

> Linux xxxx 2.4.12-ac3 #1 Sun Oct 21 13:50:52 CEST 2001 i686 unknown
> # insmod binfmt_misc
> Using /lib/modules/2.4.12-ac3/kernel/fs/binfmt_misc.o
> # echo ':Java:M::\xca\xfe\xba\xbe::/usr/local/bin/javawrapper:'
> >/proc/sys/fs/binfmt_misc/register
> bash: /proc/sys/fs/binfmt_misc/register: No such file or directory
> # lsmod
> Module                  Size  Used by
> binfmt_misc             5680   1
> #rmmod binfmt_misc
> binfmt_misc: Device or resource busy                # ?????
> 
> Very high C. But this don't work for me.

Check that your modules.conf contains

post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
pre-remove binfmt_misc umount /proc/sys/binfmt_misc

That should've been there for quite a while, actually.  Keith?


