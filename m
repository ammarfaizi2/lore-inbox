Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132577AbRC1V0o>; Wed, 28 Mar 2001 16:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132573AbRC1V00>; Wed, 28 Mar 2001 16:26:26 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11280 "EHLO neon-gw.transmeta.com") by vger.kernel.org with ESMTP id <S132572AbRC1V0N>; Wed, 28 Mar 2001 16:26:13 -0500
Message-ID: <3AC256A3.BABF7141@transmeta.com>
Date: Wed, 28 Mar 2001 13:24:51 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <E14i0u8-0004N1-00@the-village.bc.nu> <3AC1109A.8459E52@transmeta.com> <3AC25321.C99EDAC7@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> >
> > devfs -- in the abstract -- really isn't that bad of an idea; after all,
> 
> Devfs is from a desing point of view the duplication for the bad /proc
> design for devices. If you need a good design for general device
> handling with names - network interfaces are the thing too look at.
> mount() should be more like a select()... accept()!
> 

And what on earth makes this better?  I have always thought the socket
interface to be hideously ugly and full of ad-hockery.  Its abstractions
for handle multiple address families by and large don't work, and it
introduces new system calls left, right and center -- sometimes for good
reasons, but please do tell me why I can't open() an AF_UNIX socket, but
have to use a special system call called connect() instead.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
