Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264921AbTLRDYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 22:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTLRDYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 22:24:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5636 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264921AbTLRDYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 22:24:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: CONFIG_UNIX98_PTY_COUNT and devfs
Date: 17 Dec 2003 19:24:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <brr6lb$ev$1@cesium.transmeta.com>
References: <Pine.LNX.4.58.0312170131500.397@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.58.0312170131500.397@pervalidus.dyndns.org>
By author:    =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
In newsgroup: linux.dev.kernel
>
> I used CONFIG_UNIX98_PTY_COUNT=32 and it created
> /dev/pty/m[0-255]. Is there any way to make devfs only create
> /dev/pty/m[0-31] ?
> 
> From Configure.help:
> 
> "When not in use, each additional set of 256 PTYs occupy
> approximately 8 KB of kernel memory on 32-bit architectures."
> 
> Does that mean it doesn't make any difference if I set
> CONFIG_UNIX98_PTY_COUNT=1 or CONFIG_UNIX98_PTY_COUNT=256, and
> ONFIG_UNIX98_PTY_COUNT=257 will create 512 entries ?
> 

This has absolutely nothing to do with devfs, but Unix98 PTYs
currently come in packs of 256.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
