Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTDZU0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 16:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTDZU0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 16:26:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:27857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263026AbTDZU0H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 16:26:07 -0400
Date: Sat, 26 Apr 2003 13:36:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: missing #includes?
Message-Id: <20030426133633.039c616e.rddunlap@osdl.org>
In-Reply-To: <20030426203136.GA3456@wohnheim.fh-wedel.de>
References: <20030425235119.6f337e70.randy.dunlap@verizon.net>
	<20030426203136.GA3456@wohnheim.fh-wedel.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Apr 2003 22:31:36 +0200 Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

| On Fri, 25 April 2003 23:51:19 -0700, Randy.Dunlap wrote:
| > 
| > I wrote a trivial bash script to check if <sourcefiles> #include
| > <headerfile> when <symbol> is used.   Run it at top of kernel tree,
| > like so:
| > 
| > $ check-header  STACK_MAGIC   linux/kernel.h
| > error: linux/kernel.h not found in ./arch/h8300/kernel/traps.c
| > 
| > 
| > What's the preferred thing to do here?  I would like to see explicit
| > #includes when symbols are used.  Is that what others expect also?
| > 
| > However, it makes for quite a large list of missing includes.
| 
| As long as it doesn't change the kernel binary, I don't have a strong
| opinion. Explicit #includes are nicer, but is it worth the trouble?
| Do the implicit #includes hurt anywhere? I don't know.

I don't think that it changes the kernel binary (but I haven't tested
that).  Of course the files are being included already, since they
build and since these "missing #include files" are listed in build
files like "kernel/.panic.o.cmd".

Thanks,
--
~Randy
