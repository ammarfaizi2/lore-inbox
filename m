Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbTAYWq5>; Sat, 25 Jan 2003 17:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbTAYWq5>; Sat, 25 Jan 2003 17:46:57 -0500
Received: from host14-201.pool80117.interbusiness.it ([80.117.201.14]:14978
	"HELO smtp.atlantide.uni.cc") by vger.kernel.org with SMTP
	id <S262472AbTAYWq4>; Sat, 25 Jan 2003 17:46:56 -0500
From: "Massimiliano C. - Uf0On|in3" <ufoonline@atlantide.uni.cc>
To: linux-kernel@vger.kernel.org
Subject: Kernel bug.
Date: Sat, 25 Jan 2003 23:56:34 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200301252356.34899.ufoonline@atlantide.uni.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry I'm not too expert and don't have undestrand what is the source code 
bugged.

script/ver_linux command report:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux atlantide.uni.cc 2.4.21-pre3 #2 SMP Sat Jan 25 12:30:48 CET 2003 i686 
unknown unknown GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.4
Modules Loaded         nls_iso8859-15 ppp_synctty ppp_generic slhc n_hdlc 
usb-uhci

Messages error:
Jan 25 23:31:26 atlantide kernel: wait_on_irq, CPU 1:
Jan 25 23:31:26 atlantide kernel: irq:  0 [ 0 0 ]
Jan 25 23:31:26 atlantide kernel: bh:   1 [ 2 0 ]
Jan 25 23:31:26 atlantide kernel: Stack dumps:
Jan 25 23:31:26 atlantide kernel: CPU 0:00020002 00020002 00020002 00020002 
00020002 00020002 00020002 00020002
Jan 25 23:31:26 atlantide kernel:        00020002 00020002 00020002 00020002 
00020002 00020002 00020002 00020002
Jan 25 23:31:26 atlantide kernel:        00020002 00020002 00020002 00020002 
00020002 00020002 00020002 00020002
Jan 25 23:31:26 atlantide kernel: Call Trace:
Jan 25 23:31:26 atlantide kernel:
Jan 25 23:31:26 atlantide kernel: CPU 1:d7871ee4 c02a011d 00000001 00000020 
00000000 c010854d c02a0132 00000001
Jan 25 23:31:26 atlantide kernel:        d7f2c820 d7943000 d8854333 d77d2000 
d7943974 d7f2c820 d885499f d7f2c820
Jan 25 23:31:26 atlantide kernel:        d7943000 d7f2c83c d77d2000 d7870000 
000000b4 d7943000 00000000 d7871f58
Jan 25 23:31:26 atlantide kernel: Call Trace:    [__global_cli+189/292] 
[ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.21-pre3/kernel/drive+-52429/96] 
[ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.21-pre3/kernel/drive+-50785/96] 
[tty_write+404/672] 
[ppp_synctty:__insmod_ppp_synctty_O/lib/modules/2.4.21-pre3/kernel/drive+-51228/96]
Jan 25 23:31:26 atlantide kernel:   [sys_write+150/268] [system_call+51/56]
Jan 25 23:31:26 atlantide kernel:

When and what's do this bug:

If u try to start a Udp Syn scan from 1 to 65535 on "your real IPv4" the 
system crash for some seconds and Sysload at the finish of "totally stop" 
give 6.0 of sysload.

I hope this is util for know and fix the bug:!

If u want others info conctat me :))

Thanks for all.

-- 
Best regards,
Massimiliano C.
Areaserver Coadmin
AreaServer IPv6 Tunnel Brocker Admin - http://tb.areaserver.org
