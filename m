Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVC1PrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVC1PrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVC1PrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:47:10 -0500
Received: from one.firstfloor.org ([213.235.205.2]:11197 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261904AbVC1PrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:47:06 -0500
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86
 segment register access)
References: <20050326020506.GA8068@lucon.org>
	<20050327222406.GA6435@lucon.org>
From: Andi Kleen <ak@muc.de>
Date: Mon, 28 Mar 2005 17:47:06 +0200
In-Reply-To: <20050327222406.GA6435@lucon.org> (H. J. Lu's message of "Sun,
 27 Mar 2005 14:24:06 -0800")
Message-ID: <m14qev3h8l.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> writes:
> The new assembler will disallow them since those instructions with
> memory operand will only use the first 16bits. If the memory operand
> is 16bit, you won't see any problems. But if the memory destinatin
> is 32bit, the upper 16bits may have random values. The new assembler

Does it really have random values on existing x86 hardware?

If it is a only a "theoretical" problem that does not happen
in practice I would advise to not do the change.

> will force people to use
>
> 	mov (%eax),%ds
> 	movw (%eax),%ds
> 	movw %ds,(%eax)
> 	mov %ds,(%eax)
>
> Will it be a big problem for kernel people?

Well, we re getting used to the tool chain regularly breaking
perfectly good code.

You would not get more than the usual curses and only waste
a couple hundred man hours of testers worlwide scratching their heads
why their kernel does not compile anymore. World economy 
will probably survive ite  ;-)

-Andi
