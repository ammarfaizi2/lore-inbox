Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbTC0XWd>; Thu, 27 Mar 2003 18:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbTC0XWd>; Thu, 27 Mar 2003 18:22:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:56222 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261483AbTC0XWc>; Thu, 27 Mar 2003 18:22:32 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 27 Mar 2003 15:44:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dave Jones <davej@codemonkey.org.uk>
cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete messages ...
In-Reply-To: <20030327232607.GC16251@suse.de>
Message-ID: <Pine.LNX.4.50.0303271539230.2009-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
 <1048774874.19677.0.camel@rth.ninka.net> <20030327232607.GC16251@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Dave Jones wrote:

> On Thu, Mar 27, 2003 at 06:21:14AM -0800, David S. Miller wrote:
>
>  > > Any CONFIG_DROP_FREAKIN_OBSOLETE_MSGS (SO_BSDCOMPAT,bdflush,...) anywhere
>  > > soon in 2.5.67 ? :)
>  >
>  > If you fix the apps, the messages go away.  In fact, you want to know
>  > that you have unfixed apps on your box when you run these kernels so
>  > I'd say the messages should stay even well into early 2.6.x
>
> If folks want to mail me reports of any app (and version, even distro
> info) that reports these sorts of messages, I'll add them to the doc at
> http://www.codemonkey.org.uk/post-halloween-2.5.txt

Well, usually /etc/inittab calls /sbin/update ( bdflush ). About
SO_BSDCOMPAT I can report Bind 9.2.2 but I think their code is right. They
do check for "#ifdef SO_BSDCOMPAT", that is still defined in asm/socket.h.
By removing SO_BSDCOMPAT from asm/socket.h and rebuilding, it should be
fine.



- Davide

