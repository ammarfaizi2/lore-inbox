Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTIYHnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 03:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIYHnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 03:43:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:13247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261758AbTIYHnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 03:43:07 -0400
Date: Thu, 25 Sep 2003 00:43:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-Id: <20030925004301.171f6645.akpm@osdl.org>
In-Reply-To: <20030925071252.GE22525@vitelus.com>
References: <20030925071252.GE22525@vitelus.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> wrote:
>
> I'm running bkcvs HEAD on a newly installed system, and started
> copying files over to my RAID 5 from older IDE disks. When I copy
> these files, the system becomes unusable. Specifically, any disk
> access on the 3ware array, no matter how simple, even starting 'vi' on
> a file, takes minutes or eternity to complete. Suspending the process
> doing the copying doesn't even help much, because the LEDs on the card
> continue blinking for about 30 seconds after the suspension. This
> happens whether the IDE drive is using DMA or not. It seems that some
> kind of insane queueing is going on. Are there parameters worth
> playing with? Should I try the deadline I/O scheduler?

An update to the 3ware driver was merged yesterday.  Have you used earlier
2.5 kernels?

