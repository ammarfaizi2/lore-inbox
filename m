Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965257AbVIOO1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965257AbVIOO1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbVIOO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:27:48 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:22954 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S965257AbVIOO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:27:46 -0400
Date: Thu, 15 Sep 2005 16:28:56 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: WU Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptive read-ahead: benchmarks
Message-ID: <20050915162856.1fd5bb38@localhost>
In-Reply-To: <20050915131651.GA5336@mail.ustc.edu.cn>
References: <20050915131651.GA5336@mail.ustc.edu.cn>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2005 21:16:51 +0800
WU Fengguang <wfg@mail.ustc.edu.cn> wrote:

> oprofile() {
>         opcontrol --vmlinux=/temp/kernel/linux-2.6.13ra/vmlinux
>         opcontrol --start
>         opcontrol --reset
>         echo $1 > /proc/sys/vm/readahead_ratio
>         dd if=/temp/kernel/hugefile of=/dev/null bs=$bs
>         opreport -l -o oprofile.$1.$bs /temp/kernel/linux-2.6.13ra/vmlinux
>         opcontrol --stop
> }

just a side note: shouldn't you umount and remount "/temp" to remove
the pagecache? Or is the file so big that it doesn't matter?

PS: instead of unmount/remount you can use "fadvise":
http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

-- 
	Paolo Ornati
	Linux 2.6.14-rc1 on x86_64
