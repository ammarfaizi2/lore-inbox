Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRCDVHD>; Sun, 4 Mar 2001 16:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130518AbRCDVGy>; Sun, 4 Mar 2001 16:06:54 -0500
Received: from smtp-rt-4.wanadoo.fr ([193.252.19.156]:52402 "EHLO
	areca.wanadoo.fr") by vger.kernel.org with ESMTP id <S130507AbRCDVGq>;
	Sun, 4 Mar 2001 16:06:46 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Sun, 4 Mar 2001 22:06:25 +0100
Message-Id: <19350127143809.22288@smtp.wanadoo.fr>
In-Reply-To: <20010303144856.A18389@ftsoj.fsmlabs.com>
In-Reply-To: <20010303144856.A18389@ftsoj.fsmlabs.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>We do have broken interrupt controllers in this respect.  We already have a
>way of handling it.  Ben, take a look at set_lost().

Heh, I know, thanks ;)

However, our current scheme implies a hack to __sti() that I'd like to get
rid of since it adds an overhead allover the place that could probably be
localized if we managed to force an interrupt (using the DEC for example,
or using a mac-specific device as this controller only exist on macs anyway).

Also, we currently don't use the same mecanism as i386, and since Linus
expressed his desire to have irq.c become generic, I'm trying to make sure
I fully understand it before merging in PPC the bits that I didn't merge
them yet.

Ben.
