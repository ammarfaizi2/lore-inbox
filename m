Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSA3Q6g>; Wed, 30 Jan 2002 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSA3Q5Y>; Wed, 30 Jan 2002 11:57:24 -0500
Received: from fw.tnt.de ([194.55.63.2]:3640 "EHLO dbtest.intra.tnt.de")
	by vger.kernel.org with ESMTP id <S290078AbSA3Qz4>;
	Wed, 30 Jan 2002 11:55:56 -0500
Message-Id: <200201301655.g0UGtpH04353@pcchk.intra.tnt.de>
Content-Type: text/plain; charset=US-ASCII
From: Michael May <michael.may@tnt.de>
Reply-To: michael.may@tnt.de
Organization: tnt
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Memory II
Date: Wed, 30 Jan 2002 17:55:50 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Hopefully intersting, just after writing the last message it is happend again:
Here are nor some outputs:

ps xa:
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:45 init [3]  
    2 ?        SW     0:42 [keventd]
    3 ?        SWN    0:00 [ksoftirqd_CPU0]
    4 ?        SWN    0:00 [ksoftirqd_CPU1]
    5 ?        SW     8:22 [kswapd]
    6 ?        SW     0:00 [bdflush]
    7 ?        SW     0:41 [kupdated]
  228 ?        S      0:01 /usr/sbin/sshd
  244 ?        S      0:03 /sbin/syslogd
  247 ?        S      0:03 /sbin/klogd -c 1
  264 ?        S      0:00 /usr/sbin/lpd
  277 ?        S      0:00 /sbin/rpc.statd
  288 ?        SW     0:35 [rpciod]
  289 ?        SW     0:00 [lockd]
  307 ?        S      0:08 /sbin/portmap
  340 ?        S      8:25 /usr/sbin/ypserv
  354 ?        S      0:00 /usr/sbin/atd
  464 ?        S      0:24 sendmail: accepting connections 
  491 ?        SL     0:18 /usr/sbin/ntpd
  506 ?        S      0:00 /usr/sbin/rpc.yppasswdd -D /etc
  537 ?        S      0:05 /usr/sbin/lisa -c /etc/lisarc
  628 ?        S      0:01 /bin/sh /usr/bin/safe_mysqld --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --socket=/var/lib/mysql/mysql.sock --datadir=/var/lib/mysql
  693 ?        S      0:03 /usr/sbin/cron
  717 ?        S      0:00 /usr/sbin/ypbind
  718 ?        S      0:03 /usr/sbin/ypbind
  719 ?        S      0:00 /usr/sbin/ypbind
  720 ?        S      0:10 /usr/sbin/ypbind
  753 ?        S      0:06 /usr/sbin/gpm -t ps2 -m /dev/mouse
  767 ?        S      0:00 /usr/sbin/inetd
  792 ?        S      0:02 /opt/apache/bin/httpd -DSSL -f /etc/httpd/httpd.conf # Example: # LoadModule foo_module libexec/mod_foo.so LoadModule vhost_alias_module libexec/mod_vhost_alias.so LoadModule env_module libexec/mod_env.so LoadModule define_module libexec/mod_define.so LoadModule config_log_module libexec/mod_log_config.so LoadModule mime_magic_module libexec/mod_mime_magic.so LoadModule mime_module libexec/mod_mime.so LoadModule negotiation_module libexec/mod_negotiation.so LoadModule status_module libexec/mod_status.so LoadModule info_module libexec/mod_info.so LoadModule includes_module libexec/mod_include.so LoadModule autoindex_module libexec/mod_autoindex.so LoadModule dir_module libexec/mod_dir.so LoadModule cgi_module libexec/mod_cgi.so LoadModule asis_module libexec/mod_asis.so LoadModule imap_module libexec/mod_imap.so LoadModule action_module libexec/mod_actions.so LoadModule speling_module libexec/mod_speling.so LoadModule userdir_module libexec/mod_user!
 dir.so LoadModule alias_module libexec/mod_alias.so LoadModule rewrite_module libexec/mod_rewrite.so LoadModule access_module libexec/mod_access.so LoadModule auth_module libexec/mod_auth.so LoadModule anon_auth_module libexec/mod_auth_anon.so LoadModule dbm_auth_module libexec/mod_auth_dbm.so LoadModule digest_module libexec/mod_digest.so LoadModule proxy_module libexec/libproxy.so LoadModule cern_meta_module libexec/mod_cern_meta.so LoadModule expires_module libexec/mod_expires.so LoadModule headers_module libexec/mod_headers.so LoadModule usertrack_module libexec/mod_usertrack.so LoadModule unique_id_module libexec/mod_unique_id.so LoadModule setenvif_module libexec/mod_setenvif.so <IfDefine SSL> LoadModule ssl_module libexec/libssl.so </IfDefine> # Reconstruction of the complete module list from all available modules # (static and shared ones) to achieve correct module execution order. # [WHENEVER YOU CHANGE THE LOADMODULE SECTION ABOVE UPDATE THIS, TOO] ClearModuleList!
  AddModule mod_vhost_alias.c AddModule mod_env.c AddModule mod_define.
c AddModule mod_log_config.c AddModule mod_mime_magic.c AddModule mod_mime.c AddModule mod_negotiation.c AddModule mod_status.c AddModule mod_info.c AddModule mod_include.c AddModule mod_autoindex.c AddModule mod_dir.c AddModule mod_cgi.c AddModule mod_asis.c AddModule mod_imap.c AddModule mod_actions.c AddModule mod_speling.c AddModule mod_userdir.c AddModule mod_alias.c AddModule mod_rewrite.c AddModule mod_access.c AddModule mod_auth.c AddModule mod_auth_anon.c AddModule mod_auth_dbm.c AddModule mod_digest.c AddModule mod_proxy.c AddModule mod_cern_meta.c AddModule mod_expires.c AddModule mod_headers.c AddModule mod_usertrack.c AddModule mod_unique_id.c AddModule mod_so.c AddModule mod_setenvif.c <IfDefine SSL> AddModule mod_ssl.c </IfDefine>
  793 ?        S      0:02 /opt/apache/bin/httpd -DSSL -f /etc/httpd/httpd.conf # Example: # LoadModule foo_module libexec/mod_foo.so LoadModule vhost_alias_module libexec/mod_vhost_alias.so LoadModule env_module libexec/mod_env.so LoadModule define_module libexec/mod_define.so LoadModule config_log_module libexec/mod_log_config.so LoadModule mime_magic_module libexec/mod_mime_magic.so LoadModule mime_module libexec/mod_mime.so LoadModule negotiation_module libexec/mod_negotiation.so LoadModule status_module libexec/mod_status.so LoadModule info_module libexec/mod_info.so LoadModule includes_module libexec/mod_include.so LoadModule autoindex_module libexec/mod_autoindex.so LoadModule dir_module libexec/mod_dir.so LoadModule cgi_module libexec/mod_cgi.so LoadModule asis_module libexec/mod_asis.so LoadModule imap_module libexec/mod_imap.so LoadModule action_module libexec/mod_actions.so LoadModule speling_module libexec/mod_speling.so LoadModule userdir_module libexec/mod_user!
 dir.so LoadModule alias_module libexec/mod_alias.so LoadModule rewrite_module libexec/mod_rewrite.so LoadModule access_module libexec/mod_access.so LoadModule auth_module libexec/mod_auth.so LoadModule anon_auth_module libexec/mod_auth_anon.so LoadModule dbm_auth_module libexec/mod_auth_dbm.so LoadModule digest_module libexec/mod_digest.so LoadModule proxy_module libexec/libproxy.so LoadModule cern_meta_module libexec/mod_cern_meta.so LoadModule expires_module libexec/mod_expires.so LoadModule headers_module libexec/mod_headers.so LoadModule usertrack_module libexec/mod_usertrack.so LoadModule unique_id_module libexec/mod_unique_id.so LoadModule setenvif_module libexec/mod_setenvif.so <IfDefine SSL> LoadModule ssl_module libexec/libssl.so </IfDefine> # Reconstruction of the complete module list from all available modules # (static and shared ones) to achieve correct module execution order. # [WHENEVER YOU CHANGE THE LOADMODULE SECTION ABOVE UPDATE THIS, TOO] ClearModuleList!
  AddModule mod_vhost_alias.c AddModule mod_env.c AddModule mod_define.
c AddModule mod_log_config.c AddModule mod_mime_magic.c AddModule mod_mime.c AddModule mod_negotiation.c AddModule mod_status.c AddModule mod_info.c AddModule mod_include.c AddModule mod_autoindex.c AddModule mod_dir.c AddModule mod_cgi.c AddModule mod_asis.c AddModule mod_imap.c AddModule mod_actions.c AddModule mod_speling.c AddModule mod_userdir.c AddModule mod_alias.c AddModule mod_rewrite.c AddModule mod_access.c AddModule mod_auth.c AddModule mod_auth_anon.c AddModule mod_auth_dbm.c AddModule mod_digest.c AddModule mod_proxy.c AddModule mod_cern_meta.c AddModule mod_expires.c AddModule mod_headers.c AddModule mod_usertrack.c AddModule mod_unique_id.c AddModule mod_so.c AddModule mod_setenvif.c <IfDefine SSL> AddModule mod_ssl.c </IfDefine>
  795 ?        S      0:00 /opt/apache/bin/httpd -DSSL -f /etc/httpd/httpd.conf # Example: # LoadModule foo_module libexec/mod_foo.so LoadModule vhost_alias_module libexec/mod_vhost_alias.so LoadModule env_module libexec/mod_env.so LoadModule define_module libexec/mod_define.so LoadModule config_log_module libexec/mod_log_config.so LoadModule mime_magic_module libexec/mod_mime_magic.so LoadModule mime_module libexec/mod_mime.so LoadModule negotiation_module libexec/mod_negotiation.so LoadModule status_module libexec/mod_status.so LoadModule info_module libexec/mod_info.so LoadModule includes_module libexec/mod_include.so LoadModule autoindex_module libexec/mod_autoindex.so LoadModule dir_module libexec/mod_dir.so LoadModule cgi_module libexec/mod_cgi.so LoadModule asis_module libexec/mod_asis.so LoadModule imap_module libexec/mod_imap.so LoadModule action_module libexec/mod_actions.so LoadModule speling_module libexec/mod_speling.so LoadModule userdir_module libexec/mod_user!
 dir.so LoadModule alias_module libexec/mod_alias.so LoadModule rewrite_module libexec/mod_rewrite.so LoadModule access_module libexec/mod_access.so LoadModule auth_module libexec/mod_auth.so LoadModule anon_auth_module libexec/mod_auth_anon.so LoadModule dbm_auth_module libexec/mod_auth_dbm.so LoadModule digest_module libexec/mod_digest.so LoadModule proxy_module libexec/libproxy.so LoadModule cern_meta_module libexec/mod_cern_meta.so LoadModule expires_module libexec/mod_expires.so LoadModule headers_module libexec/mod_headers.so LoadModule usertrack_module libexec/mod_usertrack.so LoadModule unique_id_module libexec/mod_unique_id.so LoadModule setenvif_module libexec/mod_setenvif.so <IfDefine SSL> LoadModule ssl_module libexec/libssl.so </IfDefine> # Reconstruction of the complete module list from all available modules # (static and shared ones) to achieve correct module execution order. # [WHENEVER YOU CHANGE THE LOADMODULE SECTION ABOVE UPDATE THIS, TOO] ClearModuleList!
  AddModule mod_vhost_alias.c AddModule mod_env.c AddModule mod_define.
c AddModule mod_log_config.c AddModule mod_mime_magic.c AddModule mod_mime.c AddModule mod_negotiation.c AddModule mod_status.c AddModule mod_info.c AddModule mod_include.c AddModule mod_autoindex.c AddModule mod_dir.c AddModule mod_cgi.c AddModule mod_asis.c AddModule mod_imap.c AddModule mod_actions.c AddModule mod_speling.c AddModule mod_userdir.c AddModule mod_alias.c AddModule mod_rewrite.c AddModule mod_access.c AddModule mod_auth.c AddModule mod_auth_anon.c AddModule mod_auth_dbm.c AddModule mod_digest.c AddModule mod_proxy.c AddModule mod_cern_meta.c AddModule mod_expires.c AddModule mod_headers.c AddModule mod_usertrack.c AddModule mod_unique_id.c AddModule mod_so.c AddModule mod_setenvif.c <IfDefine SSL> AddModule mod_ssl.c </IfDefine>
  880 tty9     S      0:00 /sbin/mingetty tty9
  881 tty10    S      0:00 /sbin/mingetty tty10
  882 tty11    S      0:00 /sbin/mingetty tty11
  883 tty12    S      0:00 /sbin/mingetty tty12
  884 tty14    S      0:00 /sbin/mingetty tty14
  885 tty15    S      0:00 /sbin/mingetty tty15
  886 tty16    S      0:00 /sbin/mingetty tty16
  887 tty17    S      0:00 /sbin/mingetty tty17
  888 tty18    S      0:00 /sbin/mingetty tty18
  889 tty19    S      0:00 /sbin/mingetty tty19
  890 tty20    S      0:00 /sbin/mingetty tty20
  891 tty21    S      0:00 /sbin/mingetty tty21
  892 tty22    S      0:00 /sbin/mingetty tty22
  893 tty23    S      0:00 /sbin/mingetty tty23
  894 tty24    S      0:00 /sbin/mingetty tty24
 8297 ?        S      0:15 /bin/bash /usr/local/sbin/update_passwd -D
24053 tty8     S      0:00 /sbin/mingetty tty8
25577 ttyS1    S      0:00 /sbin/agetty -L 38400 ttyS1 vt100
 1597 ?        S      0:01 /opt/apache/bin/httpd -DSSL -f /etc/httpd/httpd.conf # Example: # LoadModule foo_module libexec/mod_foo.so LoadModule vhost_alias_module libexec/mod_vhost_alias.so LoadModule env_module libexec/mod_env.so LoadModule define_module libexec/mod_define.so LoadModule config_log_module libexec/mod_log_config.so LoadModule mime_magic_module libexec/mod_mime_magic.so LoadModule mime_module libexec/mod_mime.so LoadModule negotiation_module libexec/mod_negotiation.so LoadModule status_module libexec/mod_status.so LoadModule info_module libexec/mod_info.so LoadModule includes_module libexec/mod_include.so LoadModule autoindex_module libexec/mod_autoindex.so LoadModule dir_module libexec/mod_dir.so LoadModule cgi_module libexec/mod_cgi.so LoadModule asis_module libexec/mod_asis.so LoadModule imap_module libexec/mod_imap.so LoadModule action_module libexec/mod_actions.so LoadModule speling_module libexec/mod_speling.so LoadModule userdir_module libexec/mod_user!
 dir.so LoadModule alias_module libexec/mod_alias.so LoadModule rewrite_module libexec/mod_rewrite.so LoadModule access_module libexec/mod_access.so LoadModule auth_module libexec/mod_auth.so LoadModule anon_auth_module libexec/mod_auth_anon.so LoadModule dbm_auth_module libexec/mod_auth_dbm.so LoadModule digest_module libexec/mod_digest.so LoadModule proxy_module libexec/libproxy.so LoadModule cern_meta_module libexec/mod_cern_meta.so LoadModule expires_module libexec/mod_expires.so LoadModule headers_module libexec/mod_headers.so LoadModule usertrack_module libexec/mod_usertrack.so LoadModule unique_id_module libexec/mod_unique_id.so LoadModule setenvif_module libexec/mod_setenvif.so <IfDefine SSL> LoadModule ssl_module libexec/libssl.so </IfDefine> # Reconstruction of the complete module list from all available modules # (static and shared ones) to achieve correct module execution order. # [WHENEVER YOU CHANGE THE LOADMODULE SECTION ABOVE UPDATE THIS, TOO] ClearModuleList!
  AddModule mod_vhost_alias.c AddModule mod_env.c AddModule mod_define.
c AddModule mod_log_config.c AddModule mod_mime_magic.c AddModule mod_mime.c AddModule mod_negotiation.c AddModule mod_status.c AddModule mod_info.c AddModule mod_include.c AddModule mod_autoindex.c AddModule mod_dir.c AddModule mod_cgi.c AddModule mod_asis.c AddModule mod_imap.c AddModule mod_actions.c AddModule mod_speling.c AddModule mod_userdir.c AddModule mod_alias.c AddModule mod_rewrite.c AddModule mod_access.c AddModule mod_auth.c AddModule mod_auth_anon.c AddModule mod_auth_dbm.c AddModule mod_digest.c AddModule mod_proxy.c AddModule mod_cern_meta.c AddModule mod_expires.c AddModule mod_headers.c AddModule mod_usertrack.c AddModule mod_unique_id.c AddModule mod_so.c AddModule mod_setenvif.c <IfDefine SSL> AddModule mod_ssl.c </IfDefine>
16097 tty6     S      0:00 login -- micha     
16109 tty4     S      0:00 login -- root     
16114 tty3     S      0:00 login -- root     
16810 tty2     S      0:00 login -- root     
18525 tty2     S      0:00 -bash
18951 tty4     S      0:00 -bash
19416 tty3     S      0:01 -bash
20358 tty6     S      0:01 -bash
 6780 tty5     S      0:00 login -- root     
 6867 tty5     S      0:00 -bash
31562 ?        Z      0:00 [lisa <defunct>]
21016 tty1     S      0:00 login -- root     
21029 tty1     S      0:00 -bash
 5398 tty4     S      0:03 ssh pcchk
 5399 ?        S      0:00 /usr/sbin/sshd
 5400 pts/1    S      0:00 -bash
16712 ?        Z      0:02 [lisa <defunct>]
18121 tty6     S      0:00 -bash
18122 tty6     S      0:00 /bin/sh /usr/X11R6/bin/startx
18123 tty6     S      0:01 tee /home/micha/.X.err
18135 tty6     S      0:00 xinit /home/micha/.xinitrc -- /usr/X11R6/lib/X11/xinit/xserverrc -auth /home/micha/.Xauthority
18136 ?        S      1:26 X :0 -auth /home/micha/.Xauthority -auth /home/micha/.Xauthority
18200 tty6     S      0:00 /bin/bash --login /usr/X11R6/bin/kde
18878 ?        S      0:00 kdeinit: Running...
18881 ?        S      0:00 kdeinit: dcopserver --nosid
18884 ?        S      0:00 kdeinit: klauncher
18886 ?        S      0:08 kdeinit: kded   
18972 tty6     S      0:00 knotify
18973 tty6     S      0:00 ksmserver --restore
19029 ?        S      0:01 kdeinit: kwin -session 11c23737b9000099842286600000160850000
19031 ?        S      0:05 kdeinit: kdesktop
19035 ?        S      0:05 kdeinit: kicker 
19093 ?        S      0:02 kdeinit: klipper -icon klipper -miniicon klipper
19095 ?        S      0:00 kdeinit: kwrited
19097 pts/2    S      0:00 /bin/cat
19098 ?        S      0:03 amor -session 11c23737b9000100228632800000130200030
23948 ?        S      0:00 kdeinit: kcookiejar
23950 ?        S      0:00 kdesud
24295 ?        S      0:00 kdeinit: kio_uiserver
32664 ?        S      0:00 /USR/SBIN/CRON
32665 ?        S      0:00 /bin/sh -c /usr/local/bin/create_stat_report 2>/dev/null
32666 ?        S      0:00 /bin/bash /usr/local/bin/create_stat_report
 1761 ?        S      0:00 /usr/sbin/mysqld-max --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
 1764 ?        S      0:00 sleep 60
 1765 ?        S      0:00 /usr/sbin/mysqld-max --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
 1766 ?        S      0:00 /usr/sbin/mysqld-max --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
 1767 ?        S      0:00 /usr/sbin/mysqld-max --basedir=/usr --datadir=/var/lib/mysql --user=mysql --pid-file=/var/lib/mysql/mysqld.pid --skip-locking
 2391 ?        S      0:00 /bin/bash /usr/local/bin/create_stat_report
 2392 ?        S      0:00 ping -c 5 -w 2 -s 2064 dbchain.intra.tnt.de
 2393 ?        S      0:00 tail -n1
 2394 ?        S      0:00 cut -f2 -d =
 2395 ?        S      0:00 cut -f2 -d /
 2396 ?        S      0:00 awk {print int($1*1000)}
 2397 tty3     R      0:00 ps xa


(this commands was entered with ca. 5 secs.)
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    239328     16548 kB
 swap:     273088     98276    174812 kB
 Sum:      528964    337604    191360 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    244928     10948 kB
 swap:     273088    123084    150004 kB
 Sum:      528964    368012    160952 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246536      9340 kB
 swap:     273088    149512    123576 kB
 Sum:      528964    396048    132916 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246588      9288 kB
 swap:     273088    189700     83388 kB
 Sum:      528964    436288     92676 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246320      9556 kB
 swap:     273088    219916     53172 kB
 Sum:      528964    466236     62728 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246940      8936 kB
 swap:     273088    254528     18560 kB
 Sum:      528964    501468     27496 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246004      9872 kB
 swap:     273088    273088         0 kB
 Sum:      528964    519092      9872 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876    246264      9612 kB
 swap:     273088    273088         0 kB
 Sum:      528964    519352      9612 kB
pcchk:~ # mem
 Mem:       total      used      free
 phys:     255876     20172    235704 kB
 swap:     273088     39400    233688 kB
 Sum:      528964     59572    469392 kB

dmesg:

...
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: HP       Product ID: E 800        APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #1 Version 17 at 0xFEC00000.
I/O APIC #2 Version 17 at 0xFEC01000.
Processors: 2
Kernel command line: auto BOOT_IMAGE=SKernel0 ro root=803 BOOT_FILE=/boot/SKernel0
Initializing CPU#0
Detected 866.741 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1730.15 BogoMIPS
Memory: 255624k/262080k available (999k kernel code, 6068k reserved, 297k data, 252k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.68 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1730.15 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (3460.30 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 1 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 1 ... ok.
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0, 1-5, 1-9, 1-10, 1-11, 2-1, 2-3, 2-4, 2-5, 2-6, 2-7, 2-10, 2-11, 2-12, 2-13, 2-14, 2-15 not connected.
..TIMER: vector=0x31 pin1=-1 pin2=0
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ...works.
number of MP IRQ sources: 17.
number of IO-APIC #1 registers: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    1    1    31
 01 003 03  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 003 03  0    0    0   0   0    1    1    71
 0e 003 03  0    0    0   0   0    1    1    79
 0f 003 03  0    0    0   0   0    1    1    81

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 0C000000
.......     : arbitration: 0C
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    89
 01 000 00  1    0    0   0   0    0    0    00
 02 003 03  1    1    0   1   0    1    1    91
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  1    1    0   1   0    1    1    99
 09 003 03  1    1    0   1   0    1    1    A1
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ1 -> 0:1
IRQ2 -> 0:2
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 1:0
IRQ18 -> 1:2
IRQ24 -> 1:8
IRQ25 -> 1:9
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 866.7427 MHz.
..... host bus clock speed is 133.3448 MHz.
cpu: 0, clocks: 1333448, slice: 444482
CPU0<T0:1333440,T1:888944,D:14,S:444482,C:1333448>
cpu: 1, clocks: 1333448, slice: 444482
CPU1<T0:1333440,T1:444464,D:12,S:444482,C:1333448>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 05 [IRQ]
PCI->APIC IRQ transform: (B0,I3,P0) -> 16
PCI->APIC IRQ transform: (B0,I5,P0) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 33
PCI->APIC IRQ transform: (B5,I5,P0) -> 24
PCI->APIC IRQ transform: (B5,I5,P1) -> 25
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
vesafb: framebuffer at 0xfc000000, mapped to 0xd0800000, size 4096k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:4dc8
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:5:5, shift=0:10:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:pio
hda: LTN486S, ATAPI CD/DVD-ROM drive
hdc: no response (status = 0xa1), resetting drive
hdc: no response (status = 0xa1)
hdd: no response (status = 0xa1), resetting drive
hdd: no response (status = 0xa1)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 5, device 5, function 0
sym53c8xx: 53c896 detected with Symbios NVRAM
sym53c8xx: at PCI bus 5, device 5, function 1
sym53c8xx: 53c896 detected with Symbios NVRAM
sym53c896-0: rev 0x7 on pci bus 5 device 5 function 0 irq 24
sym53c896-0: Symbios format NVRAM, ID 7, Fast-40, Parity Checking
sym53c896-0: on-chip RAM at 0xfd020000
sym53c896-0: restart (scsi reset).
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-0: Downloading SCSI SCRIPTS.
sym53c896-1: rev 0x7 on pci bus 5 device 5 function 1 irq 25
sym53c896-1: Symbios format NVRAM, ID 7, Fast-40, Parity Checking
sym53c896-1: on-chip RAM at 0xfd024000
sym53c896-1: restart (scsi reset).
sym53c896-1: handling phase mismatch from SCRIPTS.
sym53c896-1: Downloading SCSI SCRIPTS.
scsi0 : sym53c8xx-1.7.3c-20010512
scsi1 : sym53c8xx-1.7.3c-20010512
  Vendor: HP        Model: 9.10GB C 68-D94N  Rev: D94N
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: HP        Model: 9.10GB C 68-CX03  Rev: CX03
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: HP        Model: C5683A            Rev: C005
  Type:   Sequential-Access                  ANSI SCSI revision: 02
sym53c896-0-<0,0>: tagged command queue depth set to 4
sym53c896-0-<3,0>: tagged command queue depth set to 4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
sym53c896-0-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 31)
SCSI device sda: 17773524 512-byte hdwr sectors (9100 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 >
sym53c896-0-<3,*>: FAST-40 WIDE SCSI 80.0 MB/s (25.0 ns, offset 31)
SCSI device sdb: 17773524 512-byte hdwr sectors (9100 MB)
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 252k freed
LVM version 1.0.1-rc4(ish)(03/10/2001) module loaded
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
invalidate: busy buffer
Adding Swap: 136544k swap-space (priority 1)
Adding Swap: 136544k swap-space (priority 1)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:05.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1800. Vers LK1.1.16
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 2977 (makedbm).
Out of Memory: Killed process 2977 (makedbm).
Out of Memory: Killed process 8828 (makedbm).
Out of Memory: Killed process 21507 (makedbm).
Out of Memory: Killed process 31108 (makedbm).
Out of Memory: Killed process 31108 (makedbm).
Out of Memory: Killed process 31108 (makedbm).
Out of Memory: Killed process 1581 (makedbm).
Out of Memory: Killed process 13325 (makedbm).
Out of Memory: Killed process 28140 (makedbm).
Out of Memory: Killed process 28140 (makedbm).
Out of Memory: Killed process 10140 (makedbm).
Out of Memory: Killed process 9056 (makedbm).
Out of Memory: Killed process 16212 (makedbm).
Out of Memory: Killed process 16246 (makedbm).
Out of Memory: Killed process 5415 (makedbm).
Out of Memory: Killed process 7655 (makedbm).
Out of Memory: Killed process 15149 (makedbm).
Out of Memory: Killed process 15149 (makedbm).
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 22390 (makedbm).
Out of Memory: Killed process 27801 (makedbm).
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 26199 (makedbm).
Out of Memory: Killed process 17190 (makedbm).
Out of Memory: Killed process 31606 (makedbm).
Out of Memory: Killed process 18059 (makedbm).
Out of Memory: Killed process 30056 (makedbm).
Out of Memory: Killed process 30056 (makedbm).
Out of Memory: Killed process 31102 (makedbm).
Out of Memory: Killed process 31552 (makedbm).
Out of Memory: Killed process 15743 (makedbm).
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 2567 (makedbm).
Out of Memory: Killed process 2567 (makedbm).
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 10939 (knode).
Out of Memory: Killed process 10940 (knode).
Out of Memory: Killed process 10941 (knode).
Out of Memory: Killed process 10942 (knode).
Out of Memory: Killed process 16026 (kdeinit).
Out of Memory: Killed process 9668 (kdeinit).
Out of Memory: Killed process 9664 (kdeinit).
Out of Memory: Killed process 9630 (kdeinit).
Out of Memory: Killed process 9671 (kdeinit).
Out of Memory: Killed process 16504 (konsole).
Out of Memory: Killed process 9628 (kdeinit).
Out of Memory: Killed process 9651 (kdeinit).
Out of Memory: Killed process 15405 (kdeinit).
Out of Memory: Killed process 9673 (kdeinit).
Out of Memory: Killed process 15375 (kdeinit).
Out of Memory: Killed process 9639 (knotify).
Out of Memory: Killed process 9625 (kdeinit).
Out of Memory: Killed process 661 (mysqld-max).
Out of Memory: Killed process 663 (mysqld-max).
Out of Memory: Killed process 664 (mysqld-max).
Out of Memory: Killed process 665 (mysqld-max).
Out of Memory: Killed process 31562 (lisa).
Out of Memory: Killed process 16712 (lisa).
Out of Memory: Killed process 15377 (kdesud).
Out of Memory: Killed process 16684 (makedbm).
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
mtrr: Serverworks LE detected. Write-combining disabled.
mtrr: your processor doesn't support write-combining
Out of Memory: Killed process 16724 (mysqld-max).
Out of Memory: Killed process 16732 (mysqld-max).
Out of Memory: Killed process 16733 (mysqld-max).
Out of Memory: Killed process 16739 (mysqld-max).
Out of Memory: Killed process 29390 (makedbm).
Out of Memory: Killed process 29432 (mysqld-max).
Out of Memory: Killed process 29442 (mysqld-max).
Out of Memory: Killed process 29443 (mysqld-max).
Out of Memory: Killed process 29444 (mysqld-max).
Out of Memory: Killed process 32678 (makedbm).

Hope it is useful for you.

-----------------------------------
Michael May - UNIX-Administration
+49/2241/497-2742
-----------------------------------
