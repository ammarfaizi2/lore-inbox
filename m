Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261671AbTCGSYK>; Fri, 7 Mar 2003 13:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261673AbTCGSYK>; Fri, 7 Mar 2003 13:24:10 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:42398 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S261671AbTCGSYJ>; Fri, 7 Mar 2003 13:24:09 -0500
Subject: Re: [patch] oprofile for ppc
From: Albert Cahalan <albert@users.sf.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       Segher Boessenkool <segher@koffie.nl>, o.oppitz@web.de,
       afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <1047032003.12206.5.camel@zion.wanadoo.fr>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu> 
	<1047032003.12206.5.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Mar 2003 13:31:01 -0500
Message-Id: <1047061862.1900.67.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 05:13, Benjamin Herrenschmidt wrote:
> On Fri, 2003-03-07 at 10:29, Albert D. Cahalan wrote:

>> This is basic timer profiling for ppc, tested on the
>> 2.5.62 linuxppc kernel. It's a port of the ppc64 code.
>
> I'm sure I missed something... but I fail to see the the
> interest in profiling based on sampling the instruction ptr
> on a 100 Hz basis. This is way to slow to give any useful
> results imho

This is just the first part of the code. Please merge it
into any tree you have, unless it's obviously broken.
It is useful for long-running processes that don't do
much that is tied to the clock tick. (number crunching,
maybe X, web browsers without animations, /tmp cleaner...)

The i386 port is already using 1000 Hz in the kernel,
and has 100 Hz as a non-default option. I'd really like
to have this on my Mac; lots of things would improve.

I intend to allow sampling based on the performance counter
interrupt/trap/exception and the external interrupt signal.


