Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTJCPE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTJCPE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:04:27 -0400
Received: from [139.30.44.2] ([139.30.44.2]:21124 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263749AbTJCPEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:04:04 -0400
Date: Fri, 3 Oct 2003 17:03:52 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Russell King <rmk@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] remove unnecessary #includes from <linux/fs.h>
In-Reply-To: <20031002161639.GF10382@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0310031609040.18482-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You didn't comment on my suggestion, so I've done it manually once for
> linux/fs.h and was shocked.  It still passes my compile-standalone
> test after removing 11! #include lines.

A compile-standalone test is a necessary condition but not a sufficient
one. There can be many reasons why the includes might still be needed:
 - the compile-test might depend on the specific configuration.
 - the included header might be needed when the macros are used, not when
   they are defined.
 - indirect includes
 - ...
As you probably know, I tried to clean up sched.h, and it was extremely
complicated to get right. So this definitely is 2.7 material.

Tim

