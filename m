Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSIZP7D>; Thu, 26 Sep 2002 11:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261340AbSIZP7D>; Thu, 26 Sep 2002 11:59:03 -0400
Received: from [217.167.51.129] ([217.167.51.129]:28401 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261339AbSIZP7C>;
	Thu, 26 Sep 2002 11:59:02 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 18:04:11 +0200
Message-Id: <20020926160411.27876@192.168.4.1>
In-Reply-To: <1033053111.1269.33.camel@irongate.swansea.linux.org.uk>
References: <1033053111.1269.33.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> properly on BE, further cleanup of the iops is pending, I'm waiting
>> for Alan own experiments before I push again my own that remove
>> all "p" iops and all of the {IN,OUT}{BYTE,WORD,LONG} macros.
>
>Thats true in current -ac. I killed the _p crap. Nobody uses it, the
>switching for handling it is bogus anyway. If anyone has such broken
>code they can implement ide-iops-speak-slowly-after-the-tone.c

Ok, I finally went and looked at your tree for real and I see
the cleanup is actually there, good :)

So now, let's see how to get rid of those CONFIG_PPC, either by
having everybody define iobarrier_*() or having {read,write}s{b,w,l},
I just started a new thread on the list just about that.

Jens: can you look into merging -ac's iops change to 2.5 ? That
would fix it.

Ben.

