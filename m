Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312584AbSDENWF>; Fri, 5 Apr 2002 08:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSDENV4>; Fri, 5 Apr 2002 08:21:56 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40976 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312584AbSDENVr>; Fri, 5 Apr 2002 08:21:47 -0500
Message-Id: <200204051319.g35DJXX25033@Port.imtp.ilyichevsk.odessa.ua>
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: [DEADLOCK] automount, kupdated: D state
Date: Fri, 5 Apr 2002 16:22:45 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit

I was saving my daily work on an IDE disk.
I use automounter. On an attempt to mount it several processes
got stuck in D state.

kernel: 2.5.7 + new NTFS driver
ps and ksymoopsed parts of Alt-Sysrq-T output are attached.
ksymoops warnings trimmed except automount.dump.ksymoops
(they were the same).
--
vda
--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="ps"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="ps"

  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:08 init HOME=/ TERM=linux devfs=mount
    2 ?        SW     0:00   [migration_CPU0]
    3 ?        SW     0:00   [keventd]
    4 ?        SWN    0:00   [ksoftirqd_CPU0]
    5 ?        SW     0:00   [kswapd]
    6 ?        SW     0:00   [bdflush]
    7 ?        DW     0:00   [kupdated]
    9 ?        SW     0:00   [rpciod]
  152 ?        S      0:00   devfsd /dev PWD=/ HOSTNAME=manta devfs=mount MACHTY
  330 ?        S      0:00   rpc.portmap PWD=/ HOSTNAME=manta devfs=mount MACHTY
  451 ?        S      0:00   syslogd PWD=/ HOSTNAME=manta devfs=mount MACHTYPE=i
  454 ?        S      0:00   klogd -x -c 3 PWD=/ HOSTNAME=manta devfs=mount MACH
 1624 ?        S      0:00   dhcpcd -t 20 -R -d eth0 PWD=/ HOSTNAME=manta devfs=
 1817 ?        S      0:00   inetd PWD=/ HOSTNAME=manta devfs=mount MACHTYPE=i38
 2123 ?        S      0:00     nmbd PWD=/ HOSTNAME=manta devfs=mount MACHTYPE=i3
 1848 ?        S      0:09   top c s PWD=/ HOSTNAME=manta devfs=mount MACHTYPE=i
 1878 ?        S      0:00   gpm -2 -m /dev/psaux -t ps2 PWD=/ HOSTNAME=manta de
 1911 ?        S      0:00   automount --timeout 5 /.local/mnt/auto program /roo
 2180 ?        S      0:00     automount --timeout 5 /.local/mnt/auto program /r
 2181 ?        D      0:00       /bin/umount //.local/mnt/auto/hdc2 PWD=/ HOSTNA
 2182 ?        S      0:00     automount --timeout 5 /.local/mnt/auto program /r
 2188 ?        D      0:00       /bin/mount -t auto -s -o noatime /dev/hdc2 /.lo
 2027 vc/1     S      0:00   /sbin/agetty 38400 tty1 linux TERM=linux
 2028 ?        S      0:00   login -- vda               
 2036 vc/2     S      0:00     -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/u
 2088 vc/2     S      0:01       ssh 172.16.42.75 PWD=/home/vda http_proxy=172.1
 2029 ?        S      0:00   login -- vda               
 2115 vc/3     S      0:00     -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/u
 2124 vc/3     S      0:03       mc PWD=/home/vda http_proxy=172.16.22.2:3128 HO
 2125 ?        S      0:00         cons.saver /dev/vc/3 PWD=/home/vda http_proxy
 2196 vc/3     S      0:00         /bin/bash -c ps -AH e >ps PWD=/home/vda http_
 2197 vc/3     R      0:00           ps -AH e PWD=/.share/home/vda/!BUG/hang_kup
 2030 vc/4     S      0:00   /sbin/agetty 38400 tty4 linux TERM=linux
 2031 vc/5     S      0:00   /sbin/agetty 38400 tty5 linux TERM=linux
 2032 vc/6     S      0:00   /sbin/agetty 38400 tty6 linux TERM=linux
 2033 vc/7     S      0:00   /sbin/agetty 38400 tty7 linux TERM=linux
 2034 vc/8     S      0:00   /sbin/agetty 38400 tty8 linux TERM=linux
 2035 vc/9     S      0:00   /sbin/agetty 38400 tty9 linux TERM=linux
 2046 ?        S      0:00   /bin/sh /home/vda/bin/xmga PWD=/home/vda http_proxy
 2047 ?        S      0:00     xinit -- -layout mga PWD=/home/vda http_proxy=172
 2048 ?        S      0:21       X :0 -layout mga PWD=/home/vda http_proxy=172.1
 2050 ?        S      0:00       /bin/sh /usr/bin/startkde PWD=/home/vda http_pr
 2089 ?        S      0:00         ksmserver --restore PWD=/home/vda http_proxy=
 2064 ?        S      0:00   kdeinit: Running...                                
 2090 ?        S      0:01     kdeinit: kwin                                    
 2144 ?        S      0:20     kdeinit: konsole -icon konsole -miniicon konsole 
 2145 pts/1    S      0:00       /bin/bash PWD=/home/vda http_proxy=172.16.22.2:
 2147 pts/1    S      0:00         mc PWD=/home/vda http_proxy=172.16.22.2:3128 
 2149 pts/1    S      0:08           konqueror ftp.gnu.org/gnu/glibc PWD=/.local
 2154 pts/2    S      0:00       /bin/bash PWD=/home/vda http_proxy=172.16.22.2:
 2156 pts/2    S      0:00         ssh 172.16.42.75 PWD=/home/vda http_proxy=172
 2160 pts/3    S      0:00       /bin/bash PWD=/home/vda http_proxy=172.16.22.2:
 2162 pts/3    S      0:03         mc PWD=/home/vda http_proxy=172.16.22.2:3128 
 2189 pts/4    S      0:00       /bin/bash PWD=/home/vda http_proxy=172.16.22.2:
 2191 pts/4    S      0:00         mc PWD=/home/vda http_proxy=172.16.22.2:3128 
 2194 pts/4    D      0:00           sync PWD=/.local/mnt/auto http_proxy=172.16
 2067 ?        S      0:00   kdeinit: dcopserver --nosid d                      
 2070 ?        S      0:00   kdeinit: klauncher                                 
 2073 ?        S      0:10   kdeinit: kded                                      
 2087 ?        S      0:00   kdeinit: knotify                                   
 2092 ?        S      0:10   kdeinit: kdesktop                                  
 2096 ?        S      0:04   kdeinit: kicker                                    
 2104 ?        S      0:01     ksysguardd PWD=/home/vda http_proxy=172.16.22.2:3
 2111 ?        S      0:00   kdeinit: kwrited                                   
 2113 pts/0    S      0:00     /bin/cat PWD=/home/vda http_proxy=172.16.22.2:312
 2114 ?        S      0:00   alarmd PWD=/home/vda http_proxy=172.16.22.2:3128 HO

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="automount.dump.ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="automount.dump.ksymoops"

ksymoops 2.4.1 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/2.5.7/System.map (specified)

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol set_cpus_allowed_R__ver_set_cpus_allowed not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says cb014374, /lib/modules/2.5.7/kernel/net/packet/af_packet.o says cb014164.  Ignoring /lib/modules/2.5.7/kernel/net/packet/af_packet.o entry
Call Trace: [<c0144dcd>] [<c0144fa9>] [<c013bd17>] [<c013b5a8>] [<c0108d13>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0144dcd <pipe_wait+69/9c>
Trace; c0144fa9 <pipe_read+1a9/214>
Trace; c013bd17 <sys_read+103/128>
Trace; c013b5a8 <filp_close+6c/b0>
Trace; c0108d13 <syscall_call+7/b>


5 warnings issued.  Results may not be reliable.

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="umount.dump.ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="umount.dump.ksymoops"

ksymoops 2.4.1 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/2.5.7/System.map (specified)

Call Trace: [<c01b37f2>] [<c01b3e23>] [<c01b422a>] [<c01b42f6>] [<c013cf65>] 
   [<c013d032>] [<c013d06b>] [<c014e607>] [<c013d166>] [<c013d1e7>] [<c014101e>] 
   [<c014188e>] [<c0140e93>] [<c0152767>] [<c0145c9c>] [<c0152e79>] [<c0152ecf>] 
   [<c0108d13>] 

Trace; c01b37f2 <get_request_wait+8e/118>
Trace; c01b3e23 <__make_request+237/4e8>
Trace; c01b422a <generic_make_request+156/1cc>
Trace; c01b42f6 <submit_bio+36/6c>
Trace; c013cf65 <write_locked_buffers+1d/28>
Trace; c013d032 <write_some_buffers+c2/e0>
Trace; c013d06b <write_unlocked_buffers+1b/44>
Trace; c014e607 <dput+e7/164>
Trace; c013d166 <sync_buffers+12/48>
Trace; c013d1e7 <fsync_super+f/b0>
Trace; c014101e <generic_shutdown_super+2e/f8>
Trace; c014188e <kill_block_super+e/24>
Trace; c0140e93 <deactivate_super+3b/78>
Trace; c0152767 <__mntput+17/24>
Trace; c0145c9c <path_release+28/30>
Trace; c0152e79 <sys_umount+3d/88>
Trace; c0152ecf <sys_oldumount+b/10>
Trace; c0108d13 <syscall_call+7/b>

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="sync.dump.ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="sync.dump.ksymoops"

ksymoops 2.4.1 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/2.5.7/System.map (specified)

Call Trace: [<c01b37f2>] [<c01b3e23>] [<c01b422a>] [<c01b42f6>] [<c013cf65>] 
   [<c013d032>] [<c013d06b>] [<c013d1a4>] [<c013d33f>] [<c0108d13>] 

Trace; c01b37f2 <get_request_wait+8e/118>
Trace; c01b3e23 <__make_request+237/4e8>
Trace; c01b422a <generic_make_request+156/1cc>
Trace; c01b42f6 <submit_bio+36/6c>
Trace; c013cf65 <write_locked_buffers+1d/28>
Trace; c013d032 <write_some_buffers+c2/e0>
Trace; c013d06b <write_unlocked_buffers+1b/44>
Trace; c013d1a4 <sync_all_buffers+8/3c>
Trace; c013d33f <sys_sync+f/6c>
Trace; c0108d13 <syscall_call+7/b>

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="mount.dump.ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="mount.dump.ksymoops"

ksymoops 2.4.1 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/2.5.7/System.map (specified)

Call Trace: [<c01b37f2>] [<c01b3e23>] [<c01b422a>] [<c012e0a6>] [<c01b42f6>] 
   [<c013cf65>] [<c013d032>] [<c013d06b>] [<c013d166>] [<c0141fbc>] [<c0142a66>] 
   [<c013cc1e>] [<c013b5a8>] [<c013b649>] [<c0108d13>] 

Trace; c01b37f2 <get_request_wait+8e/118>
Trace; c01b3e23 <__make_request+237/4e8>
Trace; c01b422a <generic_make_request+156/1cc>
Trace; c012e0a6 <filemap_nopage+be/208>
Trace; c01b42f6 <submit_bio+36/6c>
Trace; c013cf65 <write_locked_buffers+1d/28>
Trace; c013d032 <write_some_buffers+c2/e0>
Trace; c013d06b <write_unlocked_buffers+1b/44>
Trace; c013d166 <sync_buffers+12/48>
Trace; c0141fbc <__block_fsync+20/4c>
Trace; c0142a66 <blkdev_put+fe/118>
Trace; c013cc1e <fput+4e/e8>
Trace; c013b5a8 <filp_close+6c/b0>
Trace; c013b649 <sys_close+5d/74>
Trace; c0108d13 <syscall_call+7/b>

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9
Content-Type: text/plain;
  charset="koi8-r";
  name="kupdated.dump.ksymoops"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="kupdated.dump.ksymoops"

ksymoops 2.4.1 on i686 2.5.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.7/ (default)
     -m /boot/2.5.7/System.map (specified)

Call Trace: [<c011ef96>] [<c013cee7>] [<c017c80e>] [<c013de62>] [<c013d0e1>] 
   [<c0140100>] [<c0105000>] [<c0107172>] [<c0140030>] 

Trace; c011ef96 <__run_task_queue+5e/6c>
Trace; c013cee7 <__wait_on_buffer+57/8c>
Trace; c017c80e <nfs_write_inode+1e/24>
Trace; c013de62 <__refile_buffer+42/5c>
Trace; c013d0e1 <wait_for_buffers+4d/8c>
Trace; c0140100 <kupdate+d0/180>
Trace; c0105000 <_stext+0/0>
Trace; c0107172 <kernel_thread+26/30>
Trace; c0140030 <kupdate+0/180>

--------------Boundary-00=_XPX3FSL3BFOAQCHQJQC9--
