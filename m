Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbULFTNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbULFTNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbULFTNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:13:49 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:58788 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261614AbULFTNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:13:43 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [PATCH] UML - SYSEMU fixes
Date: Mon, 6 Dec 2004 20:17:28 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org> <200412050819.iB58Jlhj006511@ccure.user-mode-linux.org> <41B30D6B.3060506@jonmasters.org>
In-Reply-To: <41B30D6B.3060506@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412062017.29011.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 December 2004 14:30, Jon Masters wrote:
> Jeff Dike wrote:
> | jonmasters@gmail.com said:
> |>That's great, but do any of these patches address various undefines in
> |>arch/um/kernel/process.c:check_sysemu when built without skas?

> | Apparently they did.  I just checked with skas turned off and got a

> successful

> | build.

They don't - check_sysemu is used also in TT mode.

> Good. I've got a working build on an Intel box but it's being more
> stubburn building for ppc in 2.6.9 - I'll post an update when I've
> actually looked at it.

PPC port is not maintained at the moment - there are some rumors of somebody 
reviving it, but nothing is certain.

> |>Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
> |>CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
> |>and "-fomit-frame-pointer" but surely it should be building with frame
> |>pointers anyway if I've asked it to do so?

I saw that from someone else - I don't remember what was the problem, but it 
seemed to be some strange kind of .config. Make sure that CONFIG_DEBUG_INFO 
and CONFIG_FRAME_POINTER are both set (the second is the needed one, the 
first implies the second for UML).

"make oldconfig ARCH=um" should fix such problems.

> | I just checked with that config, and it builds fine.

> Oh good. Then it works now.

> Cheers,

> Jon.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
