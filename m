Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRHQFDP>; Fri, 17 Aug 2001 01:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269712AbRHQFDF>; Fri, 17 Aug 2001 01:03:05 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:5259 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269698AbRHQFCy>; Fri, 17 Aug 2001 01:02:54 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Aug 2001 22:03:07 -0700
Message-Id: <200108170503.WAA07234@baldur.yggdrasil.com>
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	The macro "min(n1,n2)", is a very standard practice in C
programming.  Having a different version of "min" adds unnecessary
porting work and ifdef clutter when code is port between the kernel
and other uses (typically small mathematical calculations, data
structure manipulations, and data stream tranformations like
compression and encryption, such as in freeswan, which I had to
modify).

	If a programmer wants to explicitly specify which type the
comparison converts to, then he or she can cast the arguments explicitly.
Programmers already have the opportunity "to think about it." Impeding
programming just to make programmers "think about it" rather than
treating their time as precious and letting them determine how to
invest it is rarely a winning trade-off, especially when you also
weigh the quality effects of increased code clutter and less programmer
time available for other improvements.  To call this change Pascal-like
would be an insult to Pascal.

	If you really want this facility, you could just declare
a distinct "typed_min" macro.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
