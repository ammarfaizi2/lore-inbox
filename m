Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265364AbUAZATt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265375AbUAZATt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:19:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:31644 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265366AbUAZATr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:19:47 -0500
Date: Sun, 25 Jan 2004 16:19:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jonathan Kamens <jik@kamens.brookline.ma.us>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: MD Oops on boot with 2.6.2-rc1-mm3
Message-Id: <20040125161955.060d42bc.akpm@osdl.org>
In-Reply-To: <16403.57499.905471.768545@jik.kamens.brookline.ma.us>
References: <16403.57499.905471.768545@jik.kamens.brookline.ma.us>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Kamens <jik@kamens.brookline.ma.us> wrote:
>
> I get an Oops on boot with 2.6.2-rc1-mm3, trying to boot from a RAID1
> MD root partition with two disks in the array; the Oops apparently
> causes the raid array not to be assembled, so the boot stops.

There appears to be a dud raid patch in -mm.  It'll be one of the md-*
patches.

If you have time, could you work out which one?  Ones to start with might be

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/broken-out/md-02-preferred_minor-fix.patch

and

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/broken-out/md-06-allow-partitioning.patch


