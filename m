Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUBMUeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBMUeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 15:34:22 -0500
Received: from [213.78.163.227] ([213.78.163.227]:39298 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S267165AbUBMUeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 15:34:19 -0500
From: Chris Lingard <chris@ukpost.com>
To: "Jim Gifford" <maillist@jg555.com>
Subject: Re: Initrd Question
Date: Fri, 13 Feb 2004 20:34:16 +0000
User-Agent: KMail/1.5.2
References: <015501c3f1df$42cd7cf0$d300a8c0@W2RZ8L4S02>
In-Reply-To: <015501c3f1df$42cd7cf0$d300a8c0@W2RZ8L4S02>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402132034.16778.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 3:12 am, Jim Gifford wrote:
> I wrote the initrd hint for the Linux from Scratch. I have followed the
> initrd.txt exactly to the letter. The problem I have noticed is with one of
> the commands, and I checked other mkinitrd scripts and they have the
> workaround in it.

With regards to the initrd.txt hint. (2.4.x kernels)

It does not work with the     "  root=/dev/rd/0   (with devfs) "
unless         { "rd/0",     0x0100 },   is added to the root_dev_names[] 
__initdata array; (init/do_mounts.c)

You need to use "root=/dev/ram0" with or without devfs. (or change 
init/do_mounts.c).  Patches to either code or documentation if you want.

Chris
