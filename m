Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbTIPO3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTIPO3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:29:25 -0400
Received: from abort.boom.net ([205.159.115.34]:11574 "EHLO abort.boom.net")
	by vger.kernel.org with ESMTP id S261251AbTIPO3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:29:24 -0400
Date: Tue, 16 Sep 2003 07:29:23 -0700
From: Reza Naima <reza@reza.net>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: linux-2.6.0-test5-mm2 ext3 filesystem wierdness
Message-ID: <20030916142923.GA28409@boom.net>
Reply-To: Reza Naima <reza@reza.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-URL: http://www.reza.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to recompile test5-mm2, I discovered that I have a file in a
wierd state where the system hangs while trying to access it... 

Here's the output of 'strace -f' and the gcc command that causes it to
lock.......

[pid  3416] write(3, ".byte 0x05\n        .asciz \"dma_c"..., 4096) = 4096
[pid  3416] brk(0)                      = 0x80a4000
[pid  3416] brk(0x80a6000)              = 0x80a6000
[pid  3416] open("./..tmp_kallsyms1.o.d", O_WRONLY|O_CREAT|O_TRUNC, 0666

then freezes.  I can kill strace, but not cpp0.

I also tried 'less ./..tmp_kallsyms1.o.d' and it locked..

root      3475  0.0  0.3  3820  728 pts/1    D    07:17   0:00 less ./..tmp_kallsyms1.o.d
root      3402  0.0  0.5  4164 1228 pts/1    D    07:12   0:00 /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/cpp0 -lang-a

I'll revert to test-4 to verify that I do not have this problem there.
If anyone wants more info or for me to run some tests, please feel free
to email me.

Reza
