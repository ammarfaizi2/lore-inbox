Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbVCWJaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVCWJaY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVCWJaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:30:24 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:23557 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S262897AbVCWJaP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:30:15 -0500
Message-ID: <4636.194.237.142.10.1111570214.squirrel@194.237.142.10>
In-Reply-To: <Pine.LNX.4.60.0503231042480.21050@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0503231042480.21050@lantana.cs.iitm.ernet.in>
Date: Wed, 23 Mar 2005 10:30:14 +0100 (CET)
Subject: Re: segmentation fault while loading modules
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "Payasam Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my makefile is:
>
> TARGET  := signal4
> WARN    := -W -Wall -Wstrict-prototypes -Wmissing-prototypes
> INCLUDE := -isystem /lib/modules/2.4.20-8feb9.1/build/include
> CFLAGS  := -O2 -DMODULE -D__KERNEL__ ${WARN} ${INCLUDE}
> CC      := gcc
>
> ${TARGET}.o: ${TARGET}.c
>
> .PHONY: clean
>
>
> Any suggestions are welcome.

It may be due to inconsistency in gcc flags.

Plase try with a simpler Makefile:
Makefile:
obj-m := signal4.o

And compile with:
make -C /lib/modules/2.4.20-8feb9.1/build SUBDIRS=`pwd` modules

This will make sure you use correct gcc flags.

    Sam


