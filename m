Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSKLLVx>; Tue, 12 Nov 2002 06:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKLLVx>; Tue, 12 Nov 2002 06:21:53 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:23784 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S266478AbSKLLVw>; Tue, 12 Nov 2002 06:21:52 -0500
Date: Tue, 12 Nov 2002 12:29:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
In-Reply-To: <aqmait$tmb$1@forge.intermeta.de>
Message-ID: <Pine.GSO.3.96.1021112122728.1317H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Nov 2002, Henning P. Schmiedehausen wrote:

> > - a kernel compiled for TSC-only. This one simply will not _work_ without 
> >   a TSC, since it is statically compiled for the TSC case. Here, "notsc"
> >   simply cannot do anything, so it just prints a message saying that it 
> >   doesn't work.
> 
> IMHO, if you boot a "TSC-only" kernel on a machine without TSC, the correct
> answer should be 
> 
> Panic: This kernel is compiled for TSC-only. No TSC found.
> Machine halted.

 And that happens -- see check_config() in <asm-i386/bugs.h>.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

