Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSBOOW6>; Fri, 15 Feb 2002 09:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289803AbSBOOWi>; Fri, 15 Feb 2002 09:22:38 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:17679 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289802AbSBOOWa>; Fri, 15 Feb 2002 09:22:30 -0500
Date: Fri, 15 Feb 2002 15:22:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, <davidm@hpl.hp.com>,
        "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move task_struct allocation to arch
In-Reply-To: <3C6D126B.E5B4810A@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0202151516260.1145-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 15 Feb 2002, Jeff Garzik wrote:

> > As I mentioned before I more like the byte approach, since atomic bit
> > field handling is quite expensive on most architectures, where a simple
> > set/clear byte is only one or two instructions, if there is byte
> > load/store instruction. So I'd really like to see to leave the decision to
> > the architecture, whether to use bit or byte fields.
>
> We have tons of code already using atomic test_and_set_bit type
> stuff...  why not just make sure your bit set/clear stuff is fast?  :)

Because in this case there is no atomic test_and_(clear|set)_bit needed.
We only need to clear the bit/byte before scheduling/signal delivery is
started.

bye, Roman

