Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTJ3GWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 01:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJ3GWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 01:22:47 -0500
Received: from www13.mailshell.com ([209.157.66.247]:10966 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S262197AbTJ3GWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 01:22:45 -0500
Message-ID: <20031030062243.20629.qmail@mailshell.com>
Date: Thu, 30 Oct 2003 08:22:40 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
References: <20031028154920.1905.qmail@mailshell.com>	<20031028141329.13443875.akpm@osdl.org>	<20031029174419.5776.qmail@mailshell.com>	<20031029123107.338796a4.akpm@osdl.org>	<200310292149.h9TLnsNq024151@car.linuxhacker.ru> <20031029141931.6c4ebdb5.akpm@osdl.org>
In-Reply-To: <20031029141931.6c4ebdb5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031028@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Oleg Drokin <green@linuxhacker.ru> wrote:
> 
>>Hello!
>>
>>Andrew Morton <akpm@osdl.org> wrote:
>>
>>>>Here are the results (output of dmesg) from booting a kernel with this
>>>>patch:
>>>>set_blocksize: size=4096
>>>>buffer layer error at fs/buffer.c:431
>>
>>AM> hm, that didn't tell us much :(
>>AM> Could you add Oleg's patch as well?
>>
>>Actually it will say that device's block size is 4096 (confirming
>>last set_blocksize was at least partially succesful),
> 
> 
> Assuming that the printk is for the correct filesystem, yes.

I have only one filesystem - this one large ReiserFS, if that's
the question. Here is "fdisk -l":

Disk /dev/hda: 81.9 GB, 81963220480 bytes
255 heads, 63 sectors/track, 9964 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

    Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1         122      979933+  82  Linux swap
/dev/hda2             123        9964    79055865   83  Linux

> Amos, could you add this as well?

I'm compiling ther kernel with this patch (and Andrew's previous two
patches) as I write this.

Thanks,

--Amos

