Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTIMLCl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTIMLCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:02:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:54243 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262120AbTIMLCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:02:39 -0400
Date: Sat, 13 Sep 2003 13:02:36 +0200 (MEST)
Message-Id: <200309131102.h8DB2aoA021591@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@fs.tum.de
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003 01:23:04 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
>Considering this, I can simply do the following in my proposal of 
>offering every CPU type to the user?
>
>config X86_BAD_APIC
>	bool
>	depends on CPU_586TSC
>	default y

That depends on your semantics for CPU_586TSC.
If it is required for support of pre-MMX P5s, then yes.
With the current semantics, where a CPU choice simply
sets a lower bound, then no.

/Mikael
