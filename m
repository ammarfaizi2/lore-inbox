Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTFIBZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 21:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFIBZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 21:25:05 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:32778 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S264075AbTFIBZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 21:25:01 -0400
Message-Id: <200306090138.h591cJS11030@pincoya.inf.utfsm.cl>
To: James Stevenson <james@stev.org>
cc: Lars Unin <lars_unin@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: What are .s files in arch/i386/boot 
In-reply-to: Your message of "Sat, 07 Jun 2003 21:05:42 +0100."
             <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 08 Jun 2003 21:38:19 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Unin <lars_unin@linuxmail.org> said:
> James Stevenson <james@stev.org> said:
> > > > What are .s files in arch/i386/boot, are they c sources of some sort?
> > > > Where can I find the specifications documents they were made from? 
> > > 
> > > There are not c files.
> > > They are assembler files
> > > 
> > > Try running gcc on a c file with the -S option
> > > it will generate the same then you can tweak the
> > > assembler produced to make it faster.
> > > 
> > Where can I find the .c files they were made from,

Those files are smallish routines that can't be sanely written in C, or (in
the case of the bootstrap stuff) are for running on the 8086 your latest
CPU thinks it is when booting. No support for that from gcc.

> > and the spec sheets the .c files were made from? 

If they where around once, they have been long plastered over by patches
that make them useless now.

> You would have to find the original author of the person
> who tweaks the assembler in the .s file chances are the .c
> file is long gone though.

Probably never was. Only way out is as they say: "Use the source, Luke".

You'd better get a book on ia32 (caution, the intel sytax almost all are
written for is truly bletcherous, and does things just different enough
from the AT&T sytax gcc/the kernel uses to make your head spin when trying
to map back and forth). There was an HOWTO on assembly language programming
under Linux, haven't looked at it in a long time. 

> Why do all .c files have to be generated from a spec sheet ?

Now that is a good question... never used one in my life :-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
