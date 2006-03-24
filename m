Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWCXLnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWCXLnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 06:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWCXLnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 06:43:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422714AbWCXLnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 06:43:05 -0500
Date: Fri, 24 Mar 2006 03:39:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brandon Low <lostlogic@lostlogicx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1
Message-Id: <20060324033934.161302c1.akpm@osdl.org>
In-Reply-To: <20060324032126.GN27559@lostlogicx.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	<20060324021729.GL27559@lostlogicx.com>
	<20060323182411.7f80b4a6.akpm@osdl.org>
	<20060324024540.GM27559@lostlogicx.com>
	<20060323185810.3bf2a4ce.akpm@osdl.org>
	<20060324032126.GN27559@lostlogicx.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <lostlogic@lostlogicx.com> wrote:
>
>  I hadn't noticed immediately in the ooops, but it is something to do
>  with the Hardware Abstraction Layer Daemon from http://freedesktop.org/Software/hal
>  I can't reproduce it without that daemon loaded either.  I wonder if the
>  last accessed sysfs file mentioned in the oops (sda/size) is relevent
>  also.
> 
>  My exact steps (with hald loaded) are:
>  plug in ipod
>  mount /mnt/ipod
>  unzip -d /mnt/ipod rockbox.zip
>  eject /dev/sda
>  unplug ipod
>  immediately here, the oops prints.

Still no joy, alas.

git-cfq.patch plays with the elevator exit code for all IO schedulers. 
Would you be able to do

wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/broken-out/git-cfq.patch
patch -p1 -R < git-cfq.patch

and retest?

Thanks.
