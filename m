Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265278AbUENN3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbUENN3L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbUENN3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:29:10 -0400
Received: from rs1.physik.Uni-Dortmund.DE ([129.217.168.30]:26074 "EHLO
	rs1.physik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265278AbUENN3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:29:06 -0400
Date: Fri, 14 May 2004 15:28:38 +0200
From: Robert Fendt <fendt@physik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: peculiar problem with 2.6, 8139too + ACPI
Message-Id: <20040514152838.50b53d1f.fendt@physik.uni-dortmund.de>
Organization: Lehrstuhl =?ISO-8859-1?B?Zvxy?= experimentelle Physik I,
 =?ISO-8859-1?B?VW5pdmVyc2l05HQ=?= Dortmund
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have the following problem: the 8139too driver produces lots of
overruns and is _very_ slow (but strangely not always; the problem seems
to be site-dependant, too). And here is what is weird: if I artifically
raise the system load (e.g. compile a kernel just for fun), the download
speed grows by at least an order of magnitude.

Machine is an Asus M2400N notebook, Centrino-based, 8139-internal (lspci
says rev.10), kernel revisions tested now are 2.6.0, 2.6.3, 2.6.5. I did
not really test 2.6.6 yet, since I am having problems getting the beast
to work correctly. Distribution is Debian/unstable. My home router
(quite an old machine) is not ACPI capable, so it does not show the
problem (see below), and I effectively have only this one 8139-based
system to test.

After some detective work, I have narrowed the problem down to an
apparent conflict between 8139too and the 'processor' module, and
therefore to the ACPI code, which is AFAIK all-new in 2.6. If I rmmod
the module, the network speed is fine, but I lose the option to use the
'thermal' module. The big question is: has anyone an idea whether this
is a bug in the 8139too driver or in the ACPI code (IOW: is the problem
maybe not-too-new after all and I was just too dumb to find it)? Or in
which direction I should look? I am afraid I am no kernel/driver hacker
(but on the other hand not a totally C newbie, either). I just want to
avoid poking around in the dark and crashing my system in the process,
if possible :-)

Regards,
Robert
