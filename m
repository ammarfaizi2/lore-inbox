Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTDHCBF (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTDHCBF (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:01:05 -0400
Received: from dp.samba.org ([66.70.73.150]:34536 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263865AbTDHCBB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 22:01:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: SET_MODULE_OWNER? 
In-reply-to: Your message of "Mon, 07 Apr 2003 14:29:44 -0400."
             <3E91C398.9070400@pobox.com> 
Date: Tue, 08 Apr 2003 12:01:37 +1000
Message-Id: <20030408021239.1155C2C4EE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3E91C398.9070400@pobox.com> you write:
> Rusty Russell wrote:
> > I thought it was completely useless, hence deprecated.
> > 
> > Anyone have any reason to defend it?
> 
> 
> It's used to allow source compatibility with all kernels, old or new.
> 
> Thus it is in active use, and should not be removed.

Inside individual drivers, or a set of compat macros, it makes sense.
But as a general module.h primitive it doesn't.

Imagine a structure adds an owner field in 2.5.  This macro doesn't
help you, you need a specific compat macro for that struct.

ie. AFAICT it only buys you 2.2 compatibility, and even then only if
you #define it at the top of your driver.

I still don't understand: please demonstrate a use in existing source.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
