Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTBBI2q>; Sun, 2 Feb 2003 03:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265140AbTBBI2q>; Sun, 2 Feb 2003 03:28:46 -0500
Received: from asclepius.uwa.edu.au ([130.95.128.56]:34719 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id <S265139AbTBBI2p>; Sun, 2 Feb 2003 03:28:45 -0500
Date: Sun, 2 Feb 2003 16:37:52 +0800 (WST)
From: Paul Marinceu <elixxir@ucc.gu.uwa.edu.au>
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au
Subject: Re: [RFC][PATCH] new modversions implementation
Message-ID: <Pine.LNX.4.21.0302021616230.11976-100000@mussel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

When trying to compile 2.5.59 after patching with modversions.patch,
modversions2.patch and modversions-less-magic.patch I discovered a tiny
glitch which prevents compilation.

The culprit is a missing opening brace in modversions2.patch on line 72
(underlined below)

+#ifdef CONFIG_MODVERSIONING
+       if ((mod->symbols.num_syms && !crcindex)
+           || (mod->gpl_symbols.num_syms && !gplcrcindex)) {
							   ^^^
Also, whatever happened to modversions.h? A module I have refuses to
compile without it. I'm not yet such a good hacker to figure out how your
new modversions implementation works 8) 

Oh, and can you please cc: me since I'm not subscribed.

Cheers


--
 Paul Marinceu
 http://elixxir.ucc.asn.au


