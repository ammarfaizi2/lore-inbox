Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266639AbUGKUGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbUGKUGX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266640AbUGKUGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:06:23 -0400
Received: from hera.kernel.org ([63.209.29.2]:29833 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266639AbUGKUGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:06:21 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Date: Sun, 11 Jul 2004 20:05:54 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ccs6j2$b8a$1@terminus.zytor.com>
References: <20040707122525.X1924@build.pdx.osdl.net> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org> <Pine.LNX.4.58.0407091313570.20635@scrub.home> <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1089576354 11531 127.0.0.1 (11 Jul 2004 20:05:54 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sun, 11 Jul 2004 20:05:54 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.58.0407102126150.10242@waterleaf.sonytel.be>
By author:    Geert Uytterhoeven <geert@linux-m68k.org>
In newsgroup: linux.dev.kernel
> 
>   - `return f();' in a function returning void (where f() returns void as well)
> 

Considering this one a bug is daft in the extreme.

Why?  Because "return f();" is the only kind of tailcall syntax C has,
and requiring that "void" functions use a different syntax is just
stupid.

Now, if the return types don't match then that's another issue.

	-hpa
