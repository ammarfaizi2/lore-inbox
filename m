Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129514AbQKWCtw>; Wed, 22 Nov 2000 21:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129529AbQKWCtn>; Wed, 22 Nov 2000 21:49:43 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:42784 "EHLO
        deliverator.sgi.com") by vger.kernel.org with ESMTP
        id <S129514AbQKWCtS>; Wed, 22 Nov 2000 21:49:18 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the Oops-message 
In-Reply-To: Your message of "Wed, 22 Nov 2000 20:58:28 CDT."
             <200011230158.eAN1wSr138515@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Nov 2000 13:19:05 +1100
Message-ID: <3445.974945945@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000 20:58:28 -0500 (EST), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>The infamous LINK_FIRST infrastructure was sort of half-way done.
>
>It would be best to cause drivers with an unspecified link order
>to move around a bit, so that errors may be discovered more quickly.

The "other" list in LINK_FIRST is sorted by name.  It could be changed
to a random sort, probably based on a hash of size and mtime.  It would
be relatively expensive so would have to be restricted to a "exercise
the kernel" CONFIG option.

>LINK_FIRST is pretty coarse. One would want a topological sort,
>or at least LINK_0 through LINK_9 _without_ anything else.

There is no need for multiple LINK_n entries, the objects partition
neatly into three groups.  LINK_FIRST objects, in the order they are
defined.  The rest of the objects (object list - (LINK_FIRST +
LINK_LAST), in an undefined order.  LINK_LAST objects, in the order
they are defined.

If you can come up with a concrete link order example that cannot be
handled by a three partition model then I will listen.  Otherwise it is
just over engineering.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
