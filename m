Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUAQTwR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 14:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUAQTwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 14:52:17 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:16865 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S266182AbUAQTwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 14:52:12 -0500
Date: Sat, 17 Jan 2004 11:51:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Condor <condor@vereya.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 may be bug in prints.c:341
Message-ID: <20040117195151.GY1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Condor <condor@vereya.net>, linux-kernel@vger.kernel.org
References: <00e201c3dd32$25bde0d0$8648493e@ixip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e201c3dd32$25bde0d0$8648493e@ixip.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 09:42:46PM +0200, Condor wrote:
> Hello all,
> 
> 1. My server stop work after trying to access hard drives.
> 2. My server have kernel panic when trying to access hard drives. I don't
> now what is the real problem,

Did you run fsck on the filesystem?

> Jan 16 01:55:19 heaven kernel: kernel BUG at prints.c:341!
> Jan 16 01:55:19 heaven kernel: invalid operand: 0000
> Jan 16 01:55:19 heaven kernel: CPU:    1
> Jan 16 01:55:19 heaven kernel: EIP:    0010:[<c01a3eb8>]    Not tainted
> Jan 16 01:55:19 heaven kernel: EFLAGS: 00010286
> Jan 16 01:55:19 heaven kernel: eax: 0000004a   ebx: eac82800   ecx: 00000000
> edx: f6febf7c
> Jan 16 01:55:19 heaven kernel: esi: 00000000   edi: c2849ed4   ebp: 00000002
> esp: c2849e24
> Jan 16 01:55:19 heaven kernel: ds: 0018   es: 0018   ss: 0018
> Jan 16 01:55:19 heaven kernel: Process kupdated (pid: 7, stackpage=c2849000)
> Jan 16 01:55:19 heaven kernel: Stack: c0270d4d c0324fc0 c0323560 eac82800
> c01b33f9 eac82800 c027b9a0 00001295
> Jan 16 01:55:19 heaven kernel:        00000296 00000001 00000004 eac82800
> 00000006 c2849ed4 00000000 c01b39e7
> Jan 16 01:55:19 heaven kernel:        c2849ed4 eac82800 00000001 00000006
> f899d38c 00000000 00000024 00000004
> Jan 16 01:55:19 heaven kernel: Call Trace:    [<c01b33f9>] [<c01b39e7>]
> [<c01b30e7>] [<c01a0c50>] [<c014785c>]
> Jan 16 01:55:19 heaven kernel:   [<c014684c>] [<c0146c02>] [<c0107652>]
> [<c0146ac0>] [<c0105000>] [<c01058be>]
> Jan 16 01:55:19 heaven kernel:   [<c0146ac0>]
> Jan 16 01:55:19 heaven kernel:
> Jan 16 01:55:19 heaven kernel: Code: 0f 0b 55 01 60 0d 27 c0 85 db 74 0e 0f
> b7 43 08 89 04 24 e8

You didn't run it through ksymoops...
