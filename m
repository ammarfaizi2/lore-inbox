Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUGLRrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUGLRrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265249AbUGLRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:47:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:30344 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265247AbUGLRrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:47:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <Pine.LNX.4.58.0407092319180.1764@ppc970.osdl.org> <52r7rj7txj.fsf@topspin.com>
Organization: private Linux site, southern Germany
Date: Sun, 11 Jul 2004 23:19:54 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E1Bjljm-0004jT-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	struct foo {
> 		int a;
> 		int b;
> 	};
>
> then sparse is perfectly happy with someone clearing out a struct foo
> like this:
>
> 	struct foo bar = { 0 };
>
> but then if someone changes struct foo to be
>
> 	struct foo {
> 		void *x;
> 		int a;
> 		int b;
> 	};
>
> sparse will complain about that initialization, and all of the fixes

It complains rather rightly. Think what happens if the original
initializer was
   struct foo bar = { 1 };

This ambiguity may well be the main reason for the C99 initializer
syntax.

Olaf

