Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUHUOnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUHUOnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUHUOnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 10:43:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:18862 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266457AbUHUOnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 10:43:12 -0400
Date: Sat, 21 Aug 2004 16:43:03 +0200 (MEST)
Message-Id: <200408211443.i7LEh3aR024466@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 03:19:19 -0700, Andrew Morton wrote:
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm3/
...
> bk-scsi.patch

This one is broken. It causes the kernel to emit a bogus
"program $PROG is using a deprecated SCSI ioctl, please convert it to SG_IO"
message whenever user-space open(2)s a SCSI block device, even
though user-space never did any ioctl() on it.
