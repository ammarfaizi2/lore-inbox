Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288919AbSATXnH>; Sun, 20 Jan 2002 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSATXm6>; Sun, 20 Jan 2002 18:42:58 -0500
Received: from arnold.dormnet.his.se ([193.10.185.236]:57864 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP
	id <S288919AbSATXmp>; Sun, 20 Jan 2002 18:42:45 -0500
Date: Mon, 21 Jan 2002 00:42:35 +0100
From: Andreas Henriksson <NOSPAMandreas.henriksson@linux.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 oops
Message-ID: <20020121004235.A398@fatal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I can't read anything out of this but heres what was in my syslog after the
box had mysteriously rebooted. 

<snip>

Jan 20 22:35:07 mirkk kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jan 20 22:35:07 mirkk kernel: eth1: Tx timed out, cable problem? TSR=0x0,
ISR=0x0, t=30.
Jan 20 22:35:09 mirkk kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jan 20 22:35:09 mirkk kernel: eth1: Tx timed out, cable problem? TSR=0x0,
ISR=0x0, t=110.
Jan 20 22:35:22 mirkk kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jan 20 22:35:22 mirkk kernel: eth1: Tx timed out, cable problem? TSR=0x0,
ISR=0x0, t=115.
Jan 20 22:37:14 mirkk kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Jan 20 22:37:14 mirkk kernel:  printing eip:
Jan 20 22:37:14 mirkk kernel: c013c66a
Jan 20 22:37:14 mirkk kernel: *pde = 00000000
Jan 20 22:37:14 mirkk kernel: Oops: 0000
Jan 20 22:37:14 mirkk kernel: CPU:    0
Jan 20 22:37:14 mirkk kernel: EIP:    0010:[prune_icache+46/216]    Not
tainted
Jan 20 22:37:14 mirkk kernel: EFLAGS: 00010217
Jan 20 22:37:14 mirkk kernel: eax: 00000001   ebx: 00000000   ecx: 00000001
  edx: c0752da0
Jan 20 22:37:14 mirkk kernel: esi: fffffff8   edi: 00000000   ebp: c184fe34
  esp: c184fe1c
Jan 20 22:37:14 mirkk kernel: ds: 0018   es: 0018   ss: 0018
Jan 20 22:37:14 mirkk kernel: Process smbd (pid: 13135, stackpage=c184f000)
Jan 20 22:37:14 mirkk kernel: Stack: 0000000f 000001d2 00000020 00000000
c184fe2c c184fe2c 00000006 c013c72f 
Jan 20 22:37:14 mirkk kernel:        000007bf c0125e37 00000006 000001d2
00000006 000001d2 00000006 000001d2 
Jan 20 22:37:14 mirkk kernel:        c024ba48 c024ba48 c024ba48 c0125e6d
00000020 c184e000 00000000 00000000 
Jan 20 22:37:14 mirkk kernel: Call Trace: [shrink_icache_memory+27/48]
[shrink_caches+115/140] [try_to_free_pages+29/60]
[balance_classzone+78/384] [filemap_nopage+189/520] 
Jan 20 22:37:14 mirkk kernel:    [__alloc_pages+283/392]
[can_share_swap_page+61/88] [_alloc_pages+22/24] [do_wp_page+131/352]
[handle_mm_fault+123/180] [do_page_fault+348/1176] 
Jan 20 22:37:14 mirkk kernel:    [do_page_fault+0/1176] [fput+175/208]
[filp_close+92/100] [sys_close+67/84] [error_code+52/64] 
Jan 20 22:37:14 mirkk kernel: 
Jan 20 22:37:14 mirkk kernel: Code: 8b 7f 04 8b 86 08 01 00 00 a9 38 00 00
00 74 06 0f 0b 8d 74 
Jan 20 22:38:01 mirkk /USR/SBIN/CRON[13139]: (mail) CMD (  if [ -x
/usr/sbin/exim -a -f /etc/exim/exim.conf ]; then /usr/sbin/exim -q ; fi)
Jan 20 22:38:02 mirkk kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Jan 20 22:38:02 mirkk kernel:  printing eip:
Jan 20 22:38:02 mirkk kernel: c013c66a
Jan 20 22:38:02 mirkk kernel: *pde = 00000000
Jan 20 22:38:02 mirkk kernel: Oops: 0000
Jan 20 22:38:02 mirkk kernel: CPU:    0
Jan 20 22:38:02 mirkk kernel: EIP:    0010:[prune_icache+46/216]    Not
tainted
Jan 20 22:38:02 mirkk kernel: EFLAGS: 00010217
Jan 20 22:38:02 mirkk kernel: eax: 00000001   ebx: 00000000   ecx: 00000001
  edx: c0752da0
Jan 20 22:38:02 mirkk kernel: esi: fffffff8   edi: 00000000   ebp: c0ef1e34
  esp: c0ef1e1c
Jan 20 22:38:02 mirkk kernel: ds: 0018   es: 0018   ss: 0018
Jan 20 22:38:02 mirkk kernel: Process exim (pid: 13140, stackpage=c0ef1000)
Jan 20 22:38:02 mirkk kernel: Stack: 00000019 000001d2 00000020 00000000
c0ef1e2
c c0ef1e2c 00000006 c013c72f 
Jan 20 22:38:02 mirkk kernel:        000007cc c0125e37 00000006 000001d2
00000006 000001d2 00000006 000001d2 
Jan 20 22:38:02 mirkk kernel:        c024ba48 c024ba48 c024ba48 c0125e6d
00000020 c0ef0000 00000000 00000000 
Jan 20 22:38:02 mirkk kernel: Call Trace: [shrink_icache_memory+27/48]
[shrink_caches+115/140] [try_to_free_pages+29/60]
[balance_classzone+78/384] [filemap_nopage+189/520] 
Jan 20 22:38:02 mirkk kernel:    [__alloc_pages+283/392]
[do_no_page+77/268] [_alloc_pages+22/24] [do_wp_page+131/352]
[handle_mm_fault+123/180] [do_page_fault+348/1176] 
Jan 20 22:38:02 mirkk kernel:    [do_page_fault+0/1176] [old_mmap+244/300]
[filp_close+92/100] [sys_close+67/84] [error_code+52/64] 
Jan 20 22:38:02 mirkk kernel: 
Jan 20 22:38:02 mirkk kernel: Code: 8b 7f 04 8b 86 08 01 00 00 a9 38 00 00
00 74 06 0f 0b 8d 74 
Jan 20 22:39:06 mirkk dhclient-2.2.x: DHCPREQUEST on eth0 to 10.0.112.1
port 67
Jan 20 22:39:06 mirkk dhclient-2.2.x: DHCPACK from 10.0.112.1
Jan 20 22:39:06 mirkk dhclient-2.2.x: bound to 217.208.89.162 -- renewal in
600 seconds.
Jan 20 22:49:37 mirkk syslogd 1.4.1#8: restart.
Jan 20 22:49:37 mirkk kernel: klogd 1.4.1#8, log source = /proc/kmsg
started.
Jan 20 22:49:37 mirkk kernel: Inspecting /boot/System.map-2.4.14

</snip>



//Andreas Henriksson

