Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751575AbWHaBz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbWHaBz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWHaBz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:55:56 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:43988 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751574AbWHaBzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:55:55 -0400
Date: Thu, 31 Aug 2006 10:58:26 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: end_swap_bio_write error handling
Message-Id: <20060831105826.b45ea424.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1156884514.5600.70.camel@localhost.localdomain>
References: <1156884514.5600.70.camel@localhost.localdomain>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 21:48:34 +0100
Richard Purdie <rpurdie@rpsys.net> wrote: 
> end_swap_bio_write() simply does:
> 
> if (!uptodate)
> 	SetPageError(page);
> 
> I know the uptodate flag is being cleared in the error cases. I'm having
> trouble working out which code the setting of an error flag for a swap
> page should trigger (any pointers appreciated!). I noticed its also used
> for the read case which is unrecoverable.
> 
> Should this code be marking the page as dirty and the section of the
> swap device as bad instead, does it already do that or is that not
> possible for some reason?
> 
> Any comments and/or pointers to documentation on this would be
> appreciated.
> 
Now, swap-write-failure-fixup.patch is merged in -mm kernel.
==
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/mm-swap-write-failure-fixup.patch
==
error message comes and a page turns to be dirty again.

Thanks,
- Kame

