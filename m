Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUBGOAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 09:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUBGOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 09:00:20 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:36282 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S265598AbUBGOAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 09:00:18 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Sat, 7 Feb 2004 12:00:15 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: FATAL: Kernel too old
In-Reply-To: <200402070741.56848.andrew@walrond.org>
Message-ID: <Pine.LNX.4.58.0402071141580.2139@pervalidus.dyndns.org>
References: <Pine.LNX.4.53.0402061550440.681@chaos> <200402070741.56848.andrew@walrond.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Andrew Walrond wrote:

> I have seen this message when trying to use a glibc configured with
>         --enable-kernel=2.4.20
> on a machine running a 2.4.19 kernel.
>
> You haven't either upgraded glibc or started using an older kernel, have you?

I think it also happens if you run a binary compiled on a
machine with such a glibc on another which has an older kernel
or the same glibc, but compiled with no --enable-kernel or an
older version set.

Can't test it, but:

My glibc was compiled with --enable-kernel=2.4.5.

A binary compiled with it:

% file /usr/bin/lsattr
/usr/bin/lsattr: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for GNU/Linux 2.4.5, dynamically linked (uses shared libs), stripped

A binary that came with the default glibc:

% file /usr/bin/ansi2knr
/usr/bin/ansi2knr: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for GNU/Linux 2.0.0, dynamically linked (uses shared libs), stripped

Yes, the default glibc was compiled without --enable-kernel, so
is compatible with >= 2.0.0.

Anyway, not a kernel problem. I have also seen it when trying
to emulate my binaries on FreeBSD, which has compatibility set
to... 2.4.2.

-- 
http://www.pervalidus.net/contact.html
