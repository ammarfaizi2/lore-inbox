Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTIGQsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTIGQsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:48:06 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:1514 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261754AbTIGQsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:48:04 -0400
Date: Sun, 7 Sep 2003 18:47:51 +0200 (MEST)
Message-Id: <200309071647.h87Glp4t014359@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: robert@schwebel.de, rusty@rustcorp.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Sep 2003 13:28:13 +0200, Adrian Bunk wrote:
>The patch below tries to implement a better i386 CPU selection.
>
>In 2.4 selecting e.g. M486 has the semantics to get a kernel that runs 
>on a 486 and above.
>
>In 2.6 selecting M486 means that only the 486 is supported.

Can you prove your claim about 2.6?

There is to the best of my knowledge nothing in 2.6.0-test4
that prevents a kernel compiled for CPU type N from working
with CPU types >N. Just to prove it, I built a CONFIG_M486
2.6.0-test4 and booted it w/o problems on P4, PIII, and K6-III.

>There are two different needs:
>1. the installation kernel of a distribution should support all CPUs 
>   this distribution supports (perhaps starting with the 386)
>2. a sysadmin might e.g. want a kernel that support both a Pentium-III
>   and a Pentium 4, but doesn't need to support a 386

How are 1 and 2 different? Both need support for CPU type N
or higher. Since a kernel configured for a lower CPU type
still works on higher CPU types, where is the problem?
(In case 2 configure for PIII and use that on PIII and P4.)

Maybe I'm missing something but I don't see any problem here.

/Mikael
