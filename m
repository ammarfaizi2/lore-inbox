Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVLJWVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVLJWVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 17:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbVLJWVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 17:21:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbVLJWVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 17:21:47 -0500
Date: Sat, 10 Dec 2005 14:21:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: adi@hexapodia.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-Id: <20051210142149.f3f8fc02.akpm@osdl.org>
In-Reply-To: <200512060005.04556.rjw@sisk.pl>
References: <20051205081935.GI22168@hexapodia.org>
	<200512060005.04556.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Till now, we have used the simplistic approach
> based on freeing as much memory as possible before suspend.  Now, we
> are freeing only as much memory as necessary, which is on the other
> end of the scale, so to speak.

You might want to play with
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/broken-out/drop-pagecache.patch.
 That's a fast-and-easy way of freeing up quite a lot of memory.
