Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUERAB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUERAB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 20:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUERAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 20:01:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:59372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262580AbUERAB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 20:01:57 -0400
Date: Mon, 17 May 2004 17:04:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ramdisk driver in 2.6.6 has a severe bug
Message-Id: <20040517170433.0311c2e9.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0405180132240.21480-100000@hubble.stokkie.net>
References: <20040517161943.37d826a3.akpm@osdl.org>
	<Pine.LNX.4.44.0405180132240.21480-100000@hubble.stokkie.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert M. Stockmann" <stock@stokkie.net> wrote:
>
> Be aware of other problems when using the linux ramdisk driver,
> loosing its contents. Especially the use of mkinitrd might result in 
> unexpected problems. googling for "kernel 2.6.6 ramdisk problem" shows lots
> of people with problems mounting their root filesystems and loading modules
> from ramdisk. Klaus Knopper (knoppix) is not amused, neither am i :)

Well in that case perhaps something else broke.  I've seen no such reports
of recent regressions in the ramdisk driver.

The two problems of which I am aware are:

a) It loses its brains across umount.  Seems that it's very rare that
   anyone actually cares about this, which is why it has not been fixed in
   well over a year.

b) It loses data under heavy I/O loads.  I _think_ this has been
   observed only on ppc64 and might be a cache writeback/invalidate thing.

If there are new post-2.6.5 problems then I'm all ears.
