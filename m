Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbTCPEVF>; Sat, 15 Mar 2003 23:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbTCPEVF>; Sat, 15 Mar 2003 23:21:05 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:48646 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262317AbTCPEVF>; Sat, 15 Mar 2003 23:21:05 -0500
Subject: Re: [patch] NUMAQ subarchification
From: James Bottomley <James.Bottomley@steeleye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, colpatch@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1047776836.1327.11.camel@irongate.swansea.linux.org.uk>
References: <1047676332.5409.374.camel@mulgrave>
	<3E7284CA.6010907@us.ibm.com> <3E7285E7.8080802@us.ibm.com>
	<247240000.1047693951@flay> 
	<1047776836.1327.11.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 Mar 2003 22:31:43 -0600
Message-Id: <1047789106.1964.189.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 19:07, Alan Cox wrote:
> It was fixed in about 2.5.50-ac. I thought Linus had picked up the 
> improved version of mach-default* too. Its used extensively for stuff
> like PC9800 which is deeply un-PC

Actually, we have all that in the mainline.  It was the .h fallback to
mach-defaults.

The issue here is that mach-numaq and mach-summit are very PC like and
so don't need any of the hooks that are in setup.c, thus they'd like to
share setup.c from mach-default.  Likewise, they have the same topology
file, I think (although this time it would be different from
mach-default since we can pull the numa pieces out).  Prior to the build
changes, VPATH would solve this problem (I used to use it to get
trampoline.o for voyager).  However, now, the best I think we can do is
to cat the file across.

James


