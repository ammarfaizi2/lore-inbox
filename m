Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFSBda>; Mon, 18 Jun 2001 21:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263432AbRFSBdU>; Mon, 18 Jun 2001 21:33:20 -0400
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:29934 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263093AbRFSBdK>; Mon, 18 Jun 2001 21:33:10 -0400
Message-ID: <3B2EACD9.D1D2B90A@earthlink.net>
Date: Mon, 18 Jun 2001 20:37:29 -0500
From: Kelledin Tane <runesong@earthlink.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: baggins@sith.mimuw.edu.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: Why can't I flush /dev/ram0?
In-Reply-To: <3B2E6EA3.3DED7D95@earthlink.net> <20010618235537.B17458@sith.mimuw.edu.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > When I mount the filesystem to check it out, nothing appears to have
> > anything open on the filesystem.  So why am I not able to flush it
> > clean?
>
> Because of a bug present in Linus tree. Try this patch:

Thanks, that seems to have fixed it.  There's something else I'm curious about
though...

Before, when I was having this problem, I would check mem usage, and there would
be about 5MB of physical memory marked for "buffers" (I assume 4MB for ram0).

Now, using an identical kernel configuration, an identical module set loaded,
and a roughly identical process table, there's about 18MB of memory marked for
"buffers!"

Sorry to be a bother, but I can't help wondering if this patch might have gotten
rid of one problem and replaced it with another?  Or maybe I'm missing some
other detail here...

Kelledin

bash-2.05 $ kill -9 1
init: Just what do you think you're doing, Dave?

