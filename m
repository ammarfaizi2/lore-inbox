Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTEIXMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 19:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTEIXMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 19:12:22 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:28309
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263573AbTEIXMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 19:12:22 -0400
Message-ID: <3EBC38C1.6020305@redhat.com>
Date: Fri, 09 May 2003 16:24:49 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2A3C.8040409@redhat.com> <3EBC3167.2030302@techsource.com>
In-Reply-To: <3EBC3167.2030302@techsource.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Miller wrote:

> Why does there ever need to be an explicit HINT that you would prefer a
> <32 bit address, when it's known a priori that <32 is better?  Why
> doesn't the mapping code ALWAYS try to use 32-bit addresses before
> resorting to 64-bit?

Because not all memory is addressed via GDT entries.  In fact, almost
none is, only thread stacks and similar gimicks.  If all mmap memory
would by default be served from the low memory pool you soon run out of
it and without any good reason.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vDjB2ijCOnn/RHQRAnHmAJ9V3BwxGTAUs7hw1YXowv0K0cEFFACePj6t
vLI+B5BlYG4ox5WcyFrwg8A=
=IGO2
-----END PGP SIGNATURE-----

