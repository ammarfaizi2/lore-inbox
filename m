Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTCEUFE>; Wed, 5 Mar 2003 15:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTCEUFE>; Wed, 5 Mar 2003 15:05:04 -0500
Received: from [65.206.249.98] ([65.206.249.98]:5639 "EHLO skat.sky.com")
	by vger.kernel.org with ESMTP id <S261364AbTCEUFB>;
	Wed, 5 Mar 2003 15:05:01 -0500
Message-ID: <022801c2e353$e4fd9550$0400130a@jianwen>
Reply-To: "Jianwen" <jw.pi@servgate.com>
From: "Jianwen" <jw.pi@servgate.com>
To: "kernel" <linux-kernel@vger.kernel.org>
Subject: kernel crash?
Date: Wed, 5 Mar 2003 12:14:53 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, there

I currently installed Redhat7.3 (kernel 2.4.18-3) and Squid-2.5-STABLE1
running
in my linux box serving as the firewall and http proxy/cache server to 30+
internal
hosts, after a few hours' stress test -- 5~10hrs depends on the traffic, the
box will
crash with oops attached in the end FYI.

The traffic includes 120 Http requests/per second and others like ftp,
smtp/pop3
and udp.

The crash can be repeatable with most of time caused by process Squid, i
wonder
if the crash related with Squid, or something else, kernel? ext3 filesystem?
or
hardware related, my linux box use Celoron1G/VIA82C686/Intel82559.

Any suggestion will be highly appreciated, thanks in advanced.

- Jianwen


-------------------------------------------------------------------
Oops: 0000
EIP: 0010[c0166291] at journal_add_journal_head+0xc1/do
FLAGS=00010202
eax:00000000 ebx: d47abeb0 ecs:c3b9af80 edx:c3b9af80 esi:03b9af80
edi:d312d400 ebp:d37e9sc0 esp:db1bbdf4 ds:0019 es:0018 ss:0018
process squid(pid: 2335, stackpage=db1bb000)

Stack:
00000000 00000001 de12d400 c0160d0c c3b9af80
   00000000 db1bbe10 0000012b
....

CallTrace: [c0160d0c]journal_dirty_data+0x4c/180
[c0158fcc]journal_dirty_sync_data+0x1c/70
[c0109f3c]do_IRQ+0xcc/e0
[c010c308]call_do_IRQ+0x5/d
[c0158def]walk_page_buffers+0x5f/90
[c015922c]ext3_commit_write+0x12c/1e0
[c0158fb0]journal_dirty_sync_data+0x0/20
[c0158a30]ext3_get_block+0x0/70
[c0129858]generic_file_write+0x538/780
[c0156bd2]ext3_file_write+0x22/a0
[c01355c6]sys_write+0x96/f0
[c011a1b3]do_softirq+0x53/a0
[c0109f3c]do_IRQ+0xcc/e0
[c0108863]system_call+0x33/40


