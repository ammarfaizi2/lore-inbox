Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269766AbTGKCUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 22:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269767AbTGKCUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 22:20:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269766AbTGKCUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 22:20:44 -0400
Date: Thu, 10 Jul 2003 19:35:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
In-Reply-To: <20030711014154.GA15238@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Andi Kleen wrote:
> 
> This patch deprecates sysctl(2) by adding a printk to it. There is one
> important user of it - glibc checks kernel.version in the startup code -
> which is still handled without message. This needs to be still handled,
> but the hope is that there are no other users of the numerical interface.

I'd prefer to first _only_ deprecate it, and if somebody really really 
decides that they want another interface than /proc too, we can re-visit 
the thing then.

I doubt there is any real reason to not just use the /proc interface, and 
I dislike pre-emptive engineering.

		Linus

