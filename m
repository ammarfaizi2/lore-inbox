Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTKUHME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 02:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTKUHME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 02:12:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:38547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264304AbTKUHMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 02:12:02 -0500
Date: Thu, 20 Nov 2003 23:17:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Message-Id: <20031120231749.7cc3f245.akpm@osdl.org>
In-Reply-To: <20031121061806.6A65F7007C@sv1.valinux.co.jp>
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>
>  recently I noticed that direct IO causes memory leaks with
>  linux-2.6.0-test9.
>  The program that causes memory leaks is "fsstress", which is
>  testcases/kernel/fs/fsstress in ltp-full-20031106.tgz (ftp from
>  http://sourceforge.net/projects/ltp/).
> 
>  fsstress does various file operations, and I found that the problem is
>  with the combination of write and dread (O_DIRECT read).
>  You should be able to reproduce the bug with the following command
>  line.
> 
>  $ while true; do ./fsstress -c -d /usr/src/test -z -f write=1 \
>   -f dread=1 -f creat=1 -S -n 1000 -p 32; done

It seems OK here.   Please take a copy of /proc/meminfo and /proc/slabinfo.

