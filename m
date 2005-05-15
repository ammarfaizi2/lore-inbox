Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVEOUse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVEOUse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVEOUse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:48:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:31663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261237AbVEOUsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:48:31 -0400
Date: Sun, 15 May 2005 13:44:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: jgarzik@pobox.com, gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       okuyamak@dd.iij4u.or.jp
Subject: Re: Disk write cache
Message-Id: <20050515134405.6c099391.akpm@osdl.org>
In-Reply-To: <m1zmuw8m3a.fsf@muc.de>
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz>
	<200505151121.36243.gene.heskett@verizon.net>
	<20050515152956.GA25143@havoc.gtf.org>
	<20050516.012740.93615022.okuyamak@dd.iij4u.or.jp>
	<42877C1B.2030008@pobox.com>
	<m1zmuw8m3a.fsf@muc.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> However since
>  I suppose a lot of disks flush everything pending on a flush cache
>  command it still works assuming the file systems write the 
>  data to disk in fsync before syncing the journal. I don't know
>  if they do that.


ext3 does, in data=journal and data=ordered modes.
