Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTAYD6P>; Fri, 24 Jan 2003 22:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTAYD6P>; Fri, 24 Jan 2003 22:58:15 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:56257 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266116AbTAYD6O>; Fri, 24 Jan 2003 22:58:14 -0500
Date: Fri, 24 Jan 2003 22:06:58 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Roland Dreier <roland@topspin.com>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: modutils: using kallsyms when cross-compiling kernel
In-Reply-To: <52lm1auk4h.fsf@topspin.com>
Message-ID: <Pine.LNX.4.44.0301242200580.363-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2003, Roland Dreier wrote:

> Is my diagnosis correct?  Is there any easy way for me to fix this (at
> least enough so that I can build a PPC kernel on x86 with kkallsyms
> support), or is the only solution to bite the bullet and fix the
> modutils ELF code to be endianness clean?

You could of course also backport the current 2.5 kallsyms code. This has,
though originally based on kallsyms, been completely rewritten and not
much to do with the original patch anymore (and different objectives).

It generates the information as a .S file and uses the cross-assembler to
generate the object code, so it does not have any of the above issues.

--Kai


