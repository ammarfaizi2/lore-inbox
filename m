Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTJ0IHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 03:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTJ0IHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 03:07:48 -0500
Received: from [192.117.97.135] ([192.117.97.135]:13952 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S261297AbTJ0IHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 03:07:34 -0500
From: Aviram Jenik <aviram@beyondsecurity.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Announce: Swsusp-2.0-2.6-alpha1
Date: Mon, 27 Oct 2003 10:07:06 +0200
User-Agent: KMail/1.5.4
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>
References: <1067064107.1974.44.camel@laptop-linux> <200310261250.36616.aviram@jenik.com> <1067196494.14422.203.camel@laptop-linux>
In-Reply-To: <1067196494.14422.203.camel@laptop-linux>
Organization: Beyond Security Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-8-i"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271007.06225.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 October 2003 21:28, Nigel Cunningham wrote:
>  forgot to mention that you need to echo 1 > /proc/swsusp/enable_escape
> for pressing escape to work. (It's mentioned in
> Documentation/power/swsusp.txt).

Woops :-) Sorry for not RTFM'ing. I guess I was simply expecting it to work 
out of the box like the 2.4 did...

Here's the relevant message log after escaping the hibernation:

kernel: Swsusp 2.0-rc2D: Initiating a software_suspend cycle.
kernel: pccardd       S 00000000     0     9      1            10     8 
(L-TLB)
kernel: c1389f7c 00000046 00000004 00000000 c13aaec0 cfd7942c 00000000 
c1388000 
kernel:        c02f4849 cfd7942c 00000004 00000000 3fd795c8 00001dab 9b6139eb 
00000008
kernel:        00000000 cfd79588 c1388000 cfd7942c c02f4db8 cfd7942c cfd79430 
c03bd612 
kernel: Call Trace:
kernel:  [socket_insert+153/336] socket_insert+0x99/0x150
kernel:  [pccardd+568/976] pccardd+0x238/0x3d0
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [pccardd+0/976] pccardd+0x0/0x3d0
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
kernel: 
kernel: khubd         S 00000004     0    80      1           126    72 
(L-TLB)
kernel: cf4fffa4 00000046 cf6f9680 00000004 00000004 00000004 cf6f9680 
00000202 
kernel:        cf6f9680 cf4fff96 cf4fff94 00000001 d0a347b0 00000e91 ad37485b 
0000000a 
kernel:        cf4fe000 cf4fe000 00000000 cf4fffc0 d0a279b5 00000009 d0a2d43b 
d0a2d8f6 
kernel: Call Trace:
kernel:  [_end+274258637/1068908824] hub_thread+0x225/0x270 [usbcore]
kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [_end+274258088/1068908824] hub_thread+0x0/0x270 [usbcore]
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
kernel: 
kernel: scsi_eh_1     S AAAAE6A2     0   127      1           196   126 
(L-TLB)
kernel: cf267f68 00000046 5f54c35c aaaae6a2 4ccddf5d aaba3aa3 00000046 
2aaaaaba 
kernel:        d4545751 baaeaa9a 75545d7d cf501900 cf501920 000012c3 a29564f9 
0000000a 
kernel:        cf267fd0 00000246 cf266000 cf5012e0 c0108627 cf266000 cf267fd8 
00000000 
kernel: Call Trace:
kernel:  [__down_interruptible+167/320] __down_interruptible+0xa7/0x140
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [__down_failed_interruptible+7/12] __down_failed_interruptible
+0x7/0xc
kernel:  [_end+274080304/1068908824] .text.lock.scsi_error+0x41/0x49 
[scsi_mod]
kernel:  [_end+274079080/1068908824] scsi_error_handler+0x0/0x2a0 [scsi_mod]
kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
kernel: 
kernel: B82     0   685      1           688   603 (NOTLB)
kernel: cb545eb0 00000082 cdab32e0 3b5d6b82 000000a1 00000000 cab95900 
c03e6b74 
kernel:        cdab32e0 3b5d6b82 000000a1 c671f900 c671f920 00000213 3b6086f4 
000000a1 
kernel:        00000000 7fffffff 00000024 00000000 c0125f15 c4a80980 00000008 
00000023 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [unix_poll+43/160] unix_poll+0x2b/0xa0
kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S 00000000     0   688      1           690   685 
(NOTLB)
kernel: cab93eb0 00000082 00000000 00000000 000000a0 00000000 cab94080 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 cab93ec4 00000246 00000ea3 98e523ab 
000000a1 
kernel:        00152d95 cab93ec4 0000000e 00000000 c0125ec3 cab93ec4 00152d95 
0000000d 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       T C01740E4     0   690      1           696   688 
(NOTLB)
kernel: cac63f1c 00000082 00000000 c01740e4 00000000 00000000 00000012 
c017446f 
kernel:        cac63f40 00000000 00000000 c1315900 c1315920 00000faf 0d6640f0 
000000a2 
kernel:        cac62000 00000000 c039621b 00000000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [poll_freewait+68/80] poll_freewait+0x44/0x50
kernel:  [do_select+431/720] do_select+0x1af/0x2d0
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [sys_access+606/624] sys_access+0x25e/0x270
kernel:  [do_gettimeofday+26/176] do_gettimeofday+0x1a/0xb0
kernel:  [sys_gettimeofday+84/192] sys_gettimeofday+0x54/0xc0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       T C8C72000     0   696      1           721   690 
(NOTLB)
kernel: c8c73f58 00000082 000000b8 c8c72000 ce9f5fcc ce9f5fc8 ce9f5fc4 
ce9f5fd8 
kernel:        ce9f5fd4 ce9f5fd0 00000000 c1315900 c1315920 00001b15 4d2c5d94 
000000a2 
kernel:        c8c72000 00000000 c039621b c8c72000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [do_gettimeofday+26/176] do_gettimeofday+0x1a/0xb0
kernel:  [sys_open+414/432] sys_open+0x19e/0x1b0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S 3B5EF8EF     0   721      1           682   696 
(NOTLB)
kernel: ca29beb0 00200082 cab95900 3b5ef8ef 000000a1 00000000 cdab32e0 
c03e6b74 
kernel:        00000010 3b5ef8ef 000000a1 cab95900 cab95920 00004ff6 3b607441 
000000a1 
kernel:        00000000 7fffffff 00000008 00000000 c0125f15 c98f7800 00000010 
00000004 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [pipe_poll+52/128] pipe_poll+0x34/0x80
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kwrapper      R C02C9820     0   722    619                 664 
(NOTLB)
kernel: cabb3ef8 00000082 c048060c c02c9820 00007530 001526cf 00000001 
c012f681 
kernel:        cabb3edc 000f41a8 00000000 c1315900 c1315920 00000c14 7c416685 
000000a2 
kernel:        cabb2000 cabb3f68 00000000 00000000 c0130324 cabb3f68 00152ab9 
00000000 
kernel: Call Trace:
kernel:  [task_in_intr+0/464] task_in_intr+0x0/0x1d0
kernel:  [adjust_abs_time+193/304] adjust_abs_time+0xc1/0x130
kernel:  [do_clock_nanosleep+452/816] do_clock_nanosleep+0x1c4/0x330
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [sys_rt_sigaction+254/288] sys_rt_sigaction+0xfe/0x120
kernel:  [nanosleep_wake_up+0/16] nanosleep_wake_up+0x0/0x10
kernel:  [sys_nanosleep+131/240] sys_nanosleep+0x83/0xf0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S 00000000     0   724      1           727   682 
(NOTLB)
kernel: c8b57eb0 00000082 00000000 00000000 c038f14f 00000000 c8c74cc0 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 c8c752e0 c8c75300 0000149d 8d871cb8 
000000a0 
kernel:        00000000 7fffffff 00000017 00000000 c0125f15 c3398800 00400000 
00000016 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [unix_poll+43/160] unix_poll+0x2b/0xa0
kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S F1A690FD     0   725    682           732       
(NOTLB)
kernel: cabc3eb0 00000086 c8094080 f1a690fd 000000a1 00000000 cd5566a0 
c03e6b74 
kernel:        cd557900 f1a690fd 000000a1 c8094080 c80940a0 0000041a f1d86646 
000000a1 
kernel:        00000000 7fffffff 0000000a 00000000 c0125f15 c8be5b00 00000200 
00000009 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [unix_poll+43/160] unix_poll+0x2b/0xa0
kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S 00000000     0   727      1           729   724 
(NOTLB)
kernel: c8b9feb0 00000082 00000000 00000000 c038f14f 00000000 c8c752e0 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 c8095900 c8095920 000089ef 8d87a6a7 
000000a0 
kernel:        00000000 7fffffff 00000009 00000000 c0125f15 c8063980 00000020 
00000005 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [pipe_poll+52/128] pipe_poll+0x34/0x80
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       T C01740E4     0   729      1           731   727 
(NOTLB)
kernel: c8093f1c 00000086 00000000 c01740e4 00000000 00000000 00000009 
c017446f 
kernel:        c8093f40 00000000 00000000 c1315900 c1315920 0000106e f81f9fc4 
000000a1 
kernel:        c8092000 00000000 c039621b 00000000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [poll_freewait+68/80] poll_freewait+0x44/0x50
kernel:  [do_select+431/720] do_select+0x1af/0x2d0
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [sys_access+606/624] sys_access+0x25e/0x270
kernel:  [do_gettimeofday+26/176] do_gettimeofday+0x1a/0xb0
kernel:  [sys_gettimeofday+84/192] sys_gettimeofday+0x54/0xc0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       T C83A6000     0   731      1           740   729 
(NOTLB)
kernel: c83a7f58 00000086 00000978 c83a6000 ce9f5aec ce9f5ae8 ce9f5ae4 
ce9f5af8 
kernel:        ce9f5af4 ce9f5af0 00000000 c1315900 c1315920 00001fa0 f44fa044 
000000a1 
kernel:        c83a6000 00000000 c039621b c83a6000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [do_gettimeofday+26/176] do_gettimeofday+0x1a/0xb0
kernel:  [sys_write+385/400] sys_write+0x181/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       R 6F342CFD     0   732    682          2263   725 
(NOTLB)
kernel: c64ebeb0 00000086 cf915900 6f342cfd 000000a2 00000000 c80952e0 
c03e6b74 
kernel:        00000010 6f342cfd 000000a2 cf915900 cf915920 000003f7 6f342cfd 
000000a2 
kernel:        001529dc c64ebec4 00000004 00000000 c0125ec3 c64ebec4 001529dc 
00000003 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kmix          R 00000000     0   738      1           741   740 
(NOTLB)
kernel: c6c9beb0 00000082 00000000 00000000 000000a1 00000000 c671ecc0 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 c1315900 c1315920 0000295e 9bca0f3d 
000000a2 
kernel:        001529a8 c6c9bec4 00000009 00000000 c0125ec3 c6c9bec4 001529a8 
00000005 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kpilotDaemon  S 00000000     0   740      1           738   731 
(NOTLB)
kernel: c6fb9eb0 00000082 00000000 00000000 c038f14f 00000000 c671e080 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 cab952e0 cab95300 0000c82f 8dd1c2ef 
000000a0 
kernel:        00000000 7fffffff 0000000b 00000000 c0125f15 c029e04c c9813000 
c981391c 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [normal_poll+284/368] normal_poll+0x11c/0x170
kernel:  [tty_poll+105/128] tty_poll+0x69/0x80
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kopete        T C6600000    12   741      1  2111     783   738 
(NOTLB)
kernel: c6601f58 00000082 057a6178 c6600000 ce9f560c ce9f5608 ce9f5604 
ce9f5618 
kernel:        ce9f5614 ce9f5610 00000000 c1315900 c1315920 00013b8c f53050a3 
000000a1 
kernel:        c6600000 00000000 c039621b c6600000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [do_gettimeofday+26/176] do_gettimeofday+0x1a/0xb0
kernel:  [sys_writev+385/400] sys_writev+0x181/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: gkrellm       T C56B6D80     0   767      1   786     794   782 
(NOTLB)
kernel: c5605f58 00200082 c030f569 c56b6d80 c4a81500 00000000 00000145 
c0174b4b 
kernel:        c56b6d80 00000000 ca05d940 c1315900 c1315920 00001c3f f506942a 
000000a1 
kernel:        c5604000 00000000 c039621b c5604000 c01352e5 00000001 00000006 
00000000 
kernel: Call Trace:
kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
kernel:  [do_pollfd+91/160] do_pollfd+0x5b/0xa0
kernel:  [refrigerator+165/592] refrigerator+0xa5/0x250
kernel:  [__swsusp_activity_start+222/240] __swsusp_activity_start+0xde/0xf0
kernel:  [sys_read+385/400] sys_read+0x181/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kalarmd       S 00000000  2204   782      1           767   783 
(NOTLB)
kernel: ca7d5eb0 00000086 00000000 00000000 c038f14f 00000000 cab952e0 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 c8094080 c80940a0 00001519 8dd280d6 
000000a0 
kernel:        00156e09 ca7d5ec4 00000009 00000000 c0125ec3 ca7d5ec4 00156e09 
00000005 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: korgac        S 00000000     0   783      1           782   741 
(NOTLB)
kernel: c4a63eb0 00000082 00000000 00000000 c038f14f 00000000 c4a65900 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 cab94cc0 cab94ce0 0000e0bf 8d844c70 
000000a0 
kernel:        00000000 7fffffff 00000009 00000000 c0125f15 c57b2500 00000020 
00000005 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [pipe_poll+52/128] pipe_poll+0x34/0x80
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: gkrellm       S C8094CC0     0   786    767                     
(NOTLB)
kernel: c6aa7f08 00200082 00000000 c8094cc0 c03e6b74 00000010 c03e6d9c 
00000000 
kernel:        000000d0 bf700000 00000000 c1315900 c1315920 000005e1 4a7d30d2 
000000a2 
kernel:        00152b5d c6aa7f1c c6aa7f60 000007d1 c0125ec3 c6aa7f1c 00152b5d 
c83cbb00 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_poll+168/208] do_poll+0xa8/0xd0
kernel:  [sys_poll+423/704] sys_poll+0x1a7/0x2c0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_waitpid+37/41] sys_waitpid+0x25/0x29
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kmail         R 00000000     0   794      1                 767 
(NOTLB)
kernel: c671deb0 00000086 00000000 00000000 c671df04 00000000 c671f900 
c03e6b74 
kernel:        00000010 c03e6d9c 00000000 c1315900 c1315920 0000395a 66bf2500 
000000a2 
kernel:        0015294e c671dec4 00000011 00000000 c0125ec3 c671dec4 0015294e 
00000010 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: ispell        S C1A7A6BE     8  2111    741                     
(NOTLB)
kernel: c79b1d70 00000086 c671e6a0 c1a7a6be 00000091 cfce5fc0 00000003 
00000000 
kernel:        c671e6a0 c1a7a6be 00000091 c671e6a0 c671e6c0 00000e4b c1a7b776 
00000091 
kernel:        c79b0000 7fffffff ffffe000 7fffffff c0125f15 3cc9d830 c68e4780 
00000000 
kernel: Call Trace:
kernel:  [schedule_timeout+181/192] schedule_timeout+0xb5/0xc0
kernel:  [unix_stream_data_wait+203/288] unix_stream_data_wait+0xcb/0x120
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
kernel:  [unix_stream_recvmsg+1323/1424] unix_stream_recvmsg+0x52b/0x590
kernel:  [sock_def_readable+129/144] sock_def_readable+0x81/0x90
kernel:  [sock_aio_read+273/368] sock_aio_read+0x111/0x170
kernel:  [do_sync_read+137/192] do_sync_read+0x89/0xc0
kernel:  [recalc_task_prio+168/464] recalc_task_prio+0xa8/0x1d0
kernel:  [update_wall_time+22/64] update_wall_time+0x16/0x40
kernel:  [do_timer+224/240] do_timer+0xe0/0xf0
kernel:  [vfs_read+255/304] vfs_read+0xff/0x130
kernel:  [sys_read+85/400] sys_read+0x55/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       R 6F340949     0  2263    682          2294   732 
(NOTLB)
kernel: ca759eb0 00000082 c80952e0 6f340949 000000a2 00000000 c564ecc0 
c03e6b74 
kernel:        00000010 6f340949 000000a2 c80952e0 c8095300 000003fa 6f340949 
000000a2 
kernel:        001529dc ca759ec4 00000004 00000000 c0125ec3 ca759ec4 001529dc 
00000003 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       S F1A76B6A     0  2294    682  2298    2395  2263 
(NOTLB)
kernel: c34b7eb0 00000086 c8c74080 f1a76b6a 000000a1 00000000 c8094080 
c03e6b74 
kernel:        cd5566a0 f1a76b6a 000000a1 c8c74080 c8c740a0 00000589 f1d89da2 
000000a1 
kernel:        00158cdc c34b7ec4 0000000c 00000000 c0125ec3 c34b7ec4 00158cdc 
cbc0791c 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [sock_ioctl+245/720] sock_ioctl+0xf5/0x2d0
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: bash          S C564E6A0     8  2298   2294  2333               
(NOTLB)
kernel: c6e5ff38 00000086 0f054065 c564e6a0 c5675900 c5675920 c59dcb40 
c80946a0 
kernel:        c011836c c5675900 c59dcb40 c564e6a0 c564e6c0 00036851 a9e79e01 
00000095 
kernel:        fffffe00 c6e5e000 c8094748 c8094748 c0120641 ffffffff 00000002 
c564e6a0 
kernel: Call Trace:
kernel:  [do_page_fault+828/1326] do_page_fault+0x33c/0x52e
kernel:  [sys_wait4+513/816] sys_wait4+0x201/0x330
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [sigprocmask+64/192] sigprocmask+0x40/0xc0
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [sys_waitpid+37/41] sys_waitpid+0x25/0x29
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: bash          D D2C0F9C6     0  2333   2298                     
(NOTLB)
kernel: c7e13eb8 00000086 c1315900 d2c0f9c6 000000a1 c1315900 c7e13ea4 
c7e13eb4 
kernel:        00000046 d2c0f9c6 000000a1 c1315900 c1315920 00005370 d2c0fd4d 
000000a1 
kernel:        c03e69f8 c7e12000 c7e12000 c7e13f0c c011a498 00000000 c564e6a0 
c011a190 
kernel: Call Trace:
kernel:  [wait_for_completion+120/208] wait_for_completion+0x78/0xd0
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
kernel:  [software_suspend_pending+109/112] software_suspend_pending+0x6d/0x70
kernel:  [get_zeroed_page+37/112] get_zeroed_page+0x25/0x70
kernel:  [swsusp_write_proc+216/416] swsusp_write_proc+0xd8/0x1a0
kernel:  [proc_file_write+133/224] proc_file_write+0x85/0xe0
kernel:  [vfs_write+184/304] vfs_write+0xb8/0x130
kernel:  [sys_write+85/400] sys_write+0x55/0x190
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 
kernel: kdeinit       R 6F33E57B     0  2395    682                2294 
(NOTLB)
kernel: c797feb0 00000082 c564ecc0 6f33e57b 000000a2 00000000 c564f900 
c03e6b74 
kernel:        00000010 6f33e57b 000000a2 c564ecc0 c564ece0 00000a04 6f33e57b 
000000a2 
kernel:        001529dc c797fec4 00000004 00000000 c0125ec3 c797fec4 001529dc 
00000003 
kernel: Call Trace:
kernel:  [schedule_timeout+99/192] schedule_timeout+0x63/0xc0
kernel:  [process_timeout+0/16] process_timeout+0x0/0x10
kernel:  [do_select+391/720] do_select+0x187/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+763/1312] sys_select+0x2fb/0x520
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
kernel: 


- Aviram
