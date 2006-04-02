Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWDBWdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWDBWdm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDBWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:33:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20966 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932434AbWDBWdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:33:42 -0400
Date: Mon, 3 Apr 2006 00:33:30 +0200
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] splice support #2
Message-ID: <20060402223330.GA1611@elf.ucw.cz>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org> <442C440B.2090700@garzik.org> <Pine.LNX.4.64.0603301259220.27203@g5.osdl.org> <20060331070931.GA25853@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331070931.GA25853@elte.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We should extend the userspace API so that it is prepared to receive 
> 'excess data' via a separate 'flush excess data to' file descriptor:
> 
> 	sys_splice(fd_in, fd_out, fd_flush, size,
>                    max_flush_size, *bytes_flushed)

I still see problems with error handling here. You get -EIO to
userspace. How do you know if it is error reading fd_in, or error
writing fd_out?
								Pavel
-- 
Picture of sleeping (Linux) penguin wanted...
