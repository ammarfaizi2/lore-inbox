Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263400AbSJGVTh>; Mon, 7 Oct 2002 17:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbSJGVTg>; Mon, 7 Oct 2002 17:19:36 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:35220 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S263400AbSJGVTf>; Mon, 7 Oct 2002 17:19:35 -0400
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth subsystem
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>
In-Reply-To: <Pine.LNX.4.33.0210071347470.10749-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0210071347470.10749-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Oct 2002 23:24:19 +0200
Message-Id: <1034025872.861.81.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 22:49, Linus Torvalds wrote:
> 
> On Mon, 7 Oct 2002, Marcel Holtmann wrote:
> > 
> > ChangeSet@1.709, 2002-10-07 22:08:56+02:00, marcel@holtmann.org
> >   Make it possible to compile in the Bluetooth subsystem
> 
> Looks good, but you should _not_ remove the "static". Please keep the init
> functions static, they will be explicitly exported to the stuff that cares
> (and nobody else) by the "module_init()" thing anyway.

but when I try to compile in the Bluetooth subsystem I got the following
error:

net/built-in.o: In function `sock_init':
net/built-in.o(.text.init+0x5b): undefined reference to `bluez_init'
make: *** [.tmp_vmlinux1] Error 1

It seems like that I have missed some magic to understand, because
"wanrouter_init" is also not declared static. But for netfilter or
netlink init it seems to work this way. Can you please give me some
infos how to fix this the right way.

Regards

Marcel


