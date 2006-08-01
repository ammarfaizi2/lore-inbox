Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWHAIbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHAIbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWHAIbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:31:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53947 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWHAIbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:31:12 -0400
Date: Tue, 1 Aug 2006 01:31:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Denis Vlasenko" <vda.linux@googlemail.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
Message-Id: <20060801013104.f7557fb1.akpm@osdl.org>
In-Reply-To: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 10:26:55 +0100
"Denis Vlasenko" <vda.linux@googlemail.com> wrote:

> The reiser4 thread seem to be longer than usual.

Meanwhile here's poor old me trying to find another four hours to finish
reviewing the thing.

The writeout code is ugly, although that's largely due to a mismatch between
what reiser4 wants to do and what the VFS/MM expects it to do.  If it
works, we can live with it, although perhaps the VFS could be made smarter.

I'd say that resier4's major problem is the lack of xattrs, acls and
direct-io.  That's likely to significantly limit its vendor uptake.  (As
might the copyright assignment thing, but is that a kernel.org concern?)

The plugins appear to be wildly misnamed - they're just an internal
abstraction layer which permits later feature additions to be added in a
clean and safe manner.  Certainly not worth all this fuss.

Could I suggest that further technical critiques of reiser4 include a
file-and-line reference?  That should ease the load on vger.

Thanks.
