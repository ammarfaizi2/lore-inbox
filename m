Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbULHHjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbULHHjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbULHHhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:37:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:6017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbULHHap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:30:45 -0500
Date: Tue, 7 Dec 2004 23:30:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: nickpiggin@yahoo.com.au, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041207233027.20f29a16.akpm@osdl.org>
In-Reply-To: <20041208072052.GC19522@suse.de>
References: <20041202195232.GA26695@suse.de>
	<20041208003736.GD16322@dualathlon.random>
	<1102467253.8095.10.camel@npiggin-nld.site>
	<20041208013732.GF16322@dualathlon.random>
	<20041207180033.6699425b.akpm@osdl.org>
	<20041208022020.GH16322@dualathlon.random>
	<20041207182557.23eed970.akpm@osdl.org>
	<1102473213.8095.34.camel@npiggin-nld.site>
	<20041208065858.GH3035@suse.de>
	<1102490086.8095.63.camel@npiggin-nld.site>
	<20041208072052.GC19522@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
>  I think we need to end up with something that sets the machine profile
>  for the interesting disks. Some things you can check for at runtime
>  (like the writes being extremely fast is a good indicator of write
>  caching), but it is just not possible to cover it all. Plus, you end up
>  with 30-40% of the code being convoluted stuff added to detect it.

We can detect these things from userspace.  Parse the hdparm/scsiinfo
output, then poke numbers into /sys tunables.

