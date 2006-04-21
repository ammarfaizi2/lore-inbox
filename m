Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWDUKmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDUKmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWDUKmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:42:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:38111 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932284AbWDUKmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:42:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sys_vmsplice
Date: Fri, 21 Apr 2006 12:41:35 +0200
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davem@davemloft.net,
       Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
References: <20060421080239.GC4717@suse.de> <20060421092158.GE4717@suse.de> <20060421022555.2d460805.akpm@osdl.org>
In-Reply-To: <20060421022555.2d460805.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200604211241.36596.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 11:25, Andrew Morton wrote:
> It might be better to just stick the new entry into the spufs table, make
> sure that the powerpc guys see it go in.  That way, ppc64 people (Linus,
> maybe you?) can test it.
> 
> I guess mapping it onto sys_ni_syscall would be safest.
> 
> (It's been broken since sys_tee went in, btw).

The BUILD_BUG_ON in there was just overkill. How about if we just add a
small comment to the systbl on powerpc to remind people about the fact
that there is another file to edit? Patch follows.

	Arnd <><
