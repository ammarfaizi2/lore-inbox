Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWC3BE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWC3BE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWC3BEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:04:55 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40832 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751238AbWC3BEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:04:55 -0500
Message-ID: <442B2EB2.4040401@garzik.org>
Date: Wed, 29 Mar 2006 20:04:50 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.5 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The "destination first" convention is insane. It only makes sense for 
> assignments, and these aren't assignments.

I agree.

But alas, sendfile(2) is defined as destination first:

> ssize_t sendfile(int out_fd, int in_fd, off_t *offset, size_t count)

which begs the question, do we want to be different from sendfile(2), 
and confuse a segment of the programmer populace?  :)

	Jeff


