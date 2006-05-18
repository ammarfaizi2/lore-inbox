Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWERHyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWERHyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWERHyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:54:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26016 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750790AbWERHys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:54:48 -0400
Date: Thu, 18 May 2006 09:54:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Gerd Hoffmann <kraxel@suse.de>, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060518075437.GA29747@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147852189.1749.28.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> 	Thanks, I looked at the exec-shield patch.  It has some rough 
> edges (at least the 2.6.16 version I found).

the most recent one is always in the Fedora rawhide kernel RPM/SRPM. 
(that means it closely tracks upstream.)

> 	Gerd's is basically a minimal subset of the exec-shield: we 
> can go further towards exec-shield by using get_unmapped_area for the 
> vsyscall page rather than nailing it above the stack, but it takes us 
> from a 280-line patch to a 480-line patch.

certainly looks good to me! What are the changes you did to the 
exec-shield implementation of vdso randomization? The patch seems 
largely identical to the one in exec-shield.

(and it would be nice to do this on x86_64 too - exploits already exist 
using the fixmapped VDSO there as a trampoline.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
