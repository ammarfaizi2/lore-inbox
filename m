Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbSJCQD3>; Thu, 3 Oct 2002 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSJCQD3>; Thu, 3 Oct 2002 12:03:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56336 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261764AbSJCQD2>; Thu, 3 Oct 2002 12:03:28 -0400
Date: Thu, 3 Oct 2002 08:57:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: jbradford@dial.pipex.com
cc: jgarzik@pobox.com, <kessler@us.ibm.com>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <saw@saw.sw.com.sg>,
       <rusty@rustcorp.com.au>, <richardj_moore@uk.ibm.com>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
 logging macros, SCSI RAIDdevice)
In-Reply-To: <200210031551.g93FpwsR000330@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Oct 2002 jbradford@dial.pipex.com wrote:
> 
> I think we should stick to incrementing the major number when binary
> compatibility is broken.

"Stick to"? We've never had that as any criteria for major numbers in the
kernel. Binary compatibility has _never_ been broken as a release policy,
only as a "that code is old, and we've given people 5 years to migrate to
the new system calls, the old ones are TOAST".

The only policy for major numbers has always been "major capability
changes". 1.0 was "networking is stable and generally usable" (by the
standards of that time), while 2.0 was "SMP and true multi-architecture
support". My planned point for 3.0 was NuMA support, but while we actually
have some of that, the hardware just isn't relevant enough to matter.

The memory management issues would qualify for 3.0, but my argument there 
is really that I doubt everybody really is happy yet. Which was why I 
asked for people to test it and complain about VM behaviour - and we've 
had some ccomplaints ("too swap-happy") although they haven't sounded like 
really horrible problems.

		Linus

