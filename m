Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUGNDMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUGNDMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 23:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267310AbUGNDMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 23:12:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267306AbUGNDMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 23:12:35 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Olaf Titz <olaf@bigred.inka.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org>
	<m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
	<E1BjmAw-0005MS-00@bigred.inka.de>
	<Pine.GSO.4.58.0407131042310.6985@waterleaf.sonytel.be>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 14 Jul 2004 00:12:22 -0300
In-Reply-To: <Pine.GSO.4.58.0407131042310.6985@waterleaf.sonytel.be>
Message-ID: <oroemjp9ih.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 13, 2004, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Sun, 11 Jul 2004, Olaf Titz wrote:
>> in C. (Worse in C++ where usage of NULL is discouraged, I've always
>> wondered about the reasons.)

> [ wondered about this as well, but the answer has been posted before in this
>   thread ]

> Because C++ doesn't do implicit conversions from void * to anything *.

So what?  NULL must have an integral type in C++.  void* is explicitly
forbidding in the C++ Standard.

I don't see that NULL is discouraged in C++.  It's mostly redundant,
like it is in C, and it's not safe for varargs even on machines where
NULL pointers are represented can be zero-initialized, because
pointers to members and regular pointers don't even have the same
size, unlike C, that doesn't have pointers to members and thus can
safely use (intptr_t)0 for NULL and it will even work for varargs
(given the considerations above).

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
