Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbTAASsE>; Wed, 1 Jan 2003 13:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTAASsE>; Wed, 1 Jan 2003 13:48:04 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:30953 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265058AbTAASsD>; Wed, 1 Jan 2003 13:48:03 -0500
To: Albert Kajakas <Albert.Kajakas@mail.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3rdparty modules for 2.5.53
References: <200301011719.h01HJOB21702@mail-fe2.tele2.ee>
From: Andi Kleen <ak@muc.de>
Date: 01 Jan 2003 19:56:11 +0100
In-Reply-To: <200301011719.h01HJOB21702@mail-fe2.tele2.ee>
Message-ID: <m3isx8em2c.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Kajakas <Albert.Kajakas@mail.ee> writes:

> Hello!
> I have a problem with compiling modules for 2.5.

I recently tracked down the same problem.

Add a -DKBUILD_MODNAME="yourname" compile option to one of the files,
the new loader requires a module name section. It should be only set
once for each module.

In addition make sure you're using the new style module_init/module_exit
macros instead of init_module/cleanup_module.

-Andi

P.S.: I agree that the error reporting sucks for this one. It would
be better if the kernel loader give some kind of text message back.
