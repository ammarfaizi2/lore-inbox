Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbTAYTLu>; Sat, 25 Jan 2003 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTAYTLu>; Sat, 25 Jan 2003 14:11:50 -0500
Received: from adsl-17-210-74.mia.bellsouth.net ([68.17.210.74]:64592 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S261854AbTAYTLd>;
	Sat, 25 Jan 2003 14:11:33 -0500
Date: Sat, 25 Jan 2003 14:39:39 -0500
To: linux-kernel@vger.kernel.org
Subject: Mozilla stalls in 2.4.21-pre3
Message-ID: <20030125193939.GA29910@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When playing an mp3 with xmms and using mozilla, sometimes when I click
on a link, mozilla stalls.  When I stop the mp3, the page finally loads.
Let me know if you need any more information. TIA.

My kernel is 2.4.21-pre3.

My soundcard uses es1371.
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xe400 [0xe43f].

Below is a SysRq+T run through ksymoops.

ksymoops 2.4.8 on i686 2.4.21-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3/ (default)
     -m /boot/System.map-2.4.21-pre3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
init          S C0278894  4636     1      0   474               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c0116b38>] [<c0133bb5>] [<c0116ac0>] [<c01439f7>] [<c014999d>]
  [<c0149e3e>] [<c0141a49>] [<c010740f>]
keventd       S 00200296  6056     2      1             3       (L-TLB)
Call Trace:    [<c019cfdc>] [<c012747d>] [<c0127370>] [<c0105000>] [<c010577e>]
  [<c0127370>]
ksoftirqd_CPU S C0105000  6404     3      1             4     2 (L-TLB)
Call Trace:    [<c0105000>] [<c011e646>] [<c011e8fe>] [<c0105000>] [<c010577e>]
  [<c011e880>]
kswapd        S C139E360  5708     4      1             5     3 (L-TLB)
Call Trace:    [<c0132c56>] [<c0105000>] [<c010577e>] [<c0132bd0>]
bdflush       S 00000000  6624     5      1             6     4 (L-TLB)
Call Trace:    [<c0117148>] [<c013e8aa>] [<c0105000>] [<c010577e>] [<c013e7e0>]
kupdated      S CFA6C000  5984     6      1             8     5 (L-TLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c013e94c>] [<c0105000>] [<c0105000>]
  [<c010577e>] [<c013e8c0>]
khubd         S 00000202  5672     8      1            12     6 (L-TLB)
Call Trace:    [<c01e8bbe>] [<c0105000>] [<c010577e>] [<c01e8b20>]
kjournald     S CEAFD3C0  5424    12      1            75     8 (L-TLB)
Call Trace:    [<c0117148>] [<c01755f1>] [<c0175460>] [<c010577e>] [<c0175480>]
kjournald     S C8200240     0    75      1            76    12 (L-TLB)
Call Trace:    [<c0117148>] [<c01755f1>] [<c0175460>] [<c010577e>] [<c0175480>]
kjournald     S C461CBC0    52    76      1           199    75 (L-TLB)
Call Trace:    [<c0117148>] [<c01755f1>] [<c0175460>] [<c010577e>] [<c0175480>]
syslogd       S C0133A2B     8   199      1           202    76 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0106a8c>] [<c0116b8b>] [<c01fbffe>] [<c01f647c>]
  [<c014999d>] [<c0149e3e>] [<c010740f>]
klogd         R CFB091B8     0   202      1           210   199 (NOTLB)
Call Trace:    [<c01199a1>] [<c0139f43>] [<c010740f>]
gpm           S C0278730     0   210      1           215   202 (NOTLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c01f647c>] [<c014999d>] [<c0149e3e>]
  [<c013af25>] [<c010740f>]
inetd         S 00000000     8   215      1           222   210 (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
safe_mysqld   S 00000000     0   222      1   254     267   215 (NOTLB)
Call Trace:    [<c011d020>] [<c010740f>]
mysqld        S C0133A2B   148   254    222   255               (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b8b>] [<c0237f3e>] [<c01f647c>] [<c014999d>]
  [<c0149e3e>] [<c01065d8>] [<c010740f>]
mysqld        S C0278890    68   255    254   257               (NOTLB)
Call Trace:    [<c0116b38>] [<c01439f7>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
mysqld        S 00000000    68   256    255           257       (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
mysqld        S 00000000    68   257    255                 256 (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
sshd          S C0278890     8   267      1           274   222 (NOTLB)
Call Trace:    [<c0116b8b>] [<c0211ef6>] [<c01f647c>] [<c014999d>] [<c0149e3e>]
  [<c012ad62>] [<c010740f>]
atd           S 000041C0     4   274      1           277   267 (NOTLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c0122773>] [<c010740f>]
cron          S 000081A4     8   277      1           283   274 (NOTLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c0122773>] [<c010740f>]
bash          S CE93A000  4768   283      1   291     284   277 (NOTLB)
Call Trace:    [<c011d020>] [<c010740f>]
getty         S 00000001     0   284      1           285   283 (NOTLB)
Call Trace:    [<c0116b8b>] [<c019d4e9>] [<c01909e1>] [<c01904ad>] [<c018c5a5>]
  [<c0139f43>] [<c0125f48>] [<c010740f>]
getty         S 00000001    68   285      1           286   284 (NOTLB)
Call Trace:    [<c0116b8b>] [<c019d4e9>] [<c01909e1>] [<c01904ad>] [<c018c5a5>]
  [<c0139f43>] [<c0125f48>] [<c010740f>]
getty         S 00000001     0   286      1           287   285 (NOTLB)
Call Trace:    [<c0116b8b>] [<c019d4e9>] [<c01909e1>] [<c01904ad>] [<c018c5a5>]
  [<c0139f43>] [<c0125f48>] [<c010740f>]
getty         S 00000001     4   287      1           288   286 (NOTLB)
Call Trace:    [<c0116b8b>] [<c019d4e9>] [<c01909e1>] [<c01904ad>] [<c018c5a5>]
  [<c0139f43>] [<c0125f48>] [<c010740f>]
getty         S 00000001  2656   288      1           334   287 (NOTLB)
Call Trace:    [<c0116b8b>] [<c019d4e9>] [<c01909e1>] [<c01904ad>] [<c018c5a5>]
  [<c0139f43>] [<c0125f48>] [<c010740f>]
startx        S 00000000  5124   291    283   300               (NOTLB)
Call Trace:    [<c011d020>] [<c010740f>]
xinit         S 00004000  2656   300    291   304               (NOTLB)
Call Trace:    [<c0118d15>] [<c011d020>] [<c0116dac>] [<c010740f>]
XFree86       S C0133A2B    20   301    300           304       (NOTLB)
Call Trace:    [<c0133a2b>] [<c0106a8c>] [<c0116b8b>] [<c0237f3e>] [<c01f647c>]
  [<c014999d>] [<c0149e3e>] [<c01065d8>] [<c010740f>]
x-session-man S CDA9C7C0  4768   304    300                 301 (NOTLB)
Call Trace:    [<c0116b8b>] [<c01f647c>] [<c014a02b>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
gconfd-2      S CDA9CE40  4896   334      1           336   288 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
bonobo-activa S CD3909A0  4768   336      1           338   334 (NOTLB)
Call Trace:    [<c0116b8b>] [<c01f647c>] [<c014a02b>] [<c014a126>] [<c014a2fb>]
  [<c013a4f7>] [<c010740f>]
gnome-smproxy S C0133A2B  5112   338      1           340   336 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b8b>] [<c0237f3e>] [<c01f647c>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
gnome-setting S C0278890     0   340      1           346   338 (NOTLB)
Call Trace:    [<c0116b8b>] [<c01f647c>] [<c014a02b>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
xscreensaver  S C0133A2B   100   346      1           349   340 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b38>] [<c0116ac0>] [<c01439f7>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
sawfish       S C0133A2B     0   349      1           352   346 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b38>] [<c0116ac0>] [<c01439f7>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
gnome-panel   S C0278890  4944   352      1           358   349 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
gweather-appl S C0278890  4768   358      1   361     360   352 (NOTLB)
Call Trace:    [<c0116b8b>] [<c01f647c>] [<c014a02b>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
mixer_applet2 S C0278890  5088   360      1           374   358 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
gweather-appl S C0278890  5596   361    358   364               (NOTLB)
Call Trace:    [<c0116b38>] [<c01439f7>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
gweather-appl S C12C7F84  5728   362    361           363       (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
gweather-appl S C12C7F84  5728   363    361           364   362 (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
gweather-appl S CF6BB580  5892   364    361                 363 (NOTLB)
Call Trace:    [<c0116b8b>] [<c02208dd>] [<c0214987>] [<c02150fd>] [<c0230ec2>]
  [<c01f6028>] [<c01f6167>] [<c0139f43>] [<c010740f>]
xchat         S CB00D4A0  3984   372      1           388   373 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
gaim          S CB00D820  4916   373      1           372   374 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
xmms          S CABDD240  4964   374      1   375     373   360 (NOTLB)
Call Trace:    [<c0116b38>] [<c01f647c>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
xmms          S C0278890  5912   375    374   666               (NOTLB)
Call Trace:    [<c01fdd83>] [<c0116b38>] [<c01439f7>] [<c0116ac0>] [<c014a126>]
  [<c014a2fb>] [<c010740f>]
xmms          S C0133A2B  5416   376    375           384       (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b38>] [<c0116ac0>] [<c01f647c>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
xmms          S 000977D0     0   384    375           665   376 (NOTLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c0122773>] [<c010740f>]
xterm         S C0133A2B     0   388      1   389     420   372 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b8b>] [<c0190ba6>] [<c018d795>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
bash          S CC376000  2656   389    388   392               (NOTLB)
Call Trace:    [<c011d020>] [<c010740f>]
ssh           S C0278890     8   392    389                     (NOTLB)
Call Trace:    [<c0116b8b>] [<c0190ba6>] [<c018d795>] [<c014999d>] [<c0149e3e>]
  [<c010740f>]
mozilla-bin   S CF355180   300   420      1   426     474   388 (NOTLB)
Call Trace:    [<c01ce2cd>] [<c016981b>] [<c01cadaf>] [<c0125ed3>] [<c013ab1e>]
  [<c01391b3>] [<c01390d8>] [<c0139473>] [<c010740f>]
mozilla-bin   S C0278890  6324   426    420   436               (NOTLB)
Call Trace:    [<c0116b38>] [<c01439f7>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
mozilla-bin   S C0278890  4704   427    426           428       (NOTLB)
Call Trace:    [<c0116b38>] [<c01439f7>] [<c0116ac0>] [<c014a126>] [<c014a2fb>]
  [<c010740f>]
mozilla-bin   S C12C7F84  5772   428    426           429   427 (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
mozilla-bin   S 00000000  5548   429    426           436   428 (NOTLB)
Call Trace:    [<c0116b38>] [<c0116ac0>] [<c0122773>] [<c010740f>]
mozilla-bin   S C72722B0     0   436    426                 429 (NOTLB)
Call Trace:    [<c010632b>] [<c010740f>]
xterm         S C0133A2B     0   474      1   475           420 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b8b>] [<c0190ba6>] [<c018d795>] [<c014999d>]
  [<c0149e3e>] [<c010740f>]
bash          S C45BA000     0   475    474   485               (NOTLB)
Call Trace:    [<c011d020>] [<c010740f>]
vi            S 000001F0  5240   485    475                     (NOTLB)
Call Trace:    [<c0116b8b>] [<c0190ba6>] [<c018d795>] [<c014999d>] [<c0149e3e>]
  [<c010740f>]
xmms          S C5462E40     0   665    375           666   384 (NOTLB)
Call Trace:    [<c012cb70>] [<c0116b38>] [<c012cb70>] [<c0116ac0>] [<c0122773>]
  [<c010740f>]
xmms          S C0133A2B     0   666    375                 665 (NOTLB)
Call Trace:    [<c0133a2b>] [<c0116b38>] [<c0116ac0>] [<c014999d>] [<c0149e3e>]
  [<c010740f>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c0278894 <contig_page_data+214/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0133bb5 <__get_free_pages+45/50>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c0141a49 <sys_fstat64+49/80>
Trace; c010740f <system_call+33/38>
Proc;  keventd

>>EIP; 00200296 Before first symbol   <=====

Trace; c019cfdc <console_callback+9c/c0>
Trace; c012747d <context_thread+10d/1c0>
Trace; c0127370 <context_thread+0/1c0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c0127370 <context_thread+0/1c0>
Proc;  ksoftirqd_CPU

>>EIP; c0105000 <_stext+0/0>   <=====

Trace; c0105000 <_stext+0/0>
Trace; c011e646 <tasklet_action+46/70>
Trace; c011e8fe <ksoftirqd+7e/d0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c011e880 <ksoftirqd+0/d0>
Proc;  kswapd

>>EIP; c139e360 <END_OF_CODE+109d8a8/????>   <=====

Trace; c0132c56 <kswapd+86/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c0132bd0 <kswapd+0/c0>
Proc;  bdflush

>>EIP; 00000000 Before first symbol

Trace; c0117148 <interruptible_sleep_on+38/60>
Trace; c013e8aa <bdflush+ca/e0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c013e7e0 <bdflush+0/e0>
Proc;  kupdated

>>EIP; cfa6c000 <END_OF_CODE+f76b548/????>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c013e94c <kupdate+8c/100>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c013e8c0 <kupdate+0/100>
Proc;  khubd

>>EIP; 00000202 Before first symbol   <=====

Trace; c01e8bbe <usb_hub_thread+9e/d0>
Trace; c0105000 <_stext+0/0>
Trace; c010577e <kernel_thread+2e/40>
Trace; c01e8b20 <usb_hub_thread+0/d0>
Proc;  kjournald

>>EIP; ceafd3c0 <END_OF_CODE+e7fc908/????>   <=====

Trace; c0117148 <interruptible_sleep_on+38/60>
Trace; c01755f1 <kjournald+171/320>
Trace; c0175460 <commit_timeout+0/10>
Trace; c010577e <kernel_thread+2e/40>
Trace; c0175480 <kjournald+0/320>
Proc;  kjournald

>>EIP; c8200240 <END_OF_CODE+7eff788/????>   <=====

Trace; c0117148 <interruptible_sleep_on+38/60>
Trace; c01755f1 <kjournald+171/320>
Trace; c0175460 <commit_timeout+0/10>
Trace; c010577e <kernel_thread+2e/40>
Trace; c0175480 <kjournald+0/320>
Proc;  kjournald

>>EIP; c461cbc0 <END_OF_CODE+431c108/????>   <=====

Trace; c0117148 <interruptible_sleep_on+38/60>
Trace; c01755f1 <kjournald+171/320>
Trace; c0175460 <commit_timeout+0/10>
Trace; c010577e <kernel_thread+2e/40>
Trace; c0175480 <kjournald+0/320>
Proc;  syslogd

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0106a8c <setup_frame+11c/210>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c01fbffe <datagram_poll+2e/e0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  klogd

>>EIP; cfb091b8 <END_OF_CODE+f808700/????>   <=====

Trace; c01199a1 <do_syslog+131/2f0>
Trace; c0139f43 <sys_read+a3/140>
Trace; c010740f <system_call+33/38>
Proc;  gpm

>>EIP; c0278730 <contig_page_data+b0/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c013af25 <fput+d5/130>
Trace; c010740f <system_call+33/38>
Proc;  inetd

>>EIP; 00000000 Before first symbol

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  safe_mysqld

>>EIP; 00000000 Before first symbol

Trace; c011d020 <sys_wait4+100/3c0>
Trace; c010740f <system_call+33/38>
Proc;  mysqld

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0237f3e <unix_poll+2e/a0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c01065d8 <restore_sigcontext+128/140>
Trace; c010740f <system_call+33/38>
Proc;  mysqld

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  mysqld

>>EIP; 00000000 Before first symbol

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  mysqld

>>EIP; 00000000 Before first symbol

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  sshd

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0211ef6 <tcp_poll+36/190>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c012ad62 <sys_munmap+42/70>
Trace; c010740f <system_call+33/38>
Proc;  atd

>>EIP; 000041c0 Before first symbol   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c0122773 <sys_nanosleep+d3/170>
Trace; c010740f <system_call+33/38>
Proc;  cron

>>EIP; 000081a4 Before first symbol   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c0122773 <sys_nanosleep+d3/170>
Trace; c010740f <system_call+33/38>
Proc;  bash

>>EIP; ce93a000 <END_OF_CODE+e639548/????>   <=====

Trace; c011d020 <sys_wait4+100/3c0>
Trace; c010740f <system_call+33/38>
Proc;  getty

>>EIP; 00000001 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c019d4e9 <con_write+39/50>
Trace; c01909e1 <write_chan+161/220>
Trace; c01904ad <read_chan+28d/660>
Trace; c018c5a5 <tty_read+d5/100>
Trace; c0139f43 <sys_read+a3/140>
Trace; c0125f48 <sys_newuname+38/60>
Trace; c010740f <system_call+33/38>
Proc;  getty

>>EIP; 00000001 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c019d4e9 <con_write+39/50>
Trace; c01909e1 <write_chan+161/220>
Trace; c01904ad <read_chan+28d/660>
Trace; c018c5a5 <tty_read+d5/100>
Trace; c0139f43 <sys_read+a3/140>
Trace; c0125f48 <sys_newuname+38/60>
Trace; c010740f <system_call+33/38>
Proc;  getty

>>EIP; 00000001 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c019d4e9 <con_write+39/50>
Trace; c01909e1 <write_chan+161/220>
Trace; c01904ad <read_chan+28d/660>
Trace; c018c5a5 <tty_read+d5/100>
Trace; c0139f43 <sys_read+a3/140>
Trace; c0125f48 <sys_newuname+38/60>
Trace; c010740f <system_call+33/38>
Proc;  getty

>>EIP; 00000001 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c019d4e9 <con_write+39/50>
Trace; c01909e1 <write_chan+161/220>
Trace; c01904ad <read_chan+28d/660>
Trace; c018c5a5 <tty_read+d5/100>
Trace; c0139f43 <sys_read+a3/140>
Trace; c0125f48 <sys_newuname+38/60>
Trace; c010740f <system_call+33/38>
Proc;  getty

>>EIP; 00000001 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c019d4e9 <con_write+39/50>
Trace; c01909e1 <write_chan+161/220>
Trace; c01904ad <read_chan+28d/660>
Trace; c018c5a5 <tty_read+d5/100>
Trace; c0139f43 <sys_read+a3/140>
Trace; c0125f48 <sys_newuname+38/60>
Trace; c010740f <system_call+33/38>
Proc;  startx

>>EIP; 00000000 Before first symbol

Trace; c011d020 <sys_wait4+100/3c0>
Trace; c010740f <system_call+33/38>
Proc;  xinit

>>EIP; 00004000 Before first symbol   <=====

Trace; c0118d15 <do_fork+4e5/710>
Trace; c011d020 <sys_wait4+100/3c0>
Trace; c0116dac <schedule+20c/350>
Trace; c010740f <system_call+33/38>
Proc;  XFree86

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0106a8c <setup_frame+11c/210>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0237f3e <unix_poll+2e/a0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c01065d8 <restore_sigcontext+128/140>
Trace; c010740f <system_call+33/38>
Proc;  x-session-man

>>EIP; cda9c7c0 <END_OF_CODE+d79bd08/????>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014a02b <do_pollfd+5b/a0>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  gconfd-2

>>EIP; cda9ce40 <END_OF_CODE+d79c388/????>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  bonobo-activa

>>EIP; cd3909a0 <END_OF_CODE+d08fee8/????>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014a02b <do_pollfd+5b/a0>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c013a4f7 <sys_writev+77/90>
Trace; c010740f <system_call+33/38>
Proc;  gnome-smproxy

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0237f3e <unix_poll+2e/a0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  gnome-setting

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014a02b <do_pollfd+5b/a0>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  xscreensaver

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  sawfish

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  gnome-panel

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  gweather-appl

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014a02b <do_pollfd+5b/a0>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  mixer_applet2

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  gweather-appl

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  gweather-appl

>>EIP; c12c7f84 <END_OF_CODE+fc74cc/????>   <=====

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  gweather-appl

>>EIP; c12c7f84 <END_OF_CODE+fc74cc/????>   <=====

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  gweather-appl

>>EIP; cf6bb580 <END_OF_CODE+f3baac8/????>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c02208dd <tcp_reset_xmit_timer+7d/f0>
Trace; c0214987 <tcp_data_wait+137/170>
Trace; c02150fd <tcp_recvmsg+4fd/910>
Trace; c0230ec2 <inet_recvmsg+52/70>
Trace; c01f6028 <sock_recvmsg+58/f0>
Trace; c01f6167 <sock_read+a7/b0>
Trace; c0139f43 <sys_read+a3/140>
Trace; c010740f <system_call+33/38>
Proc;  xchat

>>EIP; cb00d4a0 <END_OF_CODE+ad0c9e8/????>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  gaim

>>EIP; cb00d820 <END_OF_CODE+ad0cd68/????>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; cabdd240 <END_OF_CODE+a8dc788/????>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01f647c <sock_poll+2c/40>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c01fdd83 <net_tx_action+43/c0>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c01f647c <sock_poll+2c/40>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; 000977d0 Before first symbol   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c0122773 <sys_nanosleep+d3/170>
Trace; c010740f <system_call+33/38>
Proc;  xterm

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0190ba6 <normal_poll+106/170>
Trace; c018d795 <tty_poll+85/b0>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  bash

>>EIP; cc376000 <END_OF_CODE+c075548/????>   <=====

Trace; c011d020 <sys_wait4+100/3c0>
Trace; c010740f <system_call+33/38>
Proc;  ssh

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0190ba6 <normal_poll+106/170>
Trace; c018d795 <tty_poll+85/b0>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; cf355180 <END_OF_CODE+f0546c8/????>   <=====

Trace; c01ce2cd <es1371_open+11d/300>
Trace; c016981b <ext3_lookup+9b/b0>
Trace; c01cadaf <soundcore_open+df/190>
Trace; c0125ed3 <in_group_p+23/30>
Trace; c013ab1e <chrdev_open+5e/70>
Trace; c01391b3 <dentry_open+d3/1d0>
Trace; c01390d8 <filp_open+68/70>
Trace; c0139473 <sys_open+53/a0>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; c0278890 <contig_page_data+210/340>   <=====

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c01439f7 <pipe_poll+37/80>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014a126 <do_poll+b6/110>
Trace; c014a2fb <sys_poll+17b/310>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; c12c7f84 <END_OF_CODE+fc74cc/????>   <=====

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; 00000000 Before first symbol

Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c0122773 <sys_nanosleep+d3/170>
Trace; c010740f <system_call+33/38>
Proc;  mozilla-bin

>>EIP; c72722b0 <END_OF_CODE+6f717f8/????>   <=====

Trace; c010632b <sys_rt_sigsuspend+db/100>
Trace; c010740f <system_call+33/38>
Proc;  xterm

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0190ba6 <normal_poll+106/170>
Trace; c018d795 <tty_poll+85/b0>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  bash

>>EIP; c45ba000 <END_OF_CODE+42b9548/????>   <=====

Trace; c011d020 <sys_wait4+100/3c0>
Trace; c010740f <system_call+33/38>
Proc;  vi

>>EIP; 000001f0 Before first symbol   <=====

Trace; c0116b8b <schedule_timeout+ab/b0>
Trace; c0190ba6 <normal_poll+106/170>
Trace; c018d795 <tty_poll+85/b0>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; c5462e40 <END_OF_CODE+5162388/????>   <=====

Trace; c012cb70 <file_read_actor+0/a0>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c012cb70 <file_read_actor+0/a0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c0122773 <sys_nanosleep+d3/170>
Trace; c010740f <system_call+33/38>
Proc;  xmms

>>EIP; c0133a2b <__alloc_pages+4b/190>   <=====

Trace; c0133a2b <__alloc_pages+4b/190>
Trace; c0116b38 <schedule_timeout+58/b0>
Trace; c0116ac0 <process_timeout+0/20>
Trace; c014999d <do_select+10d/230>
Trace; c0149e3e <sys_select+34e/4e0>
Trace; c010740f <system_call+33/38>


3 warnings issued.  Results may not be reliable.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
