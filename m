Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSG2Mm6>; Mon, 29 Jul 2002 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSG2Mm6>; Mon, 29 Jul 2002 08:42:58 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:3596 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317059AbSG2Mmy>; Mon, 29 Jul 2002 08:42:54 -0400
Date: Mon, 29 Jul 2002 14:46:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
In-Reply-To: <28935.1027944502@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0207291429580.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 29 Jul 2002, David Howells wrote:

> Brrr... I don't like that. If I'm going to pass in a second argument, then I
> want it to be what Christoph's version because it's more readable and more
> obvious what it's doing (and, since the value is constant, the optimiser can
> obviously get rid of it easily).

If the intention was to help the gcc optimizing the code, that was not
readable from the old version. It also wasn't that clear that wakewrite
and sem->activity basically have the same information (only if one reads
the code carefully one sees that "wakewrite" actually means "only if
there's no activity, wake a writer").

bye, Roman

