Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267973AbUH2OzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267973AbUH2OzO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUH2OzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:55:14 -0400
Received: from the-village.bc.nu ([81.2.110.252]:64384 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267973AbUH2OzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:55:11 -0400
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, Peter Osterlund <petero2@telia.com>,
       axboe@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1093384621.817.76.camel@krustophenia.net>
References: <m33c2py1m1.fsf@telia.com> <20040823114329.GI2301@suse.de>
	 <m3llg5dein.fsf@telia.com> <20040824202951.GA24280@suse.de>
	 <m3hdqsckoo.fsf@telia.com>  <20040824144707.100e0cfd.akpm@osdl.org>
	 <1093384621.817.76.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093787569.27935.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 14:52:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-24 at 22:57, Lee Revell wrote:
> This defaults to 8192 on my (IDE) system.  IIRC this value is larger if
> 48-bit addressing is in use (drive size > ~128GB).  It does not seem
> right to me that the size of your hard drive should dictate the amount
> of I/O allowed to be in flight.

The largest I/O allowed in LBA28 mode is 256 sectors, and in LBA48
rather larger. Its a limit of the command functionality. The tradeoff
the other way is that LBA28 commands are slightly faster to issue.

