Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278382AbRJSMyj>; Fri, 19 Oct 2001 08:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278383AbRJSMya>; Fri, 19 Oct 2001 08:54:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:40165 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278382AbRJSMyP>;
	Fri, 19 Oct 2001 08:54:15 -0400
Date: Fri, 19 Oct 2001 08:54:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Albert Bartoszko <albertb@nt.kegel.com.pl>
cc: rguenth@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <001e01c15894$cfdf3340$0100050a@abartoszko>
Message-ID: <Pine.GSO.4.21.0110190845580.22889-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Oct 2001, Albert Bartoszko wrote:

> Hello
> 
> I find bug in  binfmt_misc.c from kernel 2.4.12 source. The read() syscal

	only one?

> return bad value, causes some application SIGSEGV.

Hardly a surprise.  Not everything that passes compiler is valid C.
Stuff in fs/binfmt_misc.c from Linus' tree isn't.  Pick one from -ac
+ corresponding change in fs/proc/root.c (again, see -ac).  Variant
in Linus' tree is complete crap.

<goes back to sleep>

