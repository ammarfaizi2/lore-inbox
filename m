Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTJ2Ujy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 15:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTJ2Ujy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 15:39:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:35470 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261580AbTJ2Ujx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 15:39:53 -0500
Date: Wed, 29 Oct 2003 12:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Alexander V. Lukyanov" <lav@netis.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9: access beyond end of device
Message-Id: <20031029124003.4510bb1d.akpm@osdl.org>
In-Reply-To: <20031029101240.GA12958@night.netis.priv>
References: <20031029101240.GA12958@night.netis.priv>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander V. Lukyanov" <lav@netis.ru> wrote:
>
> I have tried to run 2.6.0-test9 and got this error very quickly.
> 
> Details:
> 	heavily loaded squid server with two ext3 filesystems for cache on
> 	two IC35L040AVVN07-0 40GiB hard disks (ibm), TCQ enabled.

Please force an fsck against those partitions, then see if it is repeatable
with TCQ disabled.

> Oct 29 10:52:28 mars kernel: attempt to access beyond end of device
> Oct 29 10:52:28 mars kernel: hda4: rw=0, want=4241606720, limit=77256585
> Oct 29 10:52:28 mars kernel: attempt to access beyond end of device
> Oct 29 10:52:28 mars kernel: hda4: rw=0, want=4241606720, limit=77256585
> Oct 29 10:52:33 mars kernel: EXT3-fs error (device hda4): ext3_free_blocks: Freeing blocks not in datazone - block = 1067071751, count = 1
> Oct 29 10:52:33 mars kernel: Aborting journal on device hda4.
> 
