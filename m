Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbSK0IzM>; Wed, 27 Nov 2002 03:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSK0IzM>; Wed, 27 Nov 2002 03:55:12 -0500
Received: from zero.aec.at ([193.170.194.10]:28677 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261732AbSK0IzM>;
	Wed, 27 Nov 2002 03:55:12 -0500
Date: Wed, 27 Nov 2002 10:01:13 +0100
From: Andi Kleen <ak@muc.de>
To: davidm@hpl.hp.com
Cc: Andi Kleen <ak@muc.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>,
       anton@samba.org, "David S. Miller" <davem@redhat.com>,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021127090113.GA5491@averell>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au> <15844.31669.896101.983575@napali.hpl.hp.com> <20021127082918.GA5227@averell> <15844.34389.396428.645047@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15844.34389.396428.645047@napali.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 09:46:13AM +0100, David Mosberger wrote:
> >>>>> On Wed, 27 Nov 2002 09:29:18 +0100, Andi Kleen <ak@muc.de> said:
> 
>   Andi> But the 32bit user space surely doesn't care about any garbage
>   Andi> in the upper 32bits, no ?
> 
> The user-space won't, but the kernel exit path might.  Remember that

True. The signal return path checking for the 5xx errnos expects
them to be 64bit extended. I now even vaguely remember an obscure bug I once 
saw on x86-64 with an 32bit application actually seeing ERESTARTSYS that might
just have been caused by such an issue.

Thanks for pointing that out.
-Andi
