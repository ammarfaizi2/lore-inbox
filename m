Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUHMQLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUHMQLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUHMQLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:11:47 -0400
Received: from zero.aec.at ([193.170.194.10]:31749 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266193AbUHMQL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:11:29 -0400
To: =?iso-8859-1?Q?Pawe=E2_Sikora?= <pluto@pld-linux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ix86,x86_64] cpu features.
References: <2sMat-61I-43@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 13 Aug 2004 18:11:21 +0200
In-Reply-To: <2sMat-61I-43@gated-at.bofh.it> =?iso-8859-1?Q?=28Pawe=E2?= Sikora's message of "Fri, 13 Aug 2004 17:30:17 +0200")
Message-ID: <m3smarrpau.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paweâ Sikora <pluto@pld-linux.org> writes:

> +++ linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c	2004-08-13 16:48:53.971370504 +0200
> @@ -44,8 +44,8 @@
>  		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
>  
>  		/* Intel-defined (#2) */
> -		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
> -		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
> +		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
> +		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,


You cannot just do the pni -> sse3 rename. That could break existing
applications that read /proc/cpuinfo and parse it. The only way would
be to add a new sse3 flag in addition to pni, but I guess that would
be not worth the ugly special case.

-Andi

