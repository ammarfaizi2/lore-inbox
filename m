Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUFBVfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUFBVfY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUFBVfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:35:24 -0400
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:2981 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S264197AbUFBVfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:35:04 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
References: <20040602205025.GA21555@elte.hu>
	<Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
	<20040602211714.GB29687@devserv.devel.redhat.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 02 Jun 2004 17:31:37 -0400
In-Reply-To: <20040602211714.GB29687@devserv.devel.redhat.com> (Arjan van de
 Ven's message of "Wed, 2 Jun 2004 23:17:14 +0200")
Message-ID: <87u0xtbq9y.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
>> 
>> 
>> Just out of interest - how many legacy apps are broken by this? I assume 
>> it's a non-zero number, but wouldn't mind to be happily surprised.
>
> based on execshield in FC1.. about zero.

IIRC, Lisp systems like CMUCL and SBCL (plus commercial Lisps) had
problems with FC1 due to execshield.  They tend to do things like
compile code on the fly to heap memory and expect to be able to run
it.

>> And do we have some way of on a per-process basis say "avoid NX because
>> this old version of Oracle/flash/whatever-binary-thing doesn't run with
>> it"?
>
> yes those aren't compiled with the PT_GNU_STACK elf flag and run with the
> stack executable just fine. GCC will also emit a "make the stack executable"
> flag when it emits code that puts stack trampolines up.
> That all JustWorks(tm).

Given this I wonder why they had trouble...

Disclaimer: I don't hack on free Lisps; I just follow some of the
mailing lists, so I may have important details wrong.  :)

-Doug
