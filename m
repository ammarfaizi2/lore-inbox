Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129707AbQLEH1h>; Tue, 5 Dec 2000 02:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129799AbQLEH11>; Tue, 5 Dec 2000 02:27:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:784 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129707AbQLEH1O>; Tue, 5 Dec 2000 02:27:14 -0500
Date: Mon, 4 Dec 2000 23:19:28 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Athlon CPU
In-Reply-To: <Pine.LNX.4.30.0012050205570.2065-100000@lt.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.30.0012042315410.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Lukasz Trabinski wrote:

>Date: Tue, 5 Dec 2000 02:19:55 +0100 (CET)
>From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
>To: linux-kernel@vger.kernel.org
>Cc: jakub@redhat.com
>Content-Type: TEXT/PLAIN; charset=ISO-8859-2
>Subject: Problems with Athlon CPU
>
>Hello
>
>There is probably not a kernel bug, but bug in gcc, but... :)

It is a kernel bug.

[SNIP]

>gcc version 2.96 20000731 (Red Hat Linux 7.0)
 ^^^^^^^^^^^^^^^^

You can't build a kernel with that compiler.  You _must_ use gcc
2.91.66 or another compiler that can compile the kernel.  Red Hat
ships gcc 2.91.66 packaged as "kgcc" for kernel builds as do
other major vendors.

You must edit the top level makefile appropriately first before
building.

>[lukasz@beer lukasz]$ rpm -q glibc
>glibc-2.2-5

The kernel doesn't use any libc so it doesn't matter.

>Any sugestions? On others machines with AMD-K6 or Petnium-III/II and
>with the same version of glibc and gcc that problems does not exists!

No, you must have a different gcc on the other machines.  You
can't build a kernel with gcc 2.96 as the kernel is buggy.


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

If you think C++ is not overly complicated, just what is a protected
abstract virtual base pure virtual private destructor, and when
was the last time you needed one?
  -- Tom Cargill, C++ Journal, Fall 1990.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
