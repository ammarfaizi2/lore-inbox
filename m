Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266824AbUBRASJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBRAPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:15:55 -0500
Received: from dp.samba.org ([66.70.73.150]:1988 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266824AbUBRAOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:14:41 -0500
Date: Tue, 17 Feb 2004 18:41:32 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: coywolf@lovecn.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
Message-Id: <20040217184132.541a5a76.rusty@rustcorp.com.au>
In-Reply-To: <402F42DE.5090308@t-online.de>
References: <402A887D.7030408@t-online.de>
	<402EDBA8.4070102@lovecn.org>
	<402F42DE.5090308@t-online.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004 10:58:54 +0100
Harald Dunkel <harald.dunkel@t-online.de> wrote:

> Coywolf Qi Hunt wrote:
> > Harald Dunkel wrote:
> > 
> >>
> >> What would be the correct way to get the filename of a
> >> loaded module? The basename would be sufficient.
> >>
> >>
> > The symbole names used in source code, like function names tend to use 
> > "_", while the file names use "-" IMHO.
> > 
> 
> Naturally the symbols in the code use '_', cause for C '-'
> is not allowed within symbol names.
> 
> I am interested in the module file names. 'cat /proc/modules'
> should return the correct module names, but for some modules
> (like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.

We canonicalize them at every point: you can use both.

Most users don't want to remember that it's ip_conntrack but uhci-hcd.

Hope that clarifies,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
