Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbUDTOLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbUDTOLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDTOLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:11:45 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:49088 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263059AbUDTOLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:11:42 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: [somewhat OT] binary modules agaaaain
Date: Tue, 20 Apr 2004 16:11:07 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404201611.07832.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 of April 2004 17:53, Guennadi Liakhovetski wrote:
> Hello all
>
> I came across an idea, how Linux could allow binary modules, still having
> reasonable control over them.
>
> I am not advocating for binary modules, nor I am trying to make their life
> harder, this is just an idea how it could be done.
>
> I'll try to make it short, details may be discussed later, if any interest
> arises.
>
> A binary module is "considered good" if

This is a false assumption IMO no binary only modules can be "good".

> 1) It is accompanied by a "suitably licensed" (GPL-compatible) open-source
>    glue-module.
>
> 2) The sourced used to compile the binary part do not access any of the
>    kernel functionalities directly. Which means:
> 	a) they don't (need to) include any kernel header-files
> 	b) they don't access any kernel objects or methods directly
> 	c) all interfacing to the kernel goes over the glue module and the
> 	   interface is _purely functional_ - no macros, no inlines.

What you've just described are the most evil binary only modules. :-)


Please think a while about all these recent "the most famous binary module"
vs 4kb kernel stacks mails...

I think that binary modules are evil because:

- they slow down development (indirectly - think about it)

- some vendors claim Linux support
  while they only provide binary only modules

- less informed users tend to put blame on kernel or distribution
  not the binary only module (!)

I'm not a fanatic :-), I can see good sides of binary only modules:

- additional hardware and features is supported

- wider usage of Linux

but I still think that cons > pros...

> With this restrictions those "good" binary modules could be debugged, run
> in a sandbox... The question remains if anybody will want to debug them:-)

In my opinion using binary only modules is equal to modifying your kernel
but being unable to show your modifications so you are on your own and you
shouldn't bring it on lkml.

> Again - no advocating, just in case anyone find it useful / worthy.

Useful thing will be to create mailing list about Linux kernel
+ binary only modules and to move discussion from lkml there...

Regards,
Bartlomiej

