Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVJQLPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVJQLPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 07:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVJQLPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 07:15:54 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39046 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932269AbVJQLPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 07:15:54 -0400
From: Takao Indoh <indou.takao@soft.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OBATA Noboru <noboru.obata.ar@hitachi.com>, hyoshiok@miraclelinux.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Dump Summit 2005
Date: Mon, 17 Oct 2005 20:19:13 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 4.51
In-Reply-To: <20051010174931.223310de.akpm@osdl.org>
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com> 
	<20051006.211718.74749573.noboru.obata.ar@hitachi.com> 
	<20051010174931.223310de.akpm@osdl.org>
Message-Id: <C0C5D30C9A813Cindou.takao@soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am a developer of diskdump.

On Mon, 10 Oct 2005 17:49:31 -0700, Andrew Morton wrote:
>I was rather expecting that the various groups which are interested in
>crash dumping would converge around kdump once it was merged.  But it seems
>that this is not the case and that work continues on other strategies.
>
>Is that a correct impression?  If so, what shortcoming(s) in kdump are
>causing people to be reluctant to use it?


I hope all current dump functions (diskdump, LKCD, netdump, etc) are
integrated into kdump. I think it is possible if the following two
problems of kdump are solved.

(1) problem of reliability

It seems that kdump has some problems regarding hardware.
Noboru OBATA said:

>In terms of reliability, hardware-related issues, such as a
>device reinitialization problem, an ongoing DMA problem, and
>possibly a pending interrupts problem, must be carefully
>resolved.

I think it is necessary to verify how surely the 2nd kernel can be 
booted.


(2) memory size problem

If memory size is huge, the time for dumping and size of dump file
become serious problem. Diskdump has functions of partial dump and
compression to solve this problem. Kdump does not have such functions
yet.


The 2nd issue (memory size problem) may be solved by exporting
diskdump's functions to kdump.

I hope these issues would be solved at first. (We can wait
for completion of kdump development by operating current
diskdump and/or LKCD.)

Takao Indoh
