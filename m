Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbUKNJJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbUKNJJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 04:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUKNJJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 04:09:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:38320 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261265AbUKNJJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 04:09:55 -0500
Date: Sun, 14 Nov 2004 01:09:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu,
       seto.hidetoshi@jp.fujitsu.com, ahu@ds9a.nl
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5 [u])
Message-Id: <20041114010943.3d56985a.akpm@osdl.org>
In-Reply-To: <20041114090023.GA478@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org>
	<20041114090023.GA478@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emergency Services Jamie Lokier <jamie@shareable.org> wrote:
>
> Revert the patch which moves queue_me(); it's buggy.  It is a bug to
>  move queue_me() after get_user().

yup.

>  It fully explains the blocking threads in Apache and Evolution.
> 
>  Even if it worked, the patch wouldn't have saved any time, as it's a
>  rare condition if the caller is using futex properly.

The patch wasn't supposed to optimise anything.  It fixed a bug which was
causing hangs.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/futex_wait-fix.patch

Or are you saying that userspace is buggy??
