Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSG2H6V>; Mon, 29 Jul 2002 03:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSG2H6V>; Mon, 29 Jul 2002 03:58:21 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:11027 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312962AbSG2H6N>; Mon, 29 Jul 2002 03:58:13 -0400
Date: Mon, 29 Jul 2002 10:01:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
In-Reply-To: <9911.1027928536@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0207290958010.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Jul 2002, David Howells wrote:

> > You don't really need that extra argument, testing sem->activity should do
> > the same job.
> > If you exchange the wakewrite (or sem->activity) test and the
> > waiter->flags you can fold it into the next test (this means all the extra
> > work would only be done, if we have a writer waiting at the top).
>
> The reason for doing it this way is that it allows the compiler to discard
> parts of the function when inlining it since the value is set at compile time
> rather than being worked out at runtime. The value itself should be
> disappeared entirely by the compiler.

Did you look at the code? gcc should be able to optimize that itself.

bye, Roman

