Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264817AbUEQA7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264817AbUEQA7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264842AbUEQA7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:59:10 -0400
Received: from hera.kernel.org ([63.209.29.2]:50080 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S264817AbUEQA7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:59:06 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Date: Mon, 17 May 2004 00:58:28 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c892nk$5pf$1@terminus.zytor.com>
References: <200404292146.i3TLkfI0019612@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1084755508 5936 127.0.0.1 (17 May 2004 00:58:28 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 17 May 2004 00:58:28 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200404292146.i3TLkfI0019612@harpo.it.uu.se>
By author:    Mikael Pettersson <mikpe@csd.uu.se>
In newsgroup: linux.dev.kernel
> 
> 'ptr' _is_ a char pointer, and the code (visible in the part of
> the patch you didn't include) already performed pointer arithmetic
> on it relying on it being a char pointer. The old code had no
> sane reason at all for updating 'ptr' via a cast-as-lvalue.
> 
> cast-as-lvalue is not proper C, has dodgey semantics, and can
> always be replaced by proper C.
> 

I don't see how it has dodgey semantics for cast of pointers or
[u]intptr_t to pointers.

IMNSHO the fact that it breaks C++ isn't a good reason to outlaw a
long-documented extension for C.

	-hpa
