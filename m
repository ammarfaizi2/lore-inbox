Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCFEcJ>; Tue, 5 Mar 2002 23:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293208AbSCFEcH>; Tue, 5 Mar 2002 23:32:07 -0500
Received: from DIRTY-BASTARD.MIT.EDU ([18.241.0.136]:4224 "EHLO
	dirty-bastard.pthbb.org") by vger.kernel.org with ESMTP
	id <S293205AbSCFEbh>; Tue, 5 Mar 2002 23:31:37 -0500
Message-Id: <200203061710.g26HAlf00944@dirty-bastard.pthbb.org>
To: kaos@ocs.com.au
cc: linux-kernel@vger.kernel.org
Subject: Re: Tulip bug? 
Content-Transfer-Encoding: quoted-printable
In-Reply-To: Your message of "Tue, 05 Mar 2002 12:35:20 EST."
             <3C8501D8.A20D4A09@mandrakesoft.com> 
Date: Wed, 06 Mar 2002 12:10:47 -0500
From: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serial's not an option. I did manage to patch with kmsgd and got a dump.
Ran ksymoops, but there doesn't appear to be anything that would belong
to anybody in particular. All that I can make out is:

  there is an attempt to sys_read which results in a seek and a page fault.

  there appears to be some binary garbage in the dump file, and negative PID's
  for processes, might this be indicative of a memory problem?

Here is the output of ksymoops
(quoted-printable due to the binary char's,
 figured this way it would be mostly legible over MIME):

ksymoops 2.4.4 on i586 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /opt/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod=
 file?
Warning (compare_maps): ksyms_base symbol do_BUG_R__ver_do_BUG not found =
in System.map.  Ignoring ksyms_base entry
<4>esi: c74e4000   edi: 0000000b   ebp: c74e4000   esp: c74e44c8
<4>ds: 0018   es: 0018   ss: 0018
<4>Process ld (pid: 1054, stackpage=3Dc74e5000)
<4>Stack: 0000781c 0000781c 00000001 c74e4000 c0112b35 0000781b 0000781c =
00000086 =

<4>       00000086 00000001 c0247b44 c0294f81 00000046 00000001 c74e4000 =
c0112d31 =

<4>       0000000f 00000000 c02138a0 c010f2e9 c02137e0 c0213877 c01077df =
00000000 =

<4>Call Trace: [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c010=
77ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c0119f03>] [<c0119d8b>] [<c011553b>] [<c01158d6>] [<=
c0116af3>] =

<4>   [<c0108825>] [<c010a958>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<=
c018c7a2>] =

<4>   [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<=
c01077df>] =

<4>   [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<=
c011b175>] =

<4>   [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<=
c01158d6>] =

<4>   [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<=
c010f462>] =

<4>   [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<=
c01c1493>] =

<4>   [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<=
c0112d31>] =

<4>   [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c0119f03>] [<=
c0119d8b>] =

<4>   [<c011553b>] [<c01158d6>] [<c0116af3>] [<c0108825>] [<c010a958>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<=
c0112b35>] =

<4>   [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<=
c010f320>] =

<4>   [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<=
c018d3fc>] =

<4>   [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<=
c010f2e9>] =

<4>   [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c01101c3>] =

<4>   [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<=
c011553b>] =

<4>   [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<=
c0112b35>] =

<4>   [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<=
c010f320>] =

<4>   [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<=
c0119f03>] =

<4>   [<c0119d8b>] [<c011553b>] [<c01158d6>] [<c0116af3>] [<c0108825>] [<=
c010f320>] =

<4>   [<c010a958>] [<c010f320>] [<c010f320>] [<c01077ea>] [<c010f462>] [<=
c018830e>] =

<4>   [<c010f320>] [<c0107344>] [<c0142bab>] [<c012e540>] [<c0115198>] [<=
c01157db>] =

<4>   [<c0112b35>] [<c0112d31>] [<c010f320>] [<c010f2e9>] [<c01077df>] [<=
c010f320>] =

<4>   [<c01077ea>] [<c010f462>] [<c0112d31>] [<c012a5bd>] [<c012a8b2>] [<=
c011f1b2>] =

<4>   [<c010f320>] [<c0107344>] [<c01218aa>] [<c0130cd7>] [<c01112ee>] [<=
c01157bb>] =

<4>   [<c011acec>] [<c011a93f>] [<c0106f7f>] [<c012335b>] [<c012e9c6>] [<=
c012e690>] =

<4>   [<c012e925>] [<c010f320>] [<c0107274>] =

<4>Code: ff 0b 0f 94 c0 84 c0 74 76 ff 73 08 e8 bb 9e 02 00 8b 53 14 =

Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c018830e <scrup+fe/110>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c0142bab <fcntl_dirnotify+2b/160>
Trace; c012e540 <filp_close+30/70>
Trace; c0115198 <put_files_struct+58/d0>
Trace; c01157db <do_exit+9b/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c0112d31 <printk+101/140>
Trace; c012a5bd <swap_info_get+4d/b0>
Trace; c012a8b2 <free_swap_and_cache+12/a0>
Trace; c011f1b2 <zap_page_range+222/240>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01218aa <exit_mmap+8a/130>
Trace; c0130cd7 <create_empty_buffers+17/70>
Trace; c01112ee <mmput+2e/50>
Trace; c01157bb <do_exit+7b/1f0>
Trace; c011acec <deliver_signal+1c/60>
Trace; c011a93f <dequeue_signal+5f/b0>
Trace; c0106f7f <do_signal+ff/2c0>
Trace; c012335b <generic_file_read+11b/130>
Trace; c012e9c6 <sys_read+86/e0>
Trace; c012e690 <generic_file_llseek+0/c0>
Trace; c012e925 <sys_llseek+c5/e0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107274 <signal_return+14/20>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff 0b                     decl   (%ebx)
Code;  00000002 Before first symbol
   2:   0f 94 c0                  sete   %al
Code;  00000005 Before first symbol
   5:   84 c0                     test   %al,%al
Code;  00000007 Before first symbol
   7:   74 76                     je     7f <_EIP+0x7f> 0000007f Before f=
irst symbol
Code;  00000009 Before first symbol
   9:   ff 73 08                  pushl  0x8(%ebx)
Code;  0000000c Before first symbol
   c:   e8 bb 9e 02 00            call   29ecc <_EIP+0x29ecc> 00029ecc Be=
fore first symbol
Code;  00000011 Before first symbol
  11:   8b 53 14                  mov    0x14(%ebx),%edx

<4> <1>Unable to handle kernel paging request at virtual address 37363550=

<4>c0179f97
<1>*pde =3D 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<c0179f97>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: c74e4000   ebx: 37363534   ecx: c74e40e0   edx: c74e4000
<4>esi: c74e4000   edi: 0000000b   ebp: c0213800   esp: c74e434c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process  (pid: 1054, stackpage=3Dc74e5000)
<4>Stack: c0213800 c0213800 00000000 c74e4000 0000000b c0213800 c01157c1 =
c0291560 =

<4>       fffffffe 00000046 c0116af3 00000046 00000000 00000000 c028f900 =
c0247540 =

<4>       c0108825 00000000 00000000 c010f320 c0213800 c010a958 00000000 =
cb4ac000 =

<4>Call Trace: [<c01157c1>] [<c0116af3>] [<c0108825>] [<c010f320>] [<c010=
a958>] =

<4>   [<c010f320>] [<c010f320>] [<c01077ea>] [<c010f462>] [<c018830e>] [<=
c01c1493>] =

<4>   [<c010f320>] [<c0107344>] [<c01157f4>] [<c0112b35>] [<c0112d31>] [<=
c010f2e9>] =

<4>   [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c01101c3>] =

<4>   [<c011b175>] [<c011b211>] [<c01c1493>] [<c0119f03>] [<c0119d8b>] [<=
c011553b>] =

<4>   [<c01158d6>] [<c0116af3>] [<c0108825>] [<c010a958>] [<c01077ea>] [<=
c010f462>] =

<4>   [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<=
c01c1493>] =

<4>   [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<=
c0112d31>] =

<4>   [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<=
c018c7a2>] =

<4>   [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<=
c01077df>] =

<4>   [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<=
c011b175>] =

<4>   [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<=
c01158d6>] =

<4>   [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<=
c010f462>] =

<4>   [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<=
c01c1493>] =

<4>   [<c0119f03>] [<c0119d8b>] [<c011553b>] [<c01158d6>] [<c0116af3>] [<=
c0108825>] =

<4>   [<c010a958>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c01101c3>] =

<4>   [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<=
c011553b>] =

<4>   [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<=
c0112b35>] =

<4>   [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<=
c010f320>] =

<4>   [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<=
c018d3fc>] =

<4>   [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<=
c010f2e9>] =

<4>   [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c01101c3>] =

<4>   [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<=
c011553b>] =

<4>   [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c0119f03>] [<c0119d8b>] [<c011553b>] [<c01158d6>] [<=
c0116af3>] =

<4>   [<c0108825>] [<c010f320>] [<c010a958>] [<c010f320>] [<c010f320>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c018830e>] [<c010f320>] [<c0107344>] [<c0142bab>] [<=
c012e540>] =

<4>   [<c0115198>] [<c01157db>] [<c0112b35>] [<c0112d31>] [<c010f320>] [<=
c010f2e9>] =

<4>   [<c01077df>] [<c010f320>] [<c01077ea>] [<c010f462>] [<c0112d31>] [<=
c012a5bd>] =

<4>   [<c012a8b2>] [<c011f1b2>] [<c010f320>] [<c0107344>] [<c01218aa>] [<=
c0130cd7>] =

<4>   [<c01112ee>] [<c01157bb>] [<c011acec>] [<c011a93f>] [<c0106f7f>] [<=
c012335b>] =

<4>   [<c012e9c6>] [<c012e690>] [<c012e925>] [<c010f320>] [<c0107274>] =

<4>Code: 8b 43 1c 85 c0 89 c2 0f 88 bc 01 00 00 81 e2 00 80 ff ff bf =


>>EIP; c0179f97 <sem_exit+17/1f0>   <=3D=3D=3D=3D=3D
Trace; c01157c1 <do_exit+81/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c018830e <scrup+fe/110>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01157f4 <do_exit+b4/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c018830e <scrup+fe/110>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c0142bab <fcntl_dirnotify+2b/160>
Trace; c012e540 <filp_close+30/70>
Trace; c0115198 <put_files_struct+58/d0>
Trace; c01157db <do_exit+9b/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c0112d31 <printk+101/140>
Trace; c012a5bd <swap_info_get+4d/b0>
Trace; c012a8b2 <free_swap_and_cache+12/a0>
Trace; c011f1b2 <zap_page_range+222/240>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01218aa <exit_mmap+8a/130>
Trace; c0130cd7 <create_empty_buffers+17/70>
Trace; c01112ee <mmput+2e/50>
Trace; c01157bb <do_exit+7b/1f0>
Trace; c011acec <deliver_signal+1c/60>
Trace; c011a93f <dequeue_signal+5f/b0>
Trace; c0106f7f <do_signal+ff/2c0>
Trace; c012335b <generic_file_read+11b/130>
Trace; c012e9c6 <sys_read+86/e0>
Trace; c012e690 <generic_file_llseek+0/c0>
Trace; c012e925 <sys_llseek+c5/e0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107274 <signal_return+14/20>
Code;  c0179f97 <sem_exit+17/1f0>
00000000 <_EIP>:
Code;  c0179f97 <sem_exit+17/1f0>   <=3D=3D=3D=3D=3D
   0:   8b 43 1c                  mov    0x1c(%ebx),%eax   <=3D=3D=3D=3D=3D=

Code;  c0179f9a <sem_exit+1a/1f0>
   3:   85 c0                     test   %eax,%eax
Code;  c0179f9c <sem_exit+1c/1f0>
   5:   89 c2                     mov    %eax,%edx
Code;  c0179f9e <sem_exit+1e/1f0>
   7:   0f 88 bc 01 00 00         js     1c9 <_EIP+0x1c9> c017a160 <sem_e=
xit+1e0/1f0>
Code;  c0179fa4 <sem_exit+24/1f0>
   d:   81 e2 00 80 ff ff         and    $0xffff8000,%edx
Code;  c0179faa <sem_exit+2a/1f0>
  13:   bf 00 00 00 00            mov    $0x0,%edi

<4> <1>Unable to handle kernel NULL pointer dereference at virtual addres=
s 00000004
<4>c0127e1c
<1>*pde =3D 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c0127e1c>]    Not tainted
<4>EFLAGS: 00010046
<4>eax: 00000000   ebx: 00030043   ecx: c1003fb0   edx: c1003fb8
<4>esi: c1003fb0   edi: 00000282   ebp: c74e4000   esp: c74e41b8
<4>ds: 0018   es: 0018   ss: 0018
<4>Process !=C0 (pid: -1072662791, stackpage=3Dc74e5000)
<4>Stack: 37e8006a c0213888 c010f462 00000000 c017a07a c010f462 c74e4000 =
c74e4260 =

<4>       00000000 c74e4000 0000000b c74e4000 c01157c1 000094fc 000094fc =
00000001 =

<4>       c74e4000 c0112b35 000094fb 000094fc 00000086 00000086 00000001 =
c0247b44 =

<4>Call Trace: [<c010f462>] [<c017a07a>] [<c010f462>] [<c01157c1>] [<c011=
2b35>] =

<4>   [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c018830e>] [<=
c010f320>] =

<4>   [<c0107344>] [<c0179f97>] [<c01157c1>] [<c0116af3>] [<c0108825>] [<=
c010f320>] =

<4>   [<c010a958>] [<c010f320>] [<c010f320>] [<c01077ea>] [<c010f462>] [<=
c018830e>] =

<4>   [<c01c1493>] [<c010f320>] [<c0107344>] [<c01157f4>] [<c0112b35>] [<=
c0112d31>] =

<4>   [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c0119f03>] [<=
c0119d8b>] =

<4>   [<c011553b>] [<c01158d6>] [<c0116af3>] [<c0108825>] [<c010a958>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<=
c0112b35>] =

<4>   [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<=
c010f320>] =

<4>   [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<=
c018d3fc>] =

<4>   [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<=
c010f2e9>] =

<4>   [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c01101c3>] =

<4>   [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<=
c011553b>] =

<4>   [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<=
c011b211>] =

<4>   [<c01c1493>] [<c0119f03>] [<c0119d8b>] [<c011553b>] [<c01158d6>] [<=
c0116af3>] =

<4>   [<c0108825>] [<c010a958>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<=
c018c7a2>] =

<4>   [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<=
c01077df>] =

<4>   [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<=
c011b175>] =

<4>   [<c011b211>] [<c01c1493>] [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<=
c01158d6>] =

<4>   [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<c01077df>] [<c01077ea>] [<=
c010f462>] =

<4>   [<c010f320>] [<c0107344>] [<c01101c3>] [<c011b175>] [<c011b211>] [<=
c01c1493>] =

<4>   [<c018d3fc>] [<c018c7a2>] [<c011553b>] [<c01158d6>] [<c0112b35>] [<=
c0112d31>] =

<4>   [<c010f2e9>] [<c01077df>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01101c3>] [<c011b175>] [<c011b211>] [<c01c1493>] [<c018d3fc>] [<=
c018c7a2>] =

<4>   [<c011553b>] [<c01158d6>] [<c0112b35>] [<c0112d31>] [<c010f2e9>] [<=
c01077df>] =

<4>   [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<c01101c3>] [<=
c011b175>] =

<4>   [<c011b211>] [<c01c1493>] [<c0119f03>] [<c0119d8b>] [<c011553b>] [<=
c01158d6>] =

<4>   [<c0116af3>] [<c0108825>] [<c010f320>] [<c010a958>] [<c010f320>] [<=
c010f320>] =

<4>   [<c01077ea>] [<c010f462>] [<c018830e>] [<c010f320>] [<c0107344>] [<=
c0142bab>] =

<4>   [<c012e540>] [<c0115198>] [<c01157db>] [<c0112b35>] [<c0112d31>] [<=
c010f320>] =

<4>   [<c010f2e9>] [<c01077df>] [<c010f320>] [<c01077ea>] [<c010f462>] [<=
c0112d31>] =

<4>   [<c012a5bd>] [<c012a8b2>] [<c011f1b2>] [<c010f320>] [<c0107344>] [<=
c01218aa>] =

<4>   [<c0130cd7>] [<c01112ee>] [<c01157bb>] [<c011acec>] [<c011a93f>] [<=
c0106f7f>] =

<4>   [<c012335b>] [<c012e9c6>] [<c012e690>] [<c012e925>] [<c010f320>] [<=
c0107274>] =

<4>Code: 89 48 04 89 01 89 51 04 89 4e 08 eb da 8b 51 04 8b 01 89 50 =


>>EIP; c0127e1c <kfree+6c/a0>   <=3D=3D=3D=3D=3D
Trace; c010f462 <do_page_fault+142/520>
Trace; c017a07a <sem_exit+fa/1f0>
Trace; c010f462 <do_page_fault+142/520>
Trace; c01157c1 <do_exit+81/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c018830e <scrup+fe/110>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c0179f97 <sem_exit+17/1f0>
Trace; c01157c1 <do_exit+81/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c018830e <scrup+fe/110>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01157f4 <do_exit+b4/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c018d3fc <poke_blanked_console+6c/70>
Trace; c018c7a2 <vt_console_print+252/320>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01101c3 <__wake_up+23/a0>
Trace; c011b175 <wake_up_parent+25/40>
Trace; c011b211 <do_notify_parent+81/d0>
Trace; c01c1493 <vgacon_cursor+123/180>
Trace; c0119f03 <update_process_times+23/b0>
Trace; c0119d8b <update_wall_time+b/50>
Trace; c011553b <exit_notify+bb/2c0>
Trace; c01158d6 <do_exit+196/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c018830e <scrup+fe/110>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c0142bab <fcntl_dirnotify+2b/160>
Trace; c012e540 <filp_close+30/70>
Trace; c0115198 <put_files_struct+58/d0>
Trace; c01157db <do_exit+9b/1f0>
Trace; c0112b35 <call_console_drivers+85/110>
Trace; c0112d31 <printk+101/140>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f2e9 <bust_spinlocks+49/60>
Trace; c01077df <die+3f/50>
Trace; c010f320 <do_page_fault+0/520>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c0112d31 <printk+101/140>
Trace; c012a5bd <swap_info_get+4d/b0>
Trace; c012a8b2 <free_swap_and_cache+12/a0>
Trace; c011f1b2 <zap_page_range+222/240>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01218aa <exit_mmap+8a/130>
Trace; c0130cd7 <create_empty_buffers+17/70>
Trace; c01112ee <mmput+2e/50>
Trace; c01157bb <do_exit+7b/1f0>
Trace; c011acec <deliver_signal+1c/60>
Trace; c011a93f <dequeue_signal+5f/b0>
Trace; c0106f7f <do_signal+ff/2c0>
Trace; c012335b <generic_file_read+11b/130>
Trace; c012e9c6 <sys_read+86/e0>
Trace; c012e690 <generic_file_llseek+0/c0>
Trace; c012e925 <sys_llseek+c5/e0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107274 <signal_return+14/20>
Code;  c0127e1c <kfree+6c/a0>
00000000 <_EIP>:
Code;  c0127e1c <kfree+6c/a0>   <=3D=3D=3D=3D=3D
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=3D=3D=3D=3D=3D=

Code;  c0127e1f <kfree+6f/a0>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c0127e21 <kfree+71/a0>
   5:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c0127e24 <kfree+74/a0>
   8:   89 4e 08                  mov    %ecx,0x8(%esi)
Code;  c0127e27 <kfree+77/a0>
   b:   eb da                     jmp    ffffffe7 <_EIP+0xffffffe7> c0127=
e03 <kfree+53/a0>
Code;  c0127e29 <kfree+79/a0>
   d:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c0127e2c <kfree+7c/a0>
  10:   8b 01                     mov    (%ecx),%eax
Code;  c0127e2e <kfree+7e/a0>
  12:   89 50 00                  mov    %edx,0x0(%eax)

<4> <0>Kernel panic: Attempted to kill init!
<1>Unable to handle kernel paging request at virtual address ff2500a6
<4>c010f48b
<1>*pde =3D 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c010f48b>]    Not tainted
<4>EFLAGS: 00010082
<4>eax: ff2500a6   ebx: c74e0000   ecx: 00000018   edx: c74e0014
<4>esi: ff25008a   edi: c010f320   ebp: c74de000   esp: c74dff6c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process PR=FF=15=98=EA=0C=08=8B=159=89=08=83=C4=10=85=D2t=A1=D4=ED=0C=08=
9=05=B8=89=08t(Wj=05h`y=0C=08=83Us=0C=08=E8J=E2=FB=FF=8B=15=D4=ED=0C=08=83=
=C4=10=89=15=B8=89=08=A3=B4=89=08=89=C2=FFV=8BK=10QR=FF=15=98=EA=0C=08=E9=
=E5=F9=FF=FF=8D=B6 (pid: -666006757, stackpage=3Dc74df000)
<4>Stack: ffff3f82 000000fc c74de000 fd82853b 558bffff 00030001 8b3c788b =
ff85e485 =

<4>       f6894974 74013b83 14778b2e 840ff685 000000d3 0c1047f6 51511474 =
000bd4c4 =

<4>       73886800 a9e8080c 83fffe63 478b10c4 40408b18 8b084389 d2851457 =
00a58445 =

<4>Call Trace: =

<4>Code: ff 00 0f 88 1f df 0f 00 ff 74 24 04 56 e8 33 1a 01 00 89 c7 =


>>EIP; c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
Code;  c010f48b <do_page_fault+16b/520>
00000000 <_EIP>:
Code;  c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
   0:   ff 00                     incl   (%eax)   <=3D=3D=3D=3D=3D
Code;  c010f48d <do_page_fault+16d/520>
   2:   0f 88 1f df 0f 00         js     fdf27 <_EIP+0xfdf27> c020d3b2 <s=
text_lock+c2/2b40>
Code;  c010f493 <do_page_fault+173/520>
   8:   ff 74 24 04               pushl  0x4(%esp,1)
Code;  c010f497 <do_page_fault+177/520>
   c:   56                        push   %esi
Code;  c010f498 <do_page_fault+178/520>
   d:   e8 33 1a 01 00            call   11a45 <_EIP+0x11a45> c0120ed0 <f=
ind_vma+0/60>
Code;  c010f49d <do_page_fault+17d/520>
  12:   89 c7                     mov    %eax,%edi

<4> <1>Unable to handle kernel paging request at virtual address ff2500a6=

<4>c010f48b
<1>*pde =3D 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c010f48b>]    Not tainted
<4>EFLAGS: 00010082
<4>eax: ff2500a6   ebx: c74de000   ecx: 00000018   edx: c74dfdcc
<4>esi: ff25008a   edi: c010f320   ebp: c74de000   esp: c74dfd24
<4>ds: 0018   es: 0018   ss: 0018
<4>Process PR=FF=15=98=EA=0C=08=8B=159=89=08=83=C4=10=85=D2t=A1=D4=ED=0C=08=
9=05=B8=89=08t(Wj=05h`y=0C=08=83Us=0C=08=E8J=E2=FB=FF=8B=15=D4=ED=0C=08=83=
=C4=10=89=15=B8=89=08=A3=B4=89=08=89=C2=FFV=8BK=10QR=FF=15=98=EA=0C=08=E9=
=E5=F9=FF=FF=8D=B6 (pid: -666006757, stackpage=3Dc74df000)
<4>Stack: 000bc051 6e850f04 c74de000 00000001 c01ad530 00030001 c1395500 =
000bc051 =

<4>       00000002 c02b4820 000bc014 c1395ec0 c02b4860 c02b4820 c02b4860 =
c02b4820 =

<4>       c01ad768 c02b4860 0000000e c1397060 c02b4860 00000202 c1397060 =
c02b4820 =

<4>Call Trace: [<c01ad530>] [<c01ad768>] [<c01addf3>] [<c01b14e0>] [<c010=
8669>] =

<4>   [<c010f320>] [<c0107344>] [<c01199d6>] [<c0115786>] [<c0116af3>] [<=
c0108825>] =

<4>   [<c010a958>] [<c01077ea>] [<c010f462>] [<c010f320>] [<c0107344>] [<=
c010f320>] =

<4>   [<c010f48b>] =

<4>Code: ff 00 0f 88 1f df 0f 00 ff 74 24 04 56 e8 33 1a 01 00 89 c7 =


>>EIP; c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
Trace; c01ad530 <start_request+180/250>
Trace; c01ad768 <ide_do_request+108/320>
Trace; c01addf3 <ide_intr+103/170>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c0108669 <handle_IRQ_event+39/80>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01199d6 <del_timer+16/40>
Trace; c0115786 <do_exit+46/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Code;  c010f48b <do_page_fault+16b/520>
00000000 <_EIP>:
Code;  c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
   0:   ff 00                     incl   (%eax)   <=3D=3D=3D=3D=3D
Code;  c010f48d <do_page_fault+16d/520>
   2:   0f 88 1f df 0f 00         js     fdf27 <_EIP+0xfdf27> c020d3b2 <s=
text_lock+c2/2b40>
Code;  c010f493 <do_page_fault+173/520>
   8:   ff 74 24 04               pushl  0x4(%esp,1)
Code;  c010f497 <do_page_fault+177/520>
   c:   56                        push   %esi
Code;  c010f498 <do_page_fault+178/520>
   d:   e8 33 1a 01 00            call   11a45 <_EIP+0x11a45> c0120ed0 <f=
ind_vma+0/60>
Code;  c010f49d <do_page_fault+17d/520>
  12:   89 c7                     mov    %eax,%edi

<4> <1>Unable to handle kernel paging request at virtual address ff2500a6=

<4>c010f48b
<1>*pde =3D 00000000
<4>Oops: 0002
<4>CPU:    0
<4>EIP:    0010:[<c010f48b>]    Not tainted
<4>EFLAGS: 00010082
<4>eax: ff2500a6   ebx: c74de000   ecx: 00000018   edx: c74dfb84
<4>esi: ff25008a   edi: c010f320   ebp: c74de000   esp: c74dfadc
<4>ds: 0018   es: 0018   ss: 0018
<4>Process PR=FF=15=98=EA=0C=08=8B=159=89=08=83=C4=10=85=D2t=A1=D4=ED=0C=08=
9=05=B8=89=08t(Wj=05h`y=0C=08=83Us=0C=08=E8J=E2=FB=FF=8B=15=D4=ED=0C=08=83=
=C4=10=89=15=B8=89=08=A3=B4=89=08=89=C2=FFV=8BK=10QR=FF=15=98=EA=0C=08=E9=
=E5=F9=FF=FF=8D=B6 (pid: -666006757, stackpage=3Dc74df000)
<4>Stack: c01b1d6c 6e850f04 c74de000 000003e8 c01b1bc0 00030001 00000000 =
004d4c4b =

<4>       c02b4820 000000e0 c1394d20 c02b4860 c01b5636 00000001 c02b4860 =
c02b4820 =

<4>       62613938 000000c8 c01ad24a 0000012c 882b4860 000bc057 c02b4860 =
000bc057 =

<4>Call Trace: [<c01b1d6c>] [<c01b1bc0>] [<c01b5636>] [<c01ad24a>] [<c01a=
d530>] =

<4>   [<c010f320>] [<c0107344>] [<c01199d6>] [<c0115786>] [<c01087f6>] [<=
c0108815>] =

<4>   [<c010a958>] [<c01077ea>] [<c010f462>] [<c01b1778>] [<c01ac445>] [<=
c01b1d6c>] =

<4>   [<c01b14e0>] [<c010f320>] [<c0107344>] [<c010f320>] [<c010f48b>] [<=
c01ad530>] =

<4>   [<c01ad768>] [<c01addf3>] [<c01b14e0>] [<c0108669>] [<c010f320>] [<=
c0107344>] =

<4>   [<c01199d6>] [<c0115786>] [<c0116af3>] [<c0108825>] [<c010a958>] [<=
c01077ea>] =

<4>   [<c010f462>] [<c010f320>] [<c0107344>] [<c010f320>] [<c010f48b>] =

<4>Code: ff 00 0f 88 1f df 0f 00 ff 74 24 04 56 e8 33 1a 01 00 89 c7 =


>>EIP; c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
Trace; c01b1d6c <ide_dmaproc+13c/260>
Trace; c01b1bc0 <dma_timer_expiry+0/70>
Trace; c01b5636 <do_rw_disk+e6/310>
Trace; c01ad24a <ide_wait_stat+da/130>
Trace; c01ad530 <start_request+180/250>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01199d6 <del_timer+16/40>
Trace; c0115786 <do_exit+46/1f0>
Trace; c01087f6 <do_IRQ+56/a0>
Trace; c0108815 <do_IRQ+75/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c01b1778 <ide_build_dmatable+28/180>
Trace; c01ac445 <ide_set_handler+55/60>
Trace; c01b1d6c <ide_dmaproc+13c/260>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Trace; c01ad530 <start_request+180/250>
Trace; c01ad768 <ide_do_request+108/320>
Trace; c01addf3 <ide_intr+103/170>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c0108669 <handle_IRQ_event+39/80>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01199d6 <del_timer+16/40>
Trace; c0115786 <do_exit+46/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Code;  c010f48b <do_page_fault+16b/520>
00000000 <_EIP>:
Code;  c010f48b <do_page_fault+16b/520>   <=3D=3D=3D=3D=3D
   0:   ff 00                     incl   (%eax)   <=3D=3D=3D=3D=3D
Code;  c010f48d <do_page_fault+16d/520>
   2:   0f 88 1f df 0f 00         js     fdf27 <_EIP+0xfdf27> c020d3b2 <s=
text_lock+c2/2b40>
Code;  c010f493 <do_page_fault+173/520>
   8:   ff 74 24 04               pushl  0x4(%esp,1)
Code;  c010f497 <do_page_fault+177/520>
   c:   56                        push   %esi
Code;  c010f498 <do_page_fault+178/520>
   d:   e8 33 1a 01 00            call   11a45 <_EIP+0x11a45> c0120ed0 <f=
ind_vma+0/60>
Code;  c010f49d <do_page_fault+17d/520>
  12:   89 c7                     mov    %eax,%edi

<4> <1>Unable to handle kernel paging request at virtual address 000603a1=

<4>c01101c6
<1>*pde =3D 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<c01101c6>]    Not tainted
<4>EFLAGS: 00010097
<4>eax: c754ed28   ebx: c754ed00   ecx: 000603a1   edx: 00000003
<4>esi: c1394d20   edi: 00000001   ebp: c74df8f4   esp: c74df8dc
<4>ds: 0018   es: 0018   ss: 0018
<4>Process PR=FF=15=98=EA=0C=08=8B=159=89=08=83=C4=10=85=D2t=A1=D4=ED=0C=08=
9=05=B8=89=08t(Wj=05h`y=0C=08=83Us=0C=08=E8J=E2=FB=FF=8B=15=D4=ED=0C=08=83=
=C4=10=89=15=B8=89=08=A3=B4=89=08=89=C2=FFV=8BK=10QR=FF=15=98=EA=0C=08=E9=
=E5=F9=FF=FF=8D=B6 (pid: -666006757, stackpage=3Dc74df000)
<4>Stack: 00000086 00000003 c754ed28 c754ece0 c1394d20 00000002 00000001 =
c012f87d =

<4>       c754ece0 c01966df c754ece0 00000001 c1394d20 c1397060 00000001 =
00000002 =

<4>       c01ac394 c1394d20 00000001 c02b4934 00000004 c1394d20 c02b4860 =
c02b4820 =

<4>Call Trace: [<c012f87d>] [<c01966df>] [<c01ac394>] [<c01b156d>] [<c01a=
dda4>] =

<4>   [<c01b14e0>] [<c0108669>] [<c01087f6>] [<c010a958>] [<c01077e5>] [<=
c010f462>] =

<4>   [<c010f320>] [<c0107344>] [<c010f320>] [<c010f48b>] [<c01b1d6c>] [<=
c01b1bc0>] =

<4>   [<c01b5636>] [<c01ad24a>] [<c01ad530>] [<c010f320>] [<c0107344>] [<=
c01199d6>] =

<4>   [<c0115786>] [<c01087f6>] [<c0108815>] [<c010a958>] [<c01077ea>] [<=
c010f462>] =

<4>   [<c01b1778>] [<c01ac445>] [<c01b1d6c>] [<c01b14e0>] [<c010f320>] [<=
c0107344>] =

<4>   [<c010f320>] [<c010f48b>] [<c01ad530>] [<c01ad768>] [<c01addf3>] [<=
c01b14e0>] =

<4>   [<c0108669>] [<c010f320>] [<c0107344>] [<c01199d6>] [<c0115786>] [<=
c0116af3>] =

<4>   [<c0108825>] [<c010a958>] [<c01077ea>] [<c010f462>] [<c010f320>] [<=
c0107344>] =

<4>   [<c010f320>] [<c010f48b>] =

<4>Code: 8b 01 85 45 ec 74 24 b8 00 00 00 00 9c 5e fa 8b 51 3c c7 01 =


>>EIP; c01101c6 <__wake_up+26/a0>   <=3D=3D=3D=3D=3D
Trace; c012f87d <end_buffer_io_sync+1d/30>
Trace; c01966df <end_that_request_first+3f/d0>
Trace; c01ac394 <ide_end_request+34/90>
Trace; c01b156d <ide_dma_intr+8d/b0>
Trace; c01adda4 <ide_intr+b4/170>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c0108669 <handle_IRQ_event+39/80>
Trace; c01087f6 <do_IRQ+56/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077e5 <die+45/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Trace; c01b1d6c <ide_dmaproc+13c/260>
Trace; c01b1bc0 <dma_timer_expiry+0/70>
Trace; c01b5636 <do_rw_disk+e6/310>
Trace; c01ad24a <ide_wait_stat+da/130>
Trace; c01ad530 <start_request+180/250>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01199d6 <del_timer+16/40>
Trace; c0115786 <do_exit+46/1f0>
Trace; c01087f6 <do_IRQ+56/a0>
Trace; c0108815 <do_IRQ+75/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c01b1778 <ide_build_dmatable+28/180>
Trace; c01ac445 <ide_set_handler+55/60>
Trace; c01b1d6c <ide_dmaproc+13c/260>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Trace; c01ad530 <start_request+180/250>
Trace; c01ad768 <ide_do_request+108/320>
Trace; c01addf3 <ide_intr+103/170>
Trace; c01b14e0 <ide_dma_intr+0/b0>
Trace; c0108669 <handle_IRQ_event+39/80>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c01199d6 <del_timer+16/40>
Trace; c0115786 <do_exit+46/1f0>
Trace; c0116af3 <do_softirq+53/a0>
Trace; c0108825 <do_IRQ+85/a0>
Trace; c010a958 <call_do_IRQ+5/d>
Trace; c01077ea <die+4a/50>
Trace; c010f462 <do_page_fault+142/520>
Trace; c010f320 <do_page_fault+0/520>
Trace; c0107344 <error_code+34/40>
Trace; c010f320 <do_page_fault+0/520>
Trace; c010f48b <do_page_fault+16b/520>
Code;  c01101c6 <__wake_up+26/a0>
00000000 <_EIP>:
Code;  c01101c6 <__wake_up+26/a0>   <=3D=3D=3D=3D=3D
   0:   8b 01                     mov    (%ecx),%eax   <=3D=3D=3D=3D=3D
Code;  c01101c8 <__wake_up+28/a0>
   2:   85 45 ec                  test   %eax,0xffffffec(%ebp)
Code;  c01101cb <__wake_up+2b/a0>
   5:   74 24                     je     2b <_EIP+0x2b> c01101f1 <__wake_=
up+51/a0>
Code;  c01101cd <__wake_up+2d/a0>
   7:   b8 00 00 00 00            mov    $0x0,%eax
Code;  c01101d2 <__wake_up+32/a0>
   c:   9c                        pushf  =

Code;  c01101d3 <__wake_up+33/a0>
   d:   5e                        pop    %esi
Code;  c01101d4 <__wake_up+34/a0>
   e:   fa                        cli    =

Code;  c01101d5 <__wake_up+35/a0>
   f:   8b 51 3c                  mov    0x3c(%ecx),%edx
Code;  c01101d8 <__wake_up+38/a0>
  12:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

<4> <0>Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.
