Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJQN1Z>; Thu, 17 Oct 2002 09:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261464AbSJQN1Z>; Thu, 17 Oct 2002 09:27:25 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:1285 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261423AbSJQN1Y>; Thu, 17 Oct 2002 09:27:24 -0400
Date: Thu, 17 Oct 2002 14:33:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader preparation
Message-ID: <20021017143308.A24271@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20021017034634.8D6462C0EB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021017034634.8D6462C0EB@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Oct 17, 2002 at 01:31:54PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:31:54PM +1000, Rusty Russell wrote:
> This patch fixes a couple of places using the old "I can just call my
> function init_module() and it will be called at module init" and a
> couple of modules without module_init() declarations.
> 
> These uses are obsolete with the in-kernel module loader, because the
> module_init() is where we put the module name in the ".modulename"
> section (we could have a "no_init_func()" thing, but it's fairly rare
> and hardly intuitive).

I don't think requiring a init func is a good idea.  Please fix
your module loader to generate a stub if no module_init() is
present instead.

init_module() sounds like a good idea to me, though.

