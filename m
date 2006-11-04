Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965545AbWKDT7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965545AbWKDT7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbWKDT7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:59:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965354AbWKDT7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:59:13 -0500
Date: Sat, 4 Nov 2006 11:52:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zachary Amsden <zach@vmware.com>
cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: remove IOPL check on task switch
In-Reply-To: <454CEC5C.2050507@vmware.com>
Message-ID: <Pine.LNX.4.64.0611041152060.25218@g5.osdl.org>
References: <200611031900_MC3-1-D041-6F32@compuserve.com> <454CE7D9.3070308@vmware.com>
 <454CEC5C.2050507@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Nov 2006, Zachary Amsden wrote:
>
> Ok, checking shows Linus put it back to stop NT leakage.  This is correct, but
> unlikely.  Would be nice to avoid it unless absolutely necessary.  Perhaps xor
> eflags old and new and only set_system_eflags() if non-ALU bits have changed.

Not just NT. AC also leaked, and caused crashes in other programs (Wine) 
that didn't expect AC to be set and did unaligned accesses.

		Linus
