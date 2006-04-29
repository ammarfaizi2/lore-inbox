Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWD2SkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWD2SkU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 14:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWD2SkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 14:40:20 -0400
Received: from aun.it.uu.se ([130.238.12.36]:45267 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750782AbWD2SkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 14:40:19 -0400
Date: Sat, 29 Apr 2006 20:39:34 +0200 (MEST)
Message-Id: <200604291839.k3TIdYar009629@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.17-rc3] i386: fix broken FP exception handling
Cc: ak@suse.de, akpm@osdl.org, stable@kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2006 14:07:49 -0400, Chuck Ebbert wrote:
>The FXSAVE information leak patch introduced a bug in FP exception
>handling: it clears FP exceptions only when there are already
>none outstanding.  Mikael Pettersson reported that causes problems
>with the Erlang runtime and has tested this fix.
>
>Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
>Acked-by: Mikael Pettersson <mikpe@it.uu.se>

To clarify: the problem the bug caused was not that it broke
Erlang, but that running Erlang (which enables and uses FP
exceptions) caused the kernel to oops badly and hang.

/Mikael
