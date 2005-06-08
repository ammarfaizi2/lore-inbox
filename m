Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVFHXQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFHXQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 19:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFHXQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 19:16:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:12199 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261537AbVFHXPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:15:16 -0400
Subject: Re: [PATCH] ppc64: Fix PER_LINUX32 behaviour
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, anton@samba.org,
       linux-kernel@vger.kernel.org, jk@blackdown.de
In-Reply-To: <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
References: <17062.56723.535978.961340@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0506081022030.2286@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 09:12:28 +1000
Message-Id: <1118272349.6850.140.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 10:24 -0700, Linus Torvalds wrote:
> 
> On Wed, 8 Jun 2005, Paul Mackerras wrote:
> > 
> > * uname(2) doesn't respect PER_LINUX32, it returns 'ppc64' instead of 'ppc'
> 
> I think this is a feature, not a bug, and I suspect you just broke
> compiling a 64-bit kernel by default on ppc64.
> 
> Dammit, the system _is_ ppc64. The fact that the uname binary is not is
> neither here nor there. It's like x86 that reports i386/i486/.. depending 
> on what the machine is. If uname wants to make it clear that uname has 
> been compiled for 32-bit ppc, then it can damn well output "ppc" on its 
> own without asking the kernel what the kernel is.

Unless I'm mistaken, 32 bits will still by default get ppc64, but this
allows us to explicitely use "linux32" binary to set personality to 32
bits, and have subprocesses of _that_ see a 32 bits uname result. That
allows dealing more easily with things like autocruft etc...

Ben.


