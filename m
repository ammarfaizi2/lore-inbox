Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290496AbSBSVxw>; Tue, 19 Feb 2002 16:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290547AbSBSVxm>; Tue, 19 Feb 2002 16:53:42 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:122 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290496AbSBSVx3>; Tue, 19 Feb 2002 16:53:29 -0500
Date: Tue, 19 Feb 2002 16:53:26 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202192153.g1JLrQH05684@devserv.devel.redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ENOTTY from ext3 code?
In-Reply-To: <mailman.1014150283.20067.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1014150283.20067.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  ext3/ioctl.c:
>  ...
>  	return -ENOTTY;
>  
>  Does it really make sense to return "not a typewriter" from ext3
>  ioctl?

Absolutely. In fact, it's a pet pieve of mine. Lots and lots
of clueless driver writes return -EINVAL in such cases,
and I keep cleaning it up. The problem with EINVAL is that
it makes it harder to diagnose any problems that can come up.

Also, recent strerror() returns "Inappropriate ioctl for a device",
if that is your concern. Personally, I think "Not a typewriter"
was a warmer and fuzzier reference to the roots, but oh well...
Dennis giveth, TOG taketh away...

-- Pete
