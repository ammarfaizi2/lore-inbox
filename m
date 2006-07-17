Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWGQHY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWGQHY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWGQHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 03:24:59 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11501 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932369AbWGQHY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 03:24:59 -0400
Date: Mon, 17 Jul 2006 09:24:57 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Vikas Kedia <kedia.vikas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic at load average of 24 is it acceptable ?
Message-ID: <20060717072457.GA12215@rhlx01.fht-esslingen.de>
References: <fbe022af0607170008w5efb489fjd3df63f1795805c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe022af0607170008w5efb489fjd3df63f1795805c2@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 17, 2006 at 12:08:41AM -0700, Vikas Kedia wrote:
> The memtest ran fine for 8 hours:
> http://www.visitlab.com/styles/basic/images/memtest.JPG
> 
> My questions are:
> 1. Kernel panic at load average of 24 is it acceptable ?

Kernel panic is _NEVER_ acceptable.
I've seen loads in the couple hundreds with no problem.

However you actually have a mce_panic() crash here.
Make sure to figure out why this Machine Check Exception got raised,
otherwise you might hose the box if you continue without investigation.
It could easily be due to mal-working CPU fan etc.pp., especially since it
happened exactly while you stress-tested the machine.

> 2. If not how do I go about debugging this kernel panic ?

Read up on MCE debugging methods on Linux or so, that should hopefully help.

Good luck!

Andreas Mohr
