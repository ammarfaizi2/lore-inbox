Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWC3BSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWC3BSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWC3BSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:18:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751342AbWC3BSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:18:41 -0500
Date: Wed, 29 Mar 2006 17:20:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060329172057.301a41ff.akpm@osdl.org>
In-Reply-To: <442B2EB2.4040401@garzik.org>
References: <20060329122841.GC8186@suse.de>
	<20060329143758.607c1ccc.akpm@osdl.org>
	<Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
	<442B2EB2.4040401@garzik.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
> Linus Torvalds wrote:
> > The "destination first" convention is insane. It only makes sense for 
> > assignments, and these aren't assignments.
> 
> I agree.
> 
> But alas, sendfile(2) is defined as destination first:
> 
> > ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)
> 
> which begs the question, do we want to be different from sendfile(2), 
> and confuse a segment of the programmer populace?  :)
> 

strcpy, memcpy...

Obviously copy(from, to) is the sane way to do things, but yeah, I _think_
a C programmer would expect copy(to, from).

I don't think it matters much at all, really.  If they get it backwards
they'll notice pretty quickly ;)
