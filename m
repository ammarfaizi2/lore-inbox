Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269533AbUICRYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269533AbUICRYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269669AbUICRYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:24:31 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:57321 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S269533AbUICRVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 13:21:00 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm3
Date: Fri, 3 Sep 2004 14:20:43 -0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org> <200409031215.06062.norberto+linux-kernel@bensa.ath.cx> <20040903092721.6e9ec255.akpm@osdl.org>
In-Reply-To: <20040903092721.6e9ec255.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409031420.44018.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Andrew Morton wrote:
> Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
> >  Same behavior than -mm2, KDE doesn't start: hangs at kbuildsycoca or
> > kcminit with status D. No crash. No oops.
>
> When it has hung, please do:
>
>  dmesg -c
>  echo t > /proc/sysrq-trigger
>  dmesg -s 1000000 > foo

Ok, this is the output. I really hope it's usefull.

Many thanks,
Norberto


746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111828>] complete+0x1a/0x24
 [<c011f14f>] worker_thread+0x0/0x1d4
 [<c012238e>] kthread+0x6d/0x97
 [<c0122321>] kthread+0x0/0x97
 [<c01035d5>] kernel_thread_helper+0x5/0xb
xfsbufd       S 00000003     0  5248      1          5249   363 (L-TLB)
df26ffa4 00000046 c0119975 00000003 056f13a0 00000000 fffcaa8f df26ffac 
       df26ffd8 00000000 c02bd702 c039a598 c039c4f8 fffcaa8f 4b87ad6e c011a17f 
       df551550 c0399c40 c15ad410 df26f000 dc00d040 e0bb310d df26ffd8 df26ffd8 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<e0bb310d>] pagebuf_daemon+0x67/0x17f [xfs]
 [<e0bb30a6>] pagebuf_daemon+0x0/0x17f [xfs]
 [<c01035d5>] kernel_thread_helper+0x5/0xb
xfssyncd      S 00000005     0  5249      1          5539  5248 (L-TLB)
df287fb4 00000046 c0119975 00000005 05525700 00000000 fffd144e df287fbc 
       00000000 00000000 c02bd702 c039a7e8 c03ab97c fffd144e 4b87ad6e c011a17f 
       df195000 c0399c40 00000000 df287000 df49b520 e0bb761c e0bb75cb 00000000 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<e0bb761c>] xfssyncd+0x51/0xb7 [xfs]
 [<e0bb75cb>] xfssyncd+0x0/0xb7 [xfs]
 [<c01035d5>] kernel_thread_helper+0x5/0xb
acpid         S 00000202     0  5539      1          7298  5249 (NOTLB)
df4ddf34 00000086 df4c6ce0 00000202 01f128f3 00000000 00000000 7fffffff 
       df4ddfa0 dfa5b360 c02bd697 df4c6ce0 c014c73c dfa5b360 7fffffff df4ddfa0 
       dfa5b360 c014c7b2 00000002 00000000 7fffffff c014c7f2 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c014c73c>] do_pollfd+0x58/0x7f
 [<c014c7b2>] do_poll+0x4f/0xad
 [<c014c7f2>] do_poll+0x8f/0xad
 [<c014c949>] sys_poll+0x139/0x1d4
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c0104d95>] sysenter_past_esp+0x52/0x71
metalog       S 00000050     0  7298      1  7299    7775  5539 (NOTLB)
dfa29f34 00000082 dfccaac0 00000050 03fa6f1f 00000000 00000000 7fffffff 
       dfa29fa0 dfa5b600 c02bd697 df091920 c014c73c dfa5b600 7fffffff dfa29fa0 
       dfa5b600 c014c7b2 00000002 00000000 7fffffff c014c7f2 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c014c73c>] do_pollfd+0x58/0x7f
 [<c014c7b2>] do_poll+0x4f/0xad
 [<c014c7f2>] do_poll+0x8f/0xad
 [<c014c949>] sys_poll+0x139/0x1d4
 [<c0109b9e>] do_gettimeofday+0x16/0x98
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c0104d95>] sysenter_past_esp+0x52/0x71
metalog       R running     0  7299   7298                     (NOTLB)
dhcpcd        S 0000003C     0  7775      1          8116  7298 (NOTLB)
df01df68 00000082 c0119975 0000003c 02514a29 00000000 052264a6 df01df70 
       000f41a7 00015180 c02bd702 c039aa50 df34a128 052264a6 4b87ad6e c011a17f 
       df34a000 c0399c40 c011a1af 05268f50 000149a3 c011a266 000f41a7 00000000 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<c011a1af>] sys_nanosleep+0x17/0x142
 [<c011a266>] sys_nanosleep+0xce/0x142
 [<c0104d95>] sysenter_past_esp+0x52/0x71
portmap       S 00000025     0  8116      1          8130  7775 (NOTLB)
dfa28f34 00000082 dfad6560 00000025 03b23cf4 00000000 00000000 7fffffff 
       dfa28fa0 df150d80 c02bd697 dfad6560 c014c73c df150d80 7fffffff dfa28fa0 
       df150d80 c014c7b2 00000003 00000000 7fffffff c014c7f2 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c014c73c>] do_pollfd+0x58/0x7f
 [<c014c7b2>] do_poll+0x4f/0xad
 [<c014c7f2>] do_poll+0x8f/0xad
 [<c014c949>] sys_poll+0x139/0x1d4
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c0104d95>] sysenter_past_esp+0x52/0x71
rpciod/0      S 00000001     0  8129      3                5247 (L-TLB)
de8bcf68 00000046 dfa60f84 00000001 0284b289 00000000 de8bc000 df685800 
       de8bcf90 c011f14f c011f235 00000001 ffffffff ffffffff 00000001 00000000 
       c0111746 00010000 00000000 df9ab550 df9ab550 dfa60aa0 00000000 dfa60aa0 
Call Trace:
 [<c011f14f>] worker_thread+0x0/0x1d4
 [<c011f235>] worker_thread+0xe6/0x1d4
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111828>] complete+0x1a/0x24
 [<c011f14f>] worker_thread+0x0/0x1d4
 [<c012238e>] kthread+0x6d/0x97
 [<c0122321>] kthread+0x0/0x97
 [<c01035d5>] kernel_thread_helper+0x5/0xb
lockd         S 00000016     0  8130      1          8182  8116 (L-TLB)
dfa2af48 00000046 c0288f7f 00000016 0284b545 00000000 dffd9960 7fffffff 
       dfa2a000 dfa2af9c c02bd697 df6857a0 00000000 e0b1e044 df6857a0 00000000 
       df6857a0 dffd9800 00000246 dffd9960 dffd9800 e0b1f3ac 00000000 dfbe1aa0 
Call Trace:
 [<c0288f7f>] skb_recv_datagram+0x5b/0x8e
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<e0b1e044>] svc_sock_release+0xd8/0x139 [sunrpc]
 [<e0b1f3ac>] svc_recv+0x2c5/0x451 [sunrpc]
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0114a36>] reparent_to_init+0x127/0x12d
 [<e0b08b38>] lockd+0x103/0x1f8 [lockd]
 [<e0b08a35>] lockd+0x0/0x1f8 [lockd]
 [<e0b08a35>] lockd+0x0/0x1f8 [lockd]
 [<c01035d5>] kernel_thread_helper+0x5/0xb
ntpd          S 00000018     0  8182      1          8237  8130 (NOTLB)
df4cfed4 00000086 00000000 00000018 0573c903 00000000 dfb81560 7fffffff 
       00000000 00000080 c02bd697 df4cff50 dfb81560 00000000 00000145 c0284d40 
       dfb81560 df692740 df4cff50 dfb81560 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c010af5c>] restore_i387_fxsave+0x60/0x6a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c01043dc>] restore_sigcontext+0x113/0x12c
 [<c0104d95>] sysenter_past_esp+0x52/0x71
sshd          S 00000226     0  8237      1          8314  8182 (NOTLB)
dea24ed4 00000082 dffacb98 00000226 028f5c15 00000000 dfb81060 7fffffff 
       00000000 00000010 c02bd697 dfb81060 00000000 00000145 00000008 c0284d40 
       dfb81060 dffacb80 dea24f50 dfb81060 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0135452>] sys_munmap+0x31/0x4b
 [<c0104d95>] sysenter_past_esp+0x52/0x71
login         S 0000003C     0  8314      1  8437    8348  8237 (NOTLB)
df9aaf38 00000086 0000207a 0000003c 03fac185 00000000 dfbe1094 dfbe1000 
       fffffe00 00000000 c0116370 00000001 00000000 dfbe1000 c0111746 00000000 
       00000000 00000014 00000000 bfffa718 00000000 dfbe1000 c0111746 dfbe10f8 
Call Trace:
 [<c0116370>] do_wait+0x28e/0x3c6
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c011653e>] sys_wait4+0x28/0x2c
 [<c0116555>] sys_waitpid+0x13/0x17
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdm           S 0000000D     0  8348      1  8351    8386  8314 (NOTLB)
dec9fed4 00000082 000000d0 0000000d 037d1671 00000000 dfb81a60 7fffffff 
       00000000 00040000 c02bd697 df369034 dfb81a60 c0147074 dfb81a60 df7a4d20 
       dec9ff50 dfb81a60 00000000 dfb81a60 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0147074>] pipe_poll+0x23/0x62
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0104d95>] sysenter_past_esp+0x52/0x71
X             S 00000013     0  8351   8348          8352       (NOTLB)
dfb39ed4 00200086 c0119975 00000013 05752416 00000000 fffe287b dfb39edc 
       00000000 00010000 c02bd702 c039a808 c039a808 fffe287b 4b87ad6e c011a17f 
       df34aaa0 c0399c40 dfb39f50 da13e380 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c010af5c>] restore_i387_fxsave+0x60/0x6a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c019b5fa>] copy_to_user+0x2c/0x36
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdm           S 00000028     0  8352   8348  8375          8351 (NOTLB)
deea6f38 00000082 0000209c 00000028 037bc3ba 00000000 df29d5e4 df29d550 
       fffffe00 00000000 c0116370 00000001 00000000 df29d550 c0111746 00000000 
       00000000 00000000 00000000 00000000 00000000 df29d550 c0111746 df29d648 
Call Trace:
 [<c0116370>] do_wait+0x28e/0x3c6
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c011653e>] sys_wait4+0x28/0x2c
 [<c0116555>] sys_waitpid+0x13/0x17
 [<c0104d95>] sysenter_past_esp+0x52/0x71
KDE           S 00000077     0  8375   8352  8390               (NOTLB)
df52ef38 00000082 0000209c 00000077 03856adc 00000000 df415094 df415000 
       fffffe00 00000000 c0116370 00000001 00000000 df415000 c0111746 00000000 
       00000000 00000014 00000000 bffff244 00000000 df415000 c0111746 df4150f8 
Call Trace:
 [<c0116370>] do_wait+0x28e/0x3c6
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c011653e>] sys_wait4+0x28/0x2c
 [<c0116555>] sys_waitpid+0x13/0x17
 [<c0104d95>] sysenter_past_esp+0x52/0x71
imwheel       S 0000000E     0  8386      1          8389  8348 (NOTLB)
df206ed4 00000086 dffac098 0000000e 03819827 00000000 df0916a0 7fffffff 
       00000000 00000010 c02bd697 df0916a0 dffac098 df206f50 df0916a0 c0284d40 
       df0916a0 dffac080 df206f50 df0916a0 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0104d95>] sysenter_past_esp+0x52/0x71
gpg-agent     S 00000180     0  8389      1          8423  8386 (NOTLB)
daefded4 00000086 000000d0 00000180 038563d8 00000000 dfa6c240 7fffffff 
       00000000 00000040 c02bd697 dfa6c240 db8bde78 daefdf50 dfa6c240 c0284d40 
       dfa6c240 db8bde60 daefdf50 dfa6c240 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0104d95>] sysenter_past_esp+0x52/0x71
startkde      S 00000072     0  8390   8375  8424               (NOTLB)
de3cbf38 00000082 0000209c 00000072 039206d1 00000000 df9ab5e4 df9ab550 
       fffffe00 00000000 c0116370 00000001 00000000 df9ab550 c0111746 00000000 
       00000000 00000014 00000000 bffff1d4 00000000 df9ab550 c0111746 df9ab648 
Call Trace:
 [<c0116370>] do_wait+0x28e/0x3c6
 [<c0111746>] default_wake_function+0x0/0x12
 [<c0111746>] default_wake_function+0x0/0x12
 [<c011653e>] sys_wait4+0x28/0x2c
 [<c0116555>] sys_waitpid+0x13/0x17
 [<c0104d95>] sysenter_past_esp+0x52/0x71
ksplash       S 00000012     0  8423      1          8428  8389 (NOTLB)
db1b4ed4 00200082 c0119975 00000012 05794c41 00000000 fffca987 db1b4edc 
       00000000 00000200 c02bd702 db7a9edc c039a080 fffca987 4b87ad6e c011a17f 
       df415aa0 c0399c40 db1b4f50 df8cf880 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c019b5fa>] copy_to_user+0x2c/0x36
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdeinit       S 0000001F     0  8424   8390  8425               (NOTLB)
dc7d3ed8 00200082 df9ed080 0000001f 039c006e 00000000 dcb02dc8 dcb02d58 
       dc7d3f00 00000001 c0146a93 00000000 df195aa0 c01226b1 dc7d3f0c dc7d3f0c 
       df4b6bf4 08051ae0 00000001 00000000 df195aa0 c01226b1 df7a4760 df7a4760 
Call Trace:
 [<c0146a93>] pipe_wait+0x7b/0x9a
 [<c01226b1>] autoremove_wake_function+0x0/0x3a
 [<c01226b1>] autoremove_wake_function+0x0/0x3a
 [<c0146c82>] pipe_readv+0x1d0/0x252
 [<c0146d29>] pipe_read+0x25/0x29
 [<c013dda0>] vfs_read+0xaf/0xd9
 [<c013dfb2>] sys_read+0x3b/0x63
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdeinit       S 0000000C     0  8425   8424  8430               (NOTLB)
dbbabed4 00200086 000000d0 0000000c 0406c564 00000000 df9eb4c0 7fffffff 
       00000000 00000400 c02bd697 df9eb4c0 daf72658 dbbabf50 df9eb4c0 c0284d40 
       df9eb4c0 daf72640 dbbabf50 df9eb4c0 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0116555>] sys_waitpid+0x13/0x17
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdeinit       S 00000002     0  8428      1          8433  8423 (NOTLB)
dae56ed4 00200082 000000d0 00000002 0406c54b 00000000 dfad61a0 7fffffff 
       00000000 00004000 c02bd697 dfad61a0 daf724f8 dae56f50 dfad61a0 c0284d40 
       dfad61a0 daf724e0 00000000 dfad61a0 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c014b3d7>] sys_fcntl64+0x79/0x80
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdeinit       S 00000001     0  8430   8425          8443       (NOTLB)
da6f7ed4 00200086 db8bd0b8 00000001 0406c558 00000000 dfb81420 7fffffff 
       00000000 00000800 c02bd697 dfb81420 db8bd4d8 da6f7f50 dfb81420 c0284d40 
       dfb81420 db8bd4c0 00000000 dfb81420 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c02bd697>] schedule_timeout+0x13/0x9b
 [<c0284d40>] sock_poll+0x19/0x1d
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c0104d95>] sysenter_past_esp+0x52/0x71
kdeinit       S 00000015     0  8433      1                8428 (NOTLB)
db7a9ed4 00200086 c0119975 00000015 05794c56 00000000 fffca987 db7a9edc 
       00000000 00002000 c02bd702 c039a080 db1b4edc fffca987 4b87ad6e c011a17f 
       c1588aa0 c0399c40 db7a9f50 dac64600 00000000 c014c25f 00000000 00000000 
Call Trace:
 [<c0119975>] __mod_timer+0x77/0x88
 [<c02bd702>] schedule_timeout+0x7e/0x9b
 [<c011a17f>] process_timeout+0x0/0x9
 [<c014c25f>] do_select+0x244/0x27b
 [<c014bebf>] __pollwait+0x0/0x9a
 [<c01057e6>] apic_timer_interrupt+0x1a/0x20
 [<c014c5ab>] sys_select+0x2fd/0x436
 [<c019b5fa>] copy_to_user+0x2c/0x36
 [<c0104d95>] sysenter_past_esp+0x52/0x71
bash          R running     0  8437   8314                     (NOTLB)
kdeinit       D 00000040     0  8443   8425                8430 (NOTLB)
dae43da4 00200086 00000000 00000040 04087dcc 00000000 db0f55dc dfa58aa0 
       00200246 00001000 c02bce1d 00000001 dfa58aa0 c0111746 db0f55e4 db0f55e4 
       00000000 00000000 00000fff db0f55dc db0f560c db0f556c c02bcf90 db0f55dc 
Call Trace:
 [<c02bce1d>] __down+0x6d/0xd5
 [<c0111746>] default_wake_function+0x0/0x12
 [<c02bcf90>] __down_failed+0x8/0xc
 [<c0129c92>] .text.lock.filemap+0x5/0x53
 [<e0bb6fc1>] xfs_write+0x7cd/0x814 [xfs]
 [<e0bb3621>] linvfs_write+0x7a/0x82 [xfs]
 [<c013de73>] do_sync_write+0xa9/0xd4
 [<c010ffe3>] do_page_fault+0x193/0x4cd
 [<c0134017>] vma_link+0x1d/0x7d
 [<c01226b1>] autoremove_wake_function+0x0/0x3a
 [<c0134bba>] do_mmap_pgoff+0x59a/0x603
 [<c013df4d>] vfs_write+0xaf/0xd9
 [<c013e015>] sys_write+0x3b/0x63
 [<c0104d95>] sysenter_past_esp+0x52/0x71
