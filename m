Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUHECd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUHECd0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 22:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHECd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 22:33:26 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9655 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S267386AbUHECdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 22:33:25 -0400
From: David Brownell <david-b@pacbell.net>
To: Norbert Preining <preining@logic.at>
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Date: Wed, 4 Aug 2004 19:26:31 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <20040802171325.GA26949@gamma.logic.tuwien.ac.at> <20040803081134.GA13745@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040803081134.GA13745@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408041926.31293.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 August 2004 01:11, Norbert Preining wrote:
> Then I tried lsusb, which hang, here is what sysrq-t says:
> lsusb         D C0158CDC     0  3942   3849                     (NOTLB)
> ...
> Call Trace:
>  [<c0158cdc>] link_path_walk+0xa1f/0xd4e
>  [<c02d3f5f>] __down+0x8b/0x116
>  [<c0118cf9>] default_wake_function+0x0/0xc
>  [<e08e0798>] usbdev_open+0x54/0xfa [usbcore]
>  [<c02d4144>] __down_failed+0x8/0xc
>  [<e08e26ba>] .text.lock.devio+0x5/0xff [usbcore]
>  [<c014ba8b>] filp_open+0x4c/0x4e
>  [<c014c62d>] vfs_read+0xa9/0xf5
>  [<c014c846>] sys_read+0x38/0x59
>  [<c0105e4f>] syscall_call+0x7/0xb

Not clear how to read that stack; if it's usbdev_open()
that's making the trouble, lock_kernel() is blocked.
But that doesn't quite make sense to me.  Sorry!

- Dave

