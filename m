Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbUK3EXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUK3EXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbUK3EXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:23:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:21897 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261975AbUK3EXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:23:05 -0500
Date: Mon, 29 Nov 2004 20:22:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: jt@hpl.hp.com
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Mariusz Mazur <mmazur@kernel.pl>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041130014328.GA14337@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0411292019500.22796@ppc970.osdl.org>
References: <20041130014328.GA14337@bougret.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Nov 2004, Jean Tourrilhes wrote:
>
> 	So, which kernel ABI should be present on my system in
> /usr/include/linux and /usr/include/asm ? Should I use the ABI from
> 2.6.X, 2.4.X or 2.2.X ?

I have always felt (pretty strongly) that the /usr/include/xxx contents 
should not be kernel-dependent, but be linked to your glibc version. 
That's why the symlink from /usr/include/xxx to /usr/src/linux/include/
has been deprecated for the last, oh about ten years now..

Yes, there are some _very_ specific things which might care about system 
calls or ioctl's that have been added later, but let's face it, we don't 
actually do that very often. The kernel may change at a rapid pace, but 
user interfaces don't, and user interfaces that would bypass the C library 
change even less frequently.

		Linus
