Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319050AbSHMSCZ>; Tue, 13 Aug 2002 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319051AbSHMSCZ>; Tue, 13 Aug 2002 14:02:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16653 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319050AbSHMSCA>; Tue, 13 Aug 2002 14:02:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc and logging
Date: 13 Aug 2002 11:05:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajbhph$afd$1@cesium.transmeta.com>
References: <20020813101237.GA27879@codepoet.org> <Pine.GSO.4.21.0208130626481.1689-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0208130626481.1689-100000@weyl.math.psu.edu>
By author:    Alexander Viro <viro@math.psu.edu>
In newsgroup: linux.dev.kernel
> 
> See below - it's crud, but it works.  Based of fs/nfs/nfsroot.c, moved
> to userland with RPC done via syscalls and nothing else.  Arguments are
> passed via environment variables, replacing that with use of argv is
> trivial...   Other than syscalls uses: alarm(3), getenv(3), str... and
> mem..., {s,}printf(3), htonl(3) and htons(3).  About 4Kb of .text + .data
> and aforementioned functions shouldn't add much to that.
> 

FWIW, the attached program compiles fine against klibc:

: tazenda 36 ; ls -l tests/nfs_no_rpc.stripped 
-rwxrwxr-x    1 hpa      eng         11124 Aug 13 10:57 tests/nfs_no_rpc.stripped*

I have checked it in to the tests/ directory of klibc with a few minor
warnings cleanups, but without messing around with things like adding
command-line parsing (which would be trivial; use getopt()).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
