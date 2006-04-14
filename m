Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWDNLlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWDNLlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDNLlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:41:09 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:8464 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750990AbWDNLlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:41:08 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Ramakanth Gunuganti" <rgunugan@yahoo.com>
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>
Subject: RE: GPL issues
Date: Fri, 14 Apr 2006 04:39:59 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEFLLFAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.61.0604112055380.25940@yvahk01.tjqt.qr>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 14 Apr 2006 04:36:06 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 14 Apr 2006 04:36:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One thing that is clear in the GPL: If you link the kernel with something
> else to an executable, the resulting blob (and therefore the
> sources to the
> proprietary part) must be GPL.

	Actually, that is *far* from clear.

	First, the GPL cannot set its own scope. The GPL could say that if you
stored a program in the same room as a GPL program, the program must be GPL.
So *nothing* the GPL says will answer this question -- the question is, can
the GPL attach by linking?

	The contrary argument would be that linking two programs together is an
automated process. There is no creative input in the linking process. So it
does not legally produce a single work, but a mechanical combination of the
two original works.

	The proof that the executable is not a work for copyright purposes is this
simple -- could a person who took two object files out of the box and linked
them together claim copyright in the new derivative work he just produced? I
think the answer would be obvious -- the executable is not a new work, it's
just the two original works combined.

	Note that this does not mean that *designing* a program specifically to
link to another program can't make it a derivative work of the work you
designed it to go with. Just that the linking itself cannot always do so
automatically.

	In any event, to give my answer to the original question -- if a kernel
module and a userspace program are developed together, and are not both
derived from an API that is independent of the Linux kernel, then they are
probably going to be considered a single work.

	On the flip side, you should be okay if you develop an API for a kernel to
communicate with user space and then develop a user space program that could
work on any kernel (Linux or not, theoretically) that supported that API.
This should ensure that the user space program is derivative only from the
API and not from the Linux kernel.

	Note that you will not be okay if the API looks like what just happen to be
Linux kernel internals. The API itself must be independent of the Linux
kernel internals.

	DS


