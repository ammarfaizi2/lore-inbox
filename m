Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSIZPLM>; Thu, 26 Sep 2002 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSIZPLM>; Thu, 26 Sep 2002 11:11:12 -0400
Received: from [217.167.51.129] ([217.167.51.129]:28144 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261370AbSIZPLK>;
	Thu, 26 Sep 2002 11:11:10 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linus Torvalds" <torvalds@transmeta.com>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH] fix ide-iops for big endian archs
Date: Thu, 26 Sep 2002 17:16:09 +0200
Message-Id: <20020926151609.22295@192.168.4.1>
In-Reply-To: <1033053111.1269.33.camel@irongate.swansea.linux.org.uk>
References: <1033053111.1269.33.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thats true in current -ac. I killed the _p crap. Nobody uses it, the
>switching for handling it is bogus anyway. If anyone has such broken
>code they can implement ide-iops-speak-slowly-after-the-tone.c

Ok, now go one step further and remove the {IN,OUT}{BYTE,WORD,LONG}
macros and you'll end up with the stuff I had send you previously ;)

Regarding the MMIO ops, where indeed I had some #ifdef CONFIG_PPC
crap, that was because we lack proper abstraction of either an
MMIO version of insw/outsw, or of the barrier (see previous
discussion we had on this issue). It is by no mean yet another
PowerPC'ism ;)

Ben.


