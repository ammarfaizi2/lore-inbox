Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSK0IZc>; Wed, 27 Nov 2002 03:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSK0IZc>; Wed, 27 Nov 2002 03:25:32 -0500
Received: from zero.aec.at ([193.170.194.10]:22789 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261660AbSK0IZc>;
	Wed, 27 Nov 2002 03:25:32 -0500
Date: Wed, 27 Nov 2002 09:29:18 +0100
From: Andi Kleen <ak@muc.de>
To: davidm@hpl.hp.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021127082918.GA5227@averell>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au> <15844.31669.896101.983575@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15844.31669.896101.983575@napali.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 09:00:53AM +0100, David Mosberger wrote:
> >>>>> On Wed, 27 Nov 2002 18:42:28 +1100, Stephen Rothwell <sfr@canb.auug.org.au> said:
> 
>   Stephen> I make the follwing assumptions: returning s32 from a 32
>   Stephen> bit compatibility system call is the same as returning long
>   Stephen> or int.
> 
> That is not a safe assumption.  The ia64 ABI requires that a 32-bit
> result is returned in the least-significant 32 bits only---the upper
> 32 bits may contain garbage.  It should be safe to declare the syscall
> return type always as "long", no?

But the 32bit user space surely doesn't care about any garbage in 
the upper 32bits, no ?

64bit user space might, but that's not driven by a shared compat layer.

-Andi
