Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbUBAXKL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 18:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUBAXKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 18:10:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:45211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265504AbUBAXKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 18:10:06 -0500
Date: Sun, 1 Feb 2004 15:11:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philip Martin <philip@codematters.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs
Message-Id: <20040201151111.4a6b64c3.akpm@osdl.org>
In-Reply-To: <87oesieb75.fsf@codematters.co.uk>
References: <87oesieb75.fsf@codematters.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Martin <philip@codematters.co.uk> wrote:
>
> The machine is a dual P3 450MHz, 512MB, aic7xxx, 2 disk RAID-0 and
>  ReiserFS.  It's a few years old and has always run Linux, most
>  recently 2.4.24.  I decided to try 2.6.1 and the performance is
>  disappointing.

2.6 has a few performance problems under heavy pageout at present.  Nick
Piggin has some patches which largely fix it up.

>  My test is a software build of about 200 source files (written in C)
>  that I usually build using "nice make -j4".

Tried -j3?

> Timing the build on
>  2.4.24 I typically get something like
> 
>  242.27user 81.06system 2:44.18elapsed 196%CPU (0avgtext+0avgdata 0maxresident)k
>  0inputs+0outputs (1742270major+1942279minor)pagefaults 0swaps
> 
>  and on 2.6.1 I get
> 
>  244.08user 116.33system 3:27.40elapsed 173%CPU (0avgtext+0avgdata 0maxresident)k
>  0inputs+0outputs (0major+3763670minor)pagefaults 0swaps

hm, the major fault accounting is wrong.

