Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRDMTio>; Fri, 13 Apr 2001 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDMTie>; Fri, 13 Apr 2001 15:38:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35090 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131644AbRDMTiX>; Fri, 13 Apr 2001 15:38:23 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yacc in 2.4.3 causes kernel compile to fail (aicasm_gram.y)
Date: 13 Apr 2001 12:38:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b7kis$f1h$1@cesium.transmeta.com>
In-Reply-To: <061f01c0c3d8$c34e8870$5c044589@legato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <061f01c0c3d8$c34e8870$5c044589@legato.com>
By author:    "David E. Weekly" <dweekly@legato.com>
In newsgroup: linux.dev.kernel
> 
> This is the first time I remember seeing a Yacc file in the Linux kernel
> source code, but I'm young and stupid.
> 
> Since the default Makefile mapping for .y files is to call yacc, and since I
> have bison on my system instead, compiling the aic7xxx code into 2.4.3 broke
> my build.
> 

It's a good idea if you have bison installed to have a /usr/bin/yacc
containing:

	#!/bin/sh -
	exec bison -y "$@"

I think there is a reasonably good expectation that the command "yacc"
should do what is expected, without needing any special hacks for
bison -- unless, of course, you're using bison special features.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
