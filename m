Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVLIKSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVLIKSO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVLIKSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:18:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28350 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751302AbVLIKSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:18:13 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200512082336.36527.jesper.juhl@gmail.com> 
References: <200512082336.36527.jesper.juhl@gmail.com> 
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Decrease number of pointer derefs in connection.c 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 09 Dec 2005 10:18:06 +0000
Message-ID: <22740.1134123486@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:

> Benefits of the patch:
>  - Fewer pointer dereferences should make the code slightly faster.
>  - Size of generated code is smaller
>  - improved readability

I'm a little surprised that it makes it faster or smaller: I'd've thought that
the gcc optimiser would be up to caching the pointer; in fact, if it made any
difference, I'd've thought it'd make it larger, slower and consume more stack
space as the compiler would then have to carry the extra variable around.

OTOH, compiler's are black magic, possibly even blacker than kernels, so who
knows...

David
