Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967643AbWK2U5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967643AbWK2U5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967673AbWK2U5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:57:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13456 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967643AbWK2U5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:57:16 -0500
Date: Wed, 29 Nov 2006 21:04:08 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Kunal Trivedi" <ktrivedi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug in VM accounting (Committed_AS) on x86_64
 architecture ?
Message-ID: <20061129210408.3ea5800a@localhost.localdomain>
In-Reply-To: <63a95c50611291129q109abeb2o7e5afb7ca94a3f2c@mail.gmail.com>
References: <63a95c50611291122l27c9af6fha78db3bf32fe6c1c@mail.gmail.com>
	<63a95c50611291129q109abeb2o7e5afb7ca94a3f2c@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have noticed that 64 bit machine with overcommit policy (as above)
> starts giving problem within 3-4 weeks. To prove that I've written
> small program.

The older RHEL kernels had some cases that didn't quite account exactly
but current ones ought to be right - for Centos I'd expect similar but
ask there not here as it is a very old and branched away kernel.

>  It allocates memory of different sizes (not that it matters much due
> to caching of diffeent malloc. I am using standard ptmalloc). Sizes
> are 16B, 32B, 64B, 256B, 1024B, 57B, 127B and so on... . Then it
> touches that memory (memset) and then free it. These operations are
> being performed in while(1) loop.

I would expect that, it's fragmentation. The real test is whether the
values go back properly when you kill the program.
