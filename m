Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131402AbRCUNcb>; Wed, 21 Mar 2001 08:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRCUNcV>; Wed, 21 Mar 2001 08:32:21 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:28871 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S131402AbRCUNcL>; Wed, 21 Mar 2001 08:32:11 -0500
Date: Wed, 21 Mar 2001 14:31:29 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Joern Heissler <joern@heissler.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: strange problem with /dev/isdninfo
In-Reply-To: <20010321135340.A11899@debian.heissler.de>
Message-ID: <Pine.LNX.4.10.10103211427110.19895-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Mar 2001, Joern Heissler wrote:

> I've got a strange problem with /dev/isdninfo:
> 
> joern:~# cat /dev/isdninfo
> idmap:  Hisax...
> chmap: 0 1 ...
>
> --> cat /dev/isdninfo works :-)
> 
> Here's the problem:
> 
> open("/dev/isdninfo", O_RDONLY) = 3
> read(3, "", 200) = 0
>
> Could someone please tell me what's wrong? I (and some other people) do not understand this.

Well, /dev/isdninfo will only return the info to you if it entirely fits
into the supplied buffer. So, you should try a read with 2048 bytes or so,
and it'll work just fine.

Not that I think that the current behavior is particularly smart, but
that's how things are.

--Kai


