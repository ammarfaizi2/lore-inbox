Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUHKMcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUHKMcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUHKMcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:32:36 -0400
Received: from zero.aec.at ([193.170.194.10]:8197 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S268042AbUHKMcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:32:35 -0400
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, us15@os.inf.tu-dresden.de
Subject: Re: Possible dcache BUG
References: <2oKTA-5CQ-65@gated-at.bofh.it> <2r0U7-3yx-9@gated-at.bofh.it>
	<2rwhh-BX-15@gated-at.bofh.it> <2rShM-7QP-5@gated-at.bofh.it>
	<2rSrs-7Vn-1@gated-at.bofh.it> <2rSUw-8lw-3@gated-at.bofh.it>
	<2rTGR-se-3@gated-at.bofh.it> <2rUjF-Od-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 11 Aug 2004 14:32:23 +0200
In-Reply-To: <2rUjF-Od-11@gated-at.bofh.it> (David S. Miller's message of
 "Wed, 11 Aug 2004 08:00:11 +0200")
Message-ID: <m3y8kl4zzc.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> On Tue, 10 Aug 2004 22:13:01 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
>
>> I also wonder what the 
>> hell is allocating so many 8kB and 32kB entries.
>
> Loopback default MTU is 16K these days, might explain
> the 32K entries but not the 8KB ones.  Perhaps the
> later are being used for page tables?  Just a guess
> on that latter one.

Kernel stacks more likely. 200 processes = 200 8K entries.
Unless he used suic^w4K stack mode. 

-Andi

