Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266897AbUGLRby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266897AbUGLRby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUGLRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:31:53 -0400
Received: from hera.kernel.org ([63.209.29.2]:47056 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266898AbUGLRbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:31:44 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
Date: Mon, 12 Jul 2004 17:31:21 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccuht9$u85$1@terminus.zytor.com>
References: <1089165901.4373.175.camel@orca.madrabbit.org> <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089653481 30982 127.0.0.1 (12 Jul 2004 17:31:21 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jul 2004 17:31:21 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <orn02cqs3u.fsf@livre.redhat.lsd.ic.unicamp.br>
By author:    Alexandre Oliva <aoliva@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Jul  6, 2004, Ray Lee <ray-lk@madrabbit.org> wrote:
> 
> > Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.
> 
> Assuming ints are 32-bits wide.  They don't have to be.  They could be
> as narrow as 16 bits, in which case the constant will have type long
> or unsigned long (because long must be at least 32 bits), or they
> could be wider than 32 bits, in which case the constant will be signed
> int instead of unsigned int.  You might lose either way.  It's
> probably safer to make it explicitly UL, except perhaps in
> machine-specific files where the width of types is well-known.
> 

If it runs Linux:

	CHAR_BIT == 8
	sizeof(int) == 4
	sizeof(void(*)()) == sizeof(void *)
	sizeof(long) == sizeof(void *)
	sizeof(long long) == 8
	(long)NULL == 0L

These assumptions are pretty ingrained in the Linux kernel.
	
	-hpa
