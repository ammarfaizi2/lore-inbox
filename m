Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293165AbSBQQRR>; Sun, 17 Feb 2002 11:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293170AbSBQQRI>; Sun, 17 Feb 2002 11:17:08 -0500
Received: from rdu57-16-044.nc.rr.com ([66.57.16.44]:63881 "EHLO joe.krahn")
	by vger.kernel.org with ESMTP id <S293165AbSBQQQy>;
	Sun, 17 Feb 2002 11:16:54 -0500
Message-ID: <3C6FD776.A8A4D263@nc.rr.com>
Date: Sun, 17 Feb 2002 11:16:54 -0500
From: Joe Krahn <jkrahn@nc.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VT crashing with XFree86-4.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using XFree86-4.2 with a Rage128 lately.
It often hangs in a way that looks like the
virtual termnial is dying. After the hang, I can
restart X (from a remote terminal), but I can no
longer access any text VTs.

Maybe the text consoles aren't dead, but
the video card can no longer be reset to text mode?
Maybe I should try it with an FB console?

Here's a traceback of XFree86:

(gdb) bt
#0  0x40139012 in __writev (fd=20, vector=0xbffff6fc, count=1)
    at ../sysdeps/unix/sysv/linux/writev.c:51
#1  0x080d5ad4 in _XSERVTransSocketWritev ()
#2  0x080d61cc in _XSERVTransWritev ()
#3  0x080d0248 in StandardFlushClient ()
#4  0x080cea8f in CloseDownConnection ()
#5  0x080b2f69 in CloseDownClient ()
#6  0x080addbd in Dispatch ()
#7  0x080bd6d8 in main ()
#8  0x4006e627 in __libc_start_main (main=0x80bd1f0 <main>, argc=1,
    ubp_av=0xbffffc04, init=0x806cc5c <_init>, fini=0x816f94c <_fini>,
    rtld_fini=0x4000dcd4 <_dl_fini>, stack_end=0xbffffbfc)
    at ../sysdeps/generic/libc-start.c:129       

Joe Krahn
