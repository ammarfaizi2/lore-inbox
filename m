Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFYPs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFYPs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:48:28 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:63495 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264606AbTFYPs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:48:27 -0400
Date: Wed, 25 Jun 2003 12:01:09 -0400 (EDT)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Lou Langholtz <ldl@aros.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd driver for 2.5+: cleanup PARANOIA usage & code
In-Reply-To: <3EF91F73.5080109@aros.net>
Message-ID: <Pine.LNX.4.10.10306251154160.11076-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, Lou Langholtz wrote:

> This fifth patch cleans up usage of the PARANOIA sanity checking macro 
> and code. This patch modifies both drivers/block/nbd.c and 
> include/linux/nbd.h. It's intended to be applied incrementally on top of 
> my fourth patch (4.1 really if you count the memset addition as .1's 
> worth) that simply removed unneeded blksize_bits field. Again, I wanted 
> to get this smaller change out of the way before my next patch will is 
> much more major. Comments welcome.

Lou, any chance you could fix the requests_in, requests_out accounting? 
What I mean is that _in and _out do not match up if, .e.g, there's an 
error. This has been broken for a while, but since you're in there 
touching the code, it might be easy for you to go ahead and fix it. 

BTW, the other patches you've posted look good. I'm glad that you chose
to avoid the multithreading idea, which would have broken compatibility 
with older nbd's (and added a lot of complexity to the driver).

Thanks,
Paul

