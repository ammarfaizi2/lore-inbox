Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTI1SeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTI1SeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:34:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:49852 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262673AbTI1SeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:34:09 -0400
Date: Sun, 28 Sep 2003 11:34:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
In-Reply-To: <3F7728A8.5030602@quark.didntduck.org>
Message-ID: <Pine.LNX.4.44.0309281133120.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Brian Gerst wrote:
> 
> Good point.  Wouldn't it just be better to change the few handlers to 
> asmlinkage instead?  Having that stub function there is pointless.

That would work, yes. One problem is that gcc doesn't do proper 
type-checking on it, so it's open to problems. But I'd accept the patch.

		Linus

