Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTLVBTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLVBTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:19:23 -0500
Received: from dp.samba.org ([66.70.73.150]:59372 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264272AbTLVBTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:19:21 -0500
Date: Mon, 22 Dec 2003 12:08:30 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>,
       Nathan Poznick <kraken@drunkmonkey.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha
 (2.6.0-test11)
Message-Id: <20031222120830.718a305a.rusty@rustcorp.com.au>
In-Reply-To: <20031218010203.GA13385@twiddle.net>
References: <20031213003841.GA5213@wang-fu.org>
	<20031217121010.GA11062@twiddle.net>
	<20031217193124.GA4837@wang-fu.org>
	<20031218010203.GA13385@twiddle.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003 17:02:03 -0800
Richard Henderson <rth@twiddle.net> wrote:

> On Wed, Dec 17, 2003 at 01:31:24PM -0600, Nathan Poznick wrote:
> > my next question is if this is a known/intended side effect -- enabling
> > CONFIG_DEBUG_INFO means that modules cannot be used?
> 
> No.  This means there's a bug in the generic bits of the module
> loaders, that they're not discarding debugging sections.

Agree with Richard, unless toolchain is setting SHF_ALLOC on those
sections for some weird reason.

Nathan, can you mail me (off-list) a module which needs this?  I'll
take a look.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
