Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTFIDiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTFIDiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 23:38:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45319 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263990AbTFIDiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 23:38:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH][SPARSE] Runtime detection of gcc include paths
Date: 8 Jun 2003 20:51:18 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bc107m$ue3$1@cesium.transmeta.com>
References: <20030609011128.GI20872@michonline.com> <Pine.LNX.4.44.0306081807500.1849-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0306081807500.1849-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> On Sun, 8 Jun 2003, Ryan Anderson wrote:
> >
> > This uses the same method as previously was used, it just performs the
> > lookup at runtime.
> 
> I much prefer a compile-time thing.
> 
> Performance is, to me, paramount for "checker". I don't want to slow it 
> down, I'm hoping that some day we can just enable C=1 by default in the 
> kernel build (this is a _long_ time off, though, don't you all start 
> worrying now).
> 
> I don't see anything wrong with a compile/install time thing, that is, 
> after all, how gcc too works.
> 

Both of these seem a little unnecessary.  Why not pass this stuff on
the command line, and have the top-level Makefile extract the paths
into a command-line argument?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
