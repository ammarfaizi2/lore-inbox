Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135274AbRDLTaN>; Thu, 12 Apr 2001 15:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135273AbRDLT3m>; Thu, 12 Apr 2001 15:29:42 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:10127 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135271AbRDLT3f>; Thu, 12 Apr 2001 15:29:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 12:29:33 -0700
Message-Id: <200104121929.MAA04049@adam.yggdrasil.com>
To: drepper@cygnus.com
Subject: Re: List of all-zero .data variables in linux-2.4.3 available
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Adam Richter
>  = Ulrich Drepper

>> >Shouldn't a compiler be able to deal with this instead?
>> 
>> 	Yes.

>No.  gcc must not do this.  There are situations where you must place
>a zero-initialized variable in .data.  It is a programmer problem.

	I am aware of a couple of cases where code relied on static
variables being allocated contiguously, but, in both cases, those
variables were either all zeros or all non-zeros, so my proposed
change would not break such code.  Also, variables being allocated
contiguously is not an assumption supported by any standard that
I am aware of, and the very rare cases where code relies on this
should instead use an array (they've been of the same type in the
examples that I have come across).  At the very least, it seems
to me that this should be a compiler optimization flag, preferably
defaulted to "on".

	If you have some other scenario in mind, I'd appreciate an
example or a clear reference to some explanation, and I think others
on linux-kernel would probably appreciate that too.  It is a topic
that comes up repeatedly on linux-kernel.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
