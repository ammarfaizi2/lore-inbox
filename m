Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266188AbUGJIXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbUGJIXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUGJIXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:23:10 -0400
Received: from mail.enyo.de ([212.9.189.167]:23568 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S266188AbUGJIXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:23:08 -0400
To: Michael Buesch <mbuesch@freenet.de>
Cc: Martin Zwickel <martin.zwickel@technotrend.de>, root@chaos.analogic.com,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<200407081328.40545.mbuesch@freenet.de>
	<20040708134459.6970a20b@phoebee>
	<200407081406.23831.mbuesch@freenet.de>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Sat, 10 Jul 2004 10:22:57 +0200
In-Reply-To: <200407081406.23831.mbuesch@freenet.de> (Michael Buesch's
 message of "Thu, 8 Jul 2004 14:06:22 +0200")
Message-ID: <87hdsgp8ym.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch:

> Yes, I never understood the reason for this ugly
> #if defined(__cplusplus) here.
> It works, but is IMHO unneccessary.

It's necessary because in C++, (void *)0 is not implicitly converted
to other pointer types.  Having to write static_cast<T*>(NULL) is
certainly a bit too verbose.

There's also a C++ DR about this topic because people feel that there
should be a 0/NULL distinction for overloading.  But this is
completely irrelevant to C code.

