Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbUKZX5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUKZX5l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbUKZX5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:57:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263074AbUKZTlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:35 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <19865.1101395592@redhat.com>
References: <19865.1101395592@redhat.com>
Content-Type: text/plain
Message-Id: <1101396219.8191.9289.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 25 Nov 2004 15:23:40 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 15:13 +0000, David Howells wrote:
> We've been discussing splitting the kernel headers into userspace API headers
> and kernel internal headers and deprecating the __KERNEL__ macro. This will
> permit a cleaner interface between the kernel and userspace; and one that's
> easier to keep up to date.
> 
> What we've come up with is this:

I've already done something vaguely along those lines, extracting
user-visible bits from include/linux/mtd/*.h, putting them into files in
include/mtd/*.h and including them from there (except for jffs2.h which
currently does it backwards).

-- 
dwmw2

