Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQL2RLI>; Fri, 29 Dec 2000 12:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQL2RK6>; Fri, 29 Dec 2000 12:10:58 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:7440 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129345AbQL2RKt>; Fri, 29 Dec 2000 12:10:49 -0500
From: "Soeren Sonnenburg" <sonnenburg@informatik.hu-berlin.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12-reiserfs oops in <ip_frag_queue+20a/254>
Date: Fri, 29 Dec 2000 17:54:49 +0100
Message-ID: <NCBBIODJDAHHMNHHMKLAAEIDEPAA.sonnenburg@informatik.hu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...happens when http browsing the net (occurs regularly within 1 hour)...

server:~# ksymoops -m /boot/System.map <dump
ksymoops 2.3.4 on i586 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map (specified)

server login: Unable to handle kernel NULL pointer dereference at virtual
address 0000003c
 c020af5e
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[<c020af5e>]
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00210246
 eax: 00000000   ebx: 00000000   ecx: c28f5f60   edx: c28f5f60
 esi: 000005c0   edi: c6ec75c0   ebp: 00000570   esp: c02adbec
 ds: 0018   es: 0018   ss: 0018
 Process swapper (pid: 0, stackpage=c02ad000)
 Stack: c28f5f60 00000000 0000a876 46aa9b3e 00000014 00000000 c020b2e3
c28f5f60
        c6ec75c0 c12ef680 c6ec75c0 c020db98 c02adcf0 012adc30 00000000
c022ca70
               c6ec75c0 c02adce0 c030dfd8 c022c389 c6ec75c0 c02adce0
c030dfd8 c020db98
               Call Trace: [<c020b2e3>] [<c020db98>] [<c022ca70>]
[<c022c389>] [<c020db98>] [<c011e7b9>] [<c022960e>]
                      [<c020db98>] [<c01f101c>] [<c020db98>] [<c020db98>]
[<c01f1233>] [<c020db98>] [<c020d1d9>] [<c020db98>]
                            [<c0222fd8>] [<c020d2ee>] [<c0222fd8>]
[<c02231cc>] [<c0222fd8>] [<c02236fa>] [<f0debc9a>] [<c01f
23e6>]
                                 [<c022394d>] [<c020a2cb>] [<c020a817>]
[<c020a780>] [<c01f126d>] [<c020a416>] [<c020a780>] [
<c020aa5f>]
                                     [<c020a878>] [<c01f126d>] [<c020a746>]
[<c020a878>] [<c01f4bab>] [<c011b900>] [<c010ba42
>] [<c0108ad0>]
                                        [<ffffe000>] [<c010a7a0>]
[<c0108ad0>] [<ffffe000>] [<c0108af3>] [<c0108b57>] [<c0105
000>] [<c0100191>]
                                   Code: 8b 40 3c 89 41 3c 8b 47 5c c7 47 18
00 00 00 00 01 41 18 8b

>>EIP; c020af5e <ip_frag_queue+20a/254>   <=====
Trace; c020b2e3 <ip_defrag+b7/134>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c022ca70 <ip_ct_gather_frags+1c/90>
Trace; c022c389 <ip_conntrack_in+39/2c0>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c011e7b9 <update_process_times+1d/90>
Trace; c022960e <ip_conntrack_local+52/58>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c01f101c <nf_iterate+30/84>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c01f1233 <nf_hook_slow+3f/ac>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c020d1d9 <ip_build_xmit_slow+3b1/478>
Trace; c020db98 <output_maybe_reroute+0/14>
Trace; c0222fd8 <icmp_glue_bits+0/88>
Trace; c020d2ee <ip_build_xmit+4e/318>
Trace; c0222fd8 <icmp_glue_bits+0/88>
Trace; c02231cc <icmp_reply+16c/188>
Trace; c0222fd8 <icmp_glue_bits+0/88>
Trace; c02236fa <icmp_echo+3e/48>
Trace; f0debc9a <END_OF_CODE+2859005f/????>
Trace; c01f23e6 <sock_def_readable+26/4c>
Trace; c022394d <icmp_rcv+9d/d0>
Trace; c020a2cb <ip_run_ipprot+5f/70>
Trace; c020a817 <ip_local_deliver_finish+97/f8>
Trace; c020a780 <ip_local_deliver_finish+0/f8>
Trace; c01f126d <nf_hook_slow+79/ac>
Trace; c020a416 <ip_local_deliver+13a/144>
Trace; c020a780 <ip_local_deliver_finish+0/f8>
Trace; c020aa5f <ip_rcv_finish+1e7/218>
Trace; c020a878 <ip_rcv_finish+0/218>
Trace; c01f126d <nf_hook_slow+79/ac>
Trace; c020a746 <ip_rcv+326/360>
Trace; c020a878 <ip_rcv_finish+0/218>
Trace; c01f4bab <net_rx_action+19b/278>
Trace; c011b900 <do_softirq+40/64>
Trace; c010ba42 <do_IRQ+a2/b0>
Trace; c0108ad0 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+377a23c5/????>
Trace; c010a7a0 <ret_from_intr+0/20>
Trace; c0108ad0 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+377a23c5/????>
Trace; c0108af3 <default_idle+23/28>
Trace; c0108b57 <cpu_idle+3f/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  c020af5e <ip_frag_queue+20a/254>
00000000 <_EIP>:
Code;  c020af5e <ip_frag_queue+20a/254>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c020af61 <ip_frag_queue+20d/254>
   3:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c020af64 <ip_frag_queue+210/254>
   6:   8b 47 5c                  mov    0x5c(%edi),%eax
Code;  c020af67 <ip_frag_queue+213/254>
   9:   c7 47 18 00 00 00 00      movl   $0x0,0x18(%edi)
Code;  c020af6e <ip_frag_queue+21a/254>
  10:   01 41 18                  add    %eax,0x18(%ecx)
Code;  c020af71 <ip_frag_queue+21d/254>
  13:   8b 00                     mov    (%eax),%eax

                                   Aiee, killing interrupt handler
                                   Kernel panic: Attempted to kill the idle
task!
--
If you talk to God, you are praying; if God talks to you, you have
schizophrenia. -- Thomas Szasz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
