Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSHKJtf>; Sun, 11 Aug 2002 05:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSHKJtf>; Sun, 11 Aug 2002 05:49:35 -0400
Received: from ns.suse.de ([213.95.15.193]:62477 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317355AbSHKJtf>;
	Sun, 11 Aug 2002 05:49:35 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56147E.15E7A98@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Aug 2002 11:53:21 +0200
In-Reply-To: Andrew Morton's message of "11 Aug 2002 10:02:40 +0200"
Message-ID: <p73u1m1iuwe.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> Which needs a working ARCH_HAS_PREFETCH to avoid probable extra code
> generation on CPUs which don't have prefetch.

When you use gcc 3.1+ you can use __builtin_prefetch() and gcc takes care of
it. See asm-x86_64/prefetch.h of a working example.

Of course generic C code should not use the ugly builtins directly, but
it could be used to define the wrappers.

-Andi
