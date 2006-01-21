Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWAUQ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWAUQ1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWAUQ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 11:27:41 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:40072 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1750838AbWAUQ1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 11:27:40 -0500
Message-ID: <43D260F8.B82BCB9A@users.sourceforge.net>
Date: Sat, 21 Jan 2006 18:27:36 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Announce loop-AES-v3.1c file/swap crypto package
References: <43CE6384.284B823C@users.sourceforge.net> <20060120195035.GA9685@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Either something is missing in the support for external modules in the
> kernel or you are overdoing some stuff. If there is something missing in
> the kernel to support external modules then please say so, so it can be
> fixed.

Missing functionality:
1) "make M=/path/to/dir modules_install" does not run depmod. Pulling
   correct depmod info from kernel Makefile needs ugly hacks.
2) Try building external module A that exports some function, and then build
   another external module B (separate package, only knows function
   prototype) that uses said exported function. And I mean build it cleanly
   without puking error messages on me. 2.4 and older kernel got that right,
   but 2.6 is still FUBAR. Serious regression here.

Both above cases can be (and need to be) worked around using ugly hacks.

Sam,
Please understand that loop-AES needs to work with 2.0, 2.2, 2.4 and 2.6
kernels. Not just latest mainline, but all of them, including ones that you
cannot retroactively change.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
