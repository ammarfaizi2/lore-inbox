Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVGZUmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVGZUmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 16:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGZUkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 16:40:22 -0400
Received: from aun.it.uu.se ([130.238.12.36]:10121 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261929AbVGZUjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 16:39:09 -0400
Date: Tue, 26 Jul 2005 22:38:55 +0200 (MEST)
Message-Id: <200507262038.j6QKct92018384@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: johsc@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 panics on boot on 486 box: TSC requires pentium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 20:22:58 +0200, johsc@arcor.de wrote:
>2.4.31 compiled with -m486, panics on boot (486DX) and says something about
>TSC requires pentium, bang.
>enabling the obscure flag
>
> [*] Unsynced TSC support
>
>seems to fix this - the corresponding .config label name is actually *more*
>helpful than the documentation.

Let me guess: you started from the default config and just flipped
the CPU option to 486? That doesn't work in 2.4 kernels, since it
leaves the derived "I have TSC" option enabled.

A second configuration round (make oldconfig for example) fixes this.
grep TSC .config to ensure it's not set before compiling.
