Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbULGAc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbULGAc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULGAc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:32:59 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:62894 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261717AbULGAcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:32:55 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Jon Masters <jonathan@jonmasters.org>
Subject: Re: [PATCH] UML - SYSEMU fixes
Date: Tue, 7 Dec 2004 01:36:42 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org> <200412062017.29011.blaisorblade_spam@yahoo.it> <41B4F1CB.8010908@jonmasters.org>
In-Reply-To: <41B4F1CB.8010908@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412070136.43262.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 December 2004 00:56, Jon Masters wrote:
> Blaisorblade wrote:
> | On Sunday 05 December 2004 14:30, Jon Masters wrote:
> |>Jeff Dike wrote:
> |>| jonmasters@gmail.com said:
> |>|>That's great, but do any of these patches address various undefines in
> |>|>arch/um/kernel/process.c:check_sysemu when built without skas?
> |>|
> |>| Apparently they did.  I just checked with skas turned off and got a
> |>| successful build.
> |
> | They don't - check_sysemu is used also in TT mode.

> I wasn't building for me, but I've not applied these patches yet.

> |>Good. I've got a working build on an Intel box but it's being more
> |>stubburn building for ppc in 2.6.9 - I'll post an update when I've
> |>actually looked at it.
> |
> | PPC port is not maintained at the moment - there are some rumors of

> somebody

> | reviving it, but nothing is certain.

> I want it for unrelated reasons, but I don't want to say I'll do it
> because I probably won't find some time to do it :-)

> (I will look though - it would be nice to have UML building on ppc since
> that's what I have with me most of the time)

If you search on uml-devel and/or uml-user:

http://marc.theaimsgroup.com/?l=user-mode-linux-user&r=1&w=2

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&r=1&w=2
 
you'll find 
> |>|>Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
> |>|>CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
> |>|>and "-fomit-frame-pointer" but surely it should be building with frame
> |>|>pointers anyway if I've asked it to do so?
> |
> | I saw that from someone else - I don't remember what was the problem,

> but it

> | seemed to be some strange kind of .config. Make sure that

> CONFIG_DEBUG_INFO

> | and CONFIG_FRAME_POINTER are both set (the second is the needed one, the
> | first implies the second for UML).
> |
> | "make oldconfig ARCH=um" should fix such problems.

> Nope. My config wasn't that strange either - but I'm perfectly able to
> figure out why it's breaking though. I just wanted to mention it.
Yes, that's always appreciated... however, the dependencies between options 
seem correct, i.e. you can enable the -pg flag (for Gprof, IIRC) only if you 
have enabled debugging info, which also disables -fomit-frame-pointer.
> Jon.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
