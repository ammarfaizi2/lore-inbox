Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUAUACs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAUACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:02:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:28898 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265845AbUAUACp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:02:45 -0500
Date: Tue, 20 Jan 2004 16:03:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: bunk@fs.tum.de, James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] show "Fusion MPT device support" menu only if
 BLK_DEV_SD
Message-Id: <20040120160346.7e466ad2.akpm@osdl.org>
In-Reply-To: <20040120233537.A23375@infradead.org>
References: <20040120232507.GC6441@fs.tum.de>
	<20040120233537.A23375@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jan 21, 2004 at 12:25:07AM +0100, Adrian Bunk wrote:
> > With BLK_DEV_SD=n, I see a "Fusion MPT device support" menu I can't 
> > enter.
> > 
> > The simple patch below removes the "Fusion MPT device support" menu if 
> > BLK_DEV_SD=n.
> 
> I'd rather see an explanation from LSI why a scsi LLDD depens on a uper
> driver.  This can't be right.

There's a hint in the config help:

          [2] In order enable capability to boot the linux kernel
          natively from a Fusion MPT target device, you MUST
          answer Y here! (currently requires CONFIG_BLK_DEV_SD)

But a kernel built with BLK_DEV_SD=n, FUSION=y builds and links OK.

