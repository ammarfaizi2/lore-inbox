Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSLKGd5>; Wed, 11 Dec 2002 01:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbSLKGd5>; Wed, 11 Dec 2002 01:33:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:44747 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267030AbSLKGd4>;
	Wed, 11 Dec 2002 01:33:56 -0500
Message-ID: <3DF6DE1A.6FD498C9@digeo.com>
Date: Tue, 10 Dec 2002 22:41:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: William Lee Irwin III <wli@holomorphy.com>, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] epoll: don't printk pointer value
References: <20021211063031.GH9882@holomorphy.com> <1039588429.832.6.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 06:41:35.0721 (UTC) FILETIME=[59A9BD90:01C2A0E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> --- linux-2.5.51/fs/eventpoll.c 2002-12-09 21:45:54.000000000 -0500
> +++ linux/fs/eventpoll.c        2002-12-11 01:23:07.000000000 -0500
> @@ -1573,7 +1573,7 @@
>         if (IS_ERR(eventpoll_mnt))
>                 goto eexit_4;
> 
> -       printk(KERN_INFO "[%p] eventpoll: successfully initialized.\n", current);
> +       printk(KERN_INFO "eventpoll: successfully initialized.\n");
> 

Guys, it's noise.  Just nuke it.
