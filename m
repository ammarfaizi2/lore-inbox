Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbUJ0VcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUJ0VcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUJ0V3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:29:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:4251 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262754AbUJ0VYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:24:23 -0400
Date: Wed, 27 Oct 2004 14:24:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <41800218.8090902@vmware.com>
Message-ID: <Pine.LNX.4.58.0410271422280.28839@ppc970.osdl.org>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41800218.8090902@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Oct 2004, Zachary Amsden wrote:
> 
> Passes several tests (code looks sane, assembler looks sane, boots & 
> runs fine) on i386.  Apologies if I unlikely broke any other 
> architectures, but it's quite difficult to test them all.

I'd suggest _only_ changing the i386 version.

For example, your asm-generic changes looks senseless, since they only
make the macros more complex, without actually changing anything. And the
other architectures may want to do other things, since right now at least
some of them use things like fixed hardware registers etc which is not
necessarily appropriate for the non-asm case...

That way you'd also only modify the architecture that you can actually 
verify..

		Linus
