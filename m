Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbULFX5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbULFX5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULFX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:57:34 -0500
Received: from smtp.mailbox.net.uk ([195.82.125.32]:4773 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S261702AbULFX51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:57:27 -0500
Message-ID: <41B4F1CB.8010908@jonmasters.org>
Date: Mon, 06 Dec 2004 23:56:59 +0000
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade_spam@yahoo.it>
CC: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [PATCH] UML - SYSEMU fixes
References: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org> <200412050819.iB58Jlhj006511@ccure.user-mode-linux.org> <41B30D6B.3060506@jonmasters.org> <200412062017.29011.blaisorblade_spam@yahoo.it>
In-Reply-To: <200412062017.29011.blaisorblade_spam@yahoo.it>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Blaisorblade wrote:

| On Sunday 05 December 2004 14:30, Jon Masters wrote:

|>Jeff Dike wrote:
|>| jonmasters@gmail.com said:
|>|>That's great, but do any of these patches address various undefines in
|>|>arch/um/kernel/process.c:check_sysemu when built without skas?

|>| Apparently they did.  I just checked with skas turned off and got a
|>| successful build.

| They don't - check_sysemu is used also in TT mode.

I wasn't building for me, but I've not applied these patches yet.

|>Good. I've got a working build on an Intel box but it's being more
|>stubburn building for ppc in 2.6.9 - I'll post an update when I've
|>actually looked at it.

| PPC port is not maintained at the moment - there are some rumors of
somebody
| reviving it, but nothing is certain.

I want it for unrelated reasons, but I don't want to say I'll do it
because I probably won't find some time to do it :-)

(I will look though - it would be nice to have UML building on ppc since
that's what I have with me most of the time)

|>|>Also, on 2.6.9, I get dud CFLAGS defined when CONFIG_PROF is set *and*
|>|>CONFIG_FRAME_POINTER is also set - gcc complains about use of "-gp"
|>|>and "-fomit-frame-pointer" but surely it should be building with frame
|>|>pointers anyway if I've asked it to do so?

| I saw that from someone else - I don't remember what was the problem,
but it
| seemed to be some strange kind of .config. Make sure that
CONFIG_DEBUG_INFO
| and CONFIG_FRAME_POINTER are both set (the second is the needed one, the
| first implies the second for UML).
|
| "make oldconfig ARCH=um" should fix such problems.

Nope. My config wasn't that strange either - but I'm perfectly able to
figure out why it's breaking though. I just wanted to mention it.

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBtPHKeTyyexZHHxERAuNaAJ9VlY9c//XhS/OtkcoVU1jl0KGIhQCgifyp
tgaWdko23Sztn76TyCGEbPg=
=SHSz
-----END PGP SIGNATURE-----
