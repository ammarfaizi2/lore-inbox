Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTIHTUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTIHTUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:20:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:55481 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263457AbTIHTUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:20:23 -0400
Date: Mon, 8 Sep 2003 12:02:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: hugh@veritas.com, drepper@redhat.com, lk@tantalophile.demon.co.uk,
       shemminger@osdl.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: today's futex changes
Message-Id: <20030908120234.5d05cda9.akpm@osdl.org>
In-Reply-To: <20030908102309.0AC4E2C013@lists.samba.org>
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
	<20030908102309.0AC4E2C013@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> D: 4) Andrew Morton says spurious wakeup is a bug.  Catch it.

Yes, but going BUG() is a bit rude.  We can detect the error, we can
recover from it and it doesn't cause any user data corruption or anything.
A rude printk is all that is needed here.

