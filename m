Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132477AbQLRSuw>; Mon, 18 Dec 2000 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbQLRSum>; Mon, 18 Dec 2000 13:50:42 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:21005 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S132477AbQLRSua>; Mon, 18 Dec 2000 13:50:30 -0500
From: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
Date: 18 Dec 2000 18:20:07 GMT
Organization: Cistron Internet Services B.V.
Message-ID: <91lkgn$ef$2@enterprise.cistron.net>
In-Reply-To: <20001217153444N.dyky@df-usa.com> <20001218033154.F3199@cadcamlab.org> <20001218154907.A16749@athlon.random> <20001218184531Z132357-439+4699@vger.kernel.org>
X-Trace: enterprise.cistron.net 977163607 463 195.64.65.67 (18 Dec 2000 18:20:07 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: miquels@traveler.cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001218184531Z132357-439+4699@vger.kernel.org>,
Timur Tabi  <ttabi@interactivesi.com> wrote:
>** Reply to message from Peter Samuelson <peter@cadcamlab.org> on Mon, 18 Dec
>2000 09:03:00 -0600 (CST)
>> Not a compiler bug, a source bug of assuming a C header file can be
>> included by a C++ program.  The right solution, as always, is to make a
>> copy of the header (assuming you really do need it) and edit the copy
>> as necessary. 
>
>That just creates more maintenance problems.  What if the kernel header file
>changes?  Then he'll have to change his copy as well.  He'll forever need to
>check changes in that kernel header file, or risk having an obscure bug that's
>otherwise hard to track.

No, in fact that is the desired behaviour. If the kernel include files
change, chances are very big that the source of the utility (or library)
needs adjustments as well. In fact if you simply recompile the old
source with the new header files you might get unwanted and unexpected
behaviour, whereas if you recompile with the older header defs you'll
simply use an advertized api that might not be the latest but works

Mike.
-- 
RAND USR 16514
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
