Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUBXVIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbUBXVIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:08:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:26752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262433AbUBXVHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:07:16 -0500
Date: Tue, 24 Feb 2004 13:07:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [FIX] CONFIG_REGPARM breaks non-asmlinkage syscalls
Message-Id: <20040224130721.182c533b.akpm@osdl.org>
In-Reply-To: <1077653156.3101.327.camel@nb.suse.de>
References: <1077653156.3101.327.camel@nb.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
> with CONFIG_REGPARM=y, syscalls must be declared asmlinkage or else
>  calling them will fail. Current gcc unfortunately does not warn about
>  this. (I have already told one of our compiler developers.) Attached is
>  a fix that adds a few missing declarations.

hm, thanks.  These should all be fixed by the "put all syscall decls in
syscalls.h" patch.  I'll hurry that along a bit.

