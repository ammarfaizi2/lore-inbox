Return-Path: <linux-kernel-owner+w=401wt.eu-S932666AbXAHUta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbXAHUta (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbXAHUt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:49:29 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:50969 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932666AbXAHUt2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:49:28 -0500
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<m37ivyr1v6.fsf@telia.com>
	<Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
	<20070107.170056.76564352.davem@davemloft.net>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jan 2007 21:49:23 +0100
In-Reply-To: <20070107.170056.76564352.davem@davemloft.net>
Message-ID: <m3tzz1p7l8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Linus Torvalds <torvalds@osdl.org>
> Date: Sun, 7 Jan 2007 14:50:15 -0800 (PST)
> 
> > David, there really *is* something screwy in netfilter. 
> 
> Sure, but from what I can see this bug appears unrelated to the one in
> kernel bugzilla #7781 that we've been discussing the past few days.
> 
> First of all, the nf conntrack paths won't be used by normal
> users until 2.6.20-rc1 or so.  The bz #7781 report is against
> 2.6.19 and all those backtraces have IP conntrack in them, not
> nf conntrack.
> 
> So what are we compiling with here btw, gcc-4.1?
> 
> I want to rule the compiler out in this and the bz #7781 case
> so that we can look at the code seriously.

The first crash was with gcc 4.1.1, but now I recompiled the kernel
with "gcc version 3.2.3 20030502 (Red Hat Linux 3.2.3-56.fc5)" and I
can still reproduce the same crash. The backtrace looks the same,
although the addresses are obviously different. Some hand copied data
from the oops:

BUG: unable to handle kernel paging request at virtual address 1d075089
eax: cc671e5c ebx: d58569a0 ecx: d58569a0 edx: 00000014
esi: 1d075021 edi: 00000001 ebp: cc671df0 esp: cc671ddc
ds: 007b es: 007b ss: 0068
EIP: ipv4_conntrack_help+0x8e/0x93

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
