Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132227AbQLNNNC>; Thu, 14 Dec 2000 08:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbQLNNMn>; Thu, 14 Dec 2000 08:12:43 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:7690 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S132227AbQLNNMb>;
	Thu, 14 Dec 2000 08:12:31 -0500
Date: Thu, 14 Dec 2000 04:42:03 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
Message-ID: <Pine.SUN.3.96.1001214042948.15033A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is unrelated to the signal 11 problem, but something to consider
for "random crashes and segfaults", ie are you using this compiler
and glibc version combination.

There has a been a thread on the teTeX mailing list the last few days
about a (RedHat, but probably more general than just their rpms)
gcc-2.9.6 w/glibc-2.2.x bug. At -O2, it can miscompile 

unsigned varname; /* "unsigned int varname;" is ok */

(no problem at -O or no optimization at all, and doesn't happen if teTeX
is compiled with kgcc).

Showed up in the kpathsea library (which began to split paths on
'-' as well as '/' after a user upgraded compiler and libc and
recompiled teTeX).

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
