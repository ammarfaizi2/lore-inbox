Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUABXkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUABXkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 18:40:31 -0500
Received: from dp.samba.org ([66.70.73.150]:17852 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265778AbUABXk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 18:40:29 -0500
Date: Sat, 3 Jan 2004 10:35:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
Message-ID: <20040102233542.GW28023@krispykreme>
References: <3FF56B1C.1040308@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF56B1C.1040308@conet.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm writing some project which needs to hijack some syscalls in VFS 
> layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
> some very nasty ways of doing it - see 
> http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )

And it will fail miserably on many non x86 architectures for
various reasons:

1. ppc64 and ia64 use function descriptors
2. sparc64 uses a 32bit call out table

In short its not only an awful hack, its horribly non portable :)

Anton
