Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUGKBG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUGKBG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUGKBG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:06:57 -0400
Received: from av9-1-sn1.fre.skanova.net ([81.228.11.115]:12521 "EHLO
	av9-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266466AbUGKBGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:06:54 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
References: <m2lli36ec9.fsf@telia.com> <m2llhz5o4o.fsf@telia.com>
	<m2fz875nkv.fsf@telia.com> <200407110120.47256.arnd@arndb.de>
	<20040710232714.GA21633@infradead.org>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Jul 2004 03:06:43 +0200
In-Reply-To: <20040710232714.GA21633@infradead.org>
Message-ID: <m2r7rjpd24.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Sun, Jul 11, 2004 at 01:20:45AM +0200, Arnd Bergmann wrote:
> > These are actually incorrect definitions since the ioctl argument is
> > not a pointer to unsigned int but instead just an int. However, that's
> > too late to fix without breaking the existing tools.
> 
> The tools need to change anyway to get away from the broken behaviour to
> issue in ioctl on the actual block device to bind it..

OK, I'll create a patch that gets rid of the ioctl interface and uses
an auxiliary character device instead to control device bindings.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
