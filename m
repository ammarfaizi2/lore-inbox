Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268786AbUJUQ4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268786AbUJUQ4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbUJUQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:51:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268786AbUJUQts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:49:48 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: K8 Errata #93: adjusting address to a fixup block
References: <2Qpmj-1uX-13@gated-at.bofh.it>
	<m3is99xfem.fsf@averell.firstfloor.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 21 Oct 2004 13:49:37 -0300
In-Reply-To: <m3is99xfem.fsf@averell.firstfloor.org>
Message-ID: <ord5zc584e.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17, 2004, Andi Kleen <ak@muc.de> wrote:

>> address, so I came up with this patch.  It turned out to make no
>> difference, but it still feels like an improvement to me, since some
>> day we might be resuming from halt into a fix-up block.  Thoughts?

> The code is already ugly enough and handles most of the cases, 
> I don't think it is worth it complicating it even more just
> to handle more corner cases of buggy BIOS.

Fair enough.

> The real fix is to fix your BIOS.

>  	static int warned;
> +	if ((error_code & 16) == 0)
> +		return 0;

> This is dubious because the I/D bit is undefined when NX is disabled
> in EFER (e.g. with noexec=off or when the CPU doesn't support NX)

Aah...  I wasn't aware of that.  Patch withdrawn for sure, then :-)
Thanks for the feedback.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
