Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbTCYSgP>; Tue, 25 Mar 2003 13:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbTCYSgP>; Tue, 25 Mar 2003 13:36:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:34484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263206AbTCYSgN>;
	Tue, 25 Mar 2003 13:36:13 -0500
Date: Tue, 25 Mar 2003 10:43:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: arjanv@redhat.com, alan@lxorguk.ukuu.org.uk, randy.dunlap@verizon.net,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, leo@netlabs.net
Subject: Re: [PATCH] reduce stack in cdrom/optcd.c
Message-Id: <20030325104311.122bc3b6.rddunlap@osdl.org>
In-Reply-To: <20030325182916.GI30908@suse.de>
References: <3E7C0808.75B95FB7@verizon.net>
	<1048365798.9221.35.camel@irongate.swansea.linux.org.uk>
	<1048364399.1708.4.camel@laptop.fenrus.com>
	<20030325182916.GI30908@suse.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Mar 2003 19:29:16 +0100 Jens Axboe <axboe@suse.de> wrote:

| On Sat, Mar 22 2003, Arjan van de Ven wrote:
| > On Sat, 2003-03-22 at 21:43, Alan Cox wrote:
| > > On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
| > > > Hi,
| > > > 
| > > > This reduces stack usage in drivers/cdrom/optcd.c by
| > > > dynamically allocating a large (> 2 KB) buffer.
| > > > 
| > > > Patch is to 2.5.65.  Please apply.
| > > 
| > > This loosk broken. You are using GFP_KERNEL memory allocations on the
| > > read path of a block device. What happens if the allocation fails 
| > > because we need memory
| > 
| > it's unlikely that you have your swap on the cdrom ;)
| 
| your swap device could still be plugged behind your cdrom.

I plan to change it as Alan suggested.  Will do.

--
~Randy
