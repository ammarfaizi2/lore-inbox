Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTGBUVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 16:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTGBUVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 16:21:15 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:39389 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S264472AbTGBUVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 16:21:07 -0400
Date: Wed, 2 Jul 2003 16:36:02 -0400
From: Wil Reichert <wilreichert@yahoo.com>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
Message-Id: <20030702163602.2d07ad23.wilreichert@yahoo.com>
In-Reply-To: <3F032991.3030201@gmx.at>
References: <4FHn.4MD.1@gated-at.bofh.it>
	<3F032991.3030201@gmx.at>
Organization: NA
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > The on-board Highpoint controller (HPT372A) on my DFI NF2 is having
>  > issue.  Loading the hptraid module results in a 'No such device'
>  > message while the hpt366 module segfaults and leaves an oops in my
>  > logs.  These errors occur regardless of the disk/raid configuration
>  > in the hpt BIOS.   Following are the oops trace, an lsmod, the
>  > .config and a lspci -vvv.
> 
> The crash occurs in the hpt366 module. Loading hptraid will not work 
> because it depends on the kernel to claim the disks of the raid volume 
> (that is what hpt366 would do). I will add autoloading of the 
> ide-controller module in the next raid-driver release. However, I do not 
> know why the kernel oopses. You might want to try to build the hpt366 
> code into the kernel instead of a module. If it works it would probably 
> mean that "ide_hwif_t *hwif" was not properly initalized.
I initially had all the hpt modules built into the kernel, but that would also produce an oops and die immediately after ID'ing the two drives I have on attached.  Would any more information be of use to you?

Wil
