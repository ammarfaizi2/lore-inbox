Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTBIQB5>; Sun, 9 Feb 2003 11:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbTBIQB5>; Sun, 9 Feb 2003 11:01:57 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:4617 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267282AbTBIQB4>; Sun, 9 Feb 2003 11:01:56 -0500
Date: Sun, 9 Feb 2003 17:11:37 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ENTRY-macro in linkage.h
In-Reply-To: <3E464B14.5040004@pulsar.homelinux.net>
Message-ID: <Pine.LNX.4.44.0302091707320.32518-100000@serv>
References: <3E45358F.8020509@pulsar.homelinux.net>
 <1044752435.18908.23.camel@irongate.swansea.linux.org.uk>
 <3E464B14.5040004@pulsar.homelinux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Feb 2003, Uwe Reimann wrote:

> My problem is how to add the whitespace. The preprocessor seems to strip 
> it. Consider this (test.S):
> 
> #define ENTRY(X) \
>   .global X##; \
> X##:   
> 
> ENTRY(foo)
> ENTRY(bar)
> 
> gcc -S test.S:
> 
> .global foo; foo:
> .global bar; bar:
> 
> For c4x-gcc, this has to be like this:
> 
>     .global foo
> foo:
>     .global bar
> bar:
> 
> Without the leading whitespace, .global is taken as a name of a label. 
> Without the newline before the labels, they are not recognized (taken as 
> comments).

You don't have to use the ENTRY macro anymore, it was useful when kernel 
could be in a.out format, so the underscore was automatically prepended to 
the symbol.

bye, Roman

