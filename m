Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310330AbSCLB7U>; Mon, 11 Mar 2002 20:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310348AbSCLB7K>; Mon, 11 Mar 2002 20:59:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310330AbSCLB7D>; Mon, 11 Mar 2002 20:59:03 -0500
Date: Mon, 11 Mar 2002 17:44:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8D5CCD.3050208@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
> Linus, would it be acceptable to you to include an -optional- filter for
> ATA commands?  There is definitely a segment of users that would like to
> firewall their devices, and I think (as crazy as it may sound) that
> notion is a valid one.

I'd rather have the rule that you can turn off this feature altogther: if
the command is so esoteric that it's not part of the regular commands we
can generate on our own, 99% of all people probably aren't even interested
in it.

If the command is useful on its own, and has a generic meaning (ie across
a large subset of users), then I think the kernel should support it
through a _real_ interface, not through some "pass user data though
inscathed" thing. Because that generic meaning probably exists even
outside ATA drives.

		Linus

