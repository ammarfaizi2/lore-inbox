Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272062AbRIVU3B>; Sat, 22 Sep 2001 16:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRIVU2v>; Sat, 22 Sep 2001 16:28:51 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:29703 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S272191AbRIVU2l>;
	Sat, 22 Sep 2001 16:28:41 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200109222028.f8MKSmY97869@saturn.cs.uml.edu>
Subject: Re: Tainting kernels for non-GPL or forced modules
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 22 Sep 2001 16:28:48 -0400 (EDT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <27975.1001164529@ocs3.intra.ocs.com.au> from "Keith Owens" at Sep 22, 2001 11:15:29 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:

> I have started work on the patch for /proc/sys/kernel/tainted with the
> corresponding modutils and ksymoops changes.  insmod of a non-GPL
> module ORs /proc/sys/kernel/tainted with 1, insmod -f ORs with 2.

So now these will taint the kernel?

LGPL
2-clause BSD
X11
public domain

They are all non-GPL.

> What to do about modules with no license?  Complain and taint or
> silently ignore?  A lot of modules in -ac14 have no MODULE_LICENSE,
> probably because they have no MODULE_AUTHOR.  IMHO the default should
> be complain and taint, even though it will generate lots of newbie
> questions to l-k.

Give them separate bits.

0x00000001 unknown license
0x00000002 fully GPL-compatible license (GPL, LGPL, 2-clause BSD, X11)
0x00000004 other certified "Open Source" license (MPL, 4-clause BSD)
0x00000008 source available, but w/o certified "Open Source" licensing
0x00000010 no source available
0x00000020 non-redistributable binary
0x10000000 any module at all (prove that user did load a module)
0x20000000 insmod -f
0x40000000 hacked in, using System.map
0x80000000 hacked in with unresolved references

