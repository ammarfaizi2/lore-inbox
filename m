Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316195AbSEKCcy>; Fri, 10 May 2002 22:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316196AbSEKCcx>; Fri, 10 May 2002 22:32:53 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38541 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316195AbSEKCcw>; Fri, 10 May 2002 22:32:52 -0400
Date: Fri, 10 May 2002 21:32:44 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Hugh Dickins <hugh@veritas.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: <Pine.LNX.4.21.0205110255410.2235-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0205102125590.11642-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002, Hugh Dickins wrote:

> Is there some escaped syntax whereby we can (usefully) put
> KBUILD_BASENAME into the BUG() macro in place of __FILE__?

It doesn't help. When compiling, KBUILD_BASENAME is the name of the main
source file, i.e. the one given on the command line (basically the same
thing as __BASEFILE__ or whatever that gcc preprocessor variable is
called).

You don't want to get "BUG at foo:23", when the BUG instruction is
actually at filesystem.h:23. Only the compiler knows which source file it
is currently dealing with.

--Kai



