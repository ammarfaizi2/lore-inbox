Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbTJJAOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJJAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:14:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:19982 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262678AbTJJAON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:14:13 -0400
Date: Fri, 10 Oct 2003 02:13:52 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Willy TARREAU <willy@w.ods.org>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: iproute2 not compiling anymore
Message-ID: <20031010001352.GA2728@pcw.home.local>
References: <20031005130044.GA8861@pcw.home.local> <Pine.LNX.4.44.0310091051240.3040-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091051240.3040-100000@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Thu, Oct 09, 2003 at 10:52:05AM -0300, Marcelo Tosatti wrote:
 
> David seems to have fixed it. Mind trying to again with the latest BK 
> tree?

I have just checked, but I still get the errors, although the patch looks fine
at first glance. I wondered whether I was doing something wrong, so I rechecked
and it compiles cleanly with 2.4.21, and does not since 2.4.22. Unfortunately,
I'm too tired to investigate more, so I should do it tomorrow. Here is the
compilation output, just in case it helps David. Please ask for .config if
needed, but I don't think so.

Cheers,
Willy

$ make KERNEL_INCLUDE=/usr/src/linux-2.4.23-pre6-20031009/include
make[1]: Entering directory `/data/src/net/ip-routing/iproute2-2.4.7-020116/lib'
gcc -D_GNU_SOURCE -O2 -Wstrict-prototypes -Wall -g -I../include-glibc -I/usr/include/db3 -include ../include-glibc/glibc-bugs.h -I/usr/src/linux-2.4.23-pre6-20031009/include -I../include -DRESOLVE_HOSTNAMES   -c -o ll_map.o ll_map.c
In file included from ../include-glibc/netinet/in.h:7,
                 from ll_map.c:19:
/usr/src/linux-2.4.23-pre6-20031009/include/linux/in.h:141: field `gr_group' has incomplete type
/usr/src/linux-2.4.23-pre6-20031009/include/linux/in.h:147: field `gsr_group' has incomplete type
/usr/src/linux-2.4.23-pre6-20031009/include/linux/in.h:148: field `gsr_source' has incomplete type
/usr/src/linux-2.4.23-pre6-20031009/include/linux/in.h:154: field `gf_group' has incomplete type
/usr/src/linux-2.4.23-pre6-20031009/include/linux/in.h:157: field `gf_slist' has incomplete type
make[1]: *** [ll_map.o] Error 1
make[1]: Leaving directory `/data/src/net/ip-routing/iproute2-2.4.7-020116/lib'
make: *** [all] Error 2
$
