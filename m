Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVFBBzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFBBzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVFBBzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:55:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23480 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261562AbVFBByv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:54:51 -0400
Message-ID: <429E66DF.5000000@pobox.com>
Date: Wed, 01 Jun 2005 21:54:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <429E5483.3020404@pobox.com> <429E62C1.2040605@tmr.com>
In-Reply-To: <429E62C1.2040605@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> How about anything more? The truth is that much common hardware doesn't 
> really make the cache to disk move visible, and turning off cache really 
> hurts performance. And it would appear that fsync force a lot more data 
> out of memory than just the blocks for the file in question.

Correct.  That's the tradeoff with the ATA interface:  you must be aware 
of the cache flush requirements when designing a solution such as a 
database that really cares about fsync(2), or a journalling filesystem.


> However, the point I was making is that it would be useful to be able to 
> tell when the write to non-volatile took place, not to force that to 
> happen. Not to do anything which would flush a lot of other stuff and 
> busy the drive. What I suggest is NOT fsync, just a way to assure ordering.

To make that possible, POSIX must become a transactional, async I/O 
API... :)

	Jeff


