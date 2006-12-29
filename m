Return-Path: <linux-kernel-owner+w=401wt.eu-S1751627AbWL2LUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWL2LUi (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 06:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbWL2LUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 06:20:38 -0500
Received: from colin.muc.de ([193.149.48.1]:2841 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751627AbWL2LUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 06:20:37 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 06:20:37 EST
Date: 29 Dec 2006 12:13:55 +0100
Date: Fri, 29 Dec 2006 12:13:55 +0100
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
Message-ID: <20061229111355.GA82929@muc.de>
References: <1167348861.30506.46.camel@localhost.localdomain> <20061228155659.462eaa9c.akpm@osdl.org> <1167350803.30506.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167350803.30506.49.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The code looks like it's designed to be included from userspace for
> testing; as it compiles without this include (and has no other
> includes), I chose not to add it.
> 
> Linus makes a good point, but someone who actually knows the code
> should, y'know, test it and stuff...

It should use kernel_fpu_begin() imho. If someone wants to test
it in user space again they can add dummy definitions of that
to their user space  header.

-Andi
