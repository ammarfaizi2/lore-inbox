Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRHSFI5>; Sun, 19 Aug 2001 01:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270009AbRHSFIt>; Sun, 19 Aug 2001 01:08:49 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:14353 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S268017AbRHSFId>; Sun, 19 Aug 2001 01:08:33 -0400
Date: Sun, 19 Aug 2001 13:10:02 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Paul <set@pobox.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819004703.A226@squish.home.loc>
Message-ID: <Pine.LNX.4.33.0108191309470.6458-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xdos runs fine for me for all of 2.4.x. Mine is P3.

Thanks,
Jeff
[ jchua@fedex.com ]

On Sun, 19 Aug 2001, Paul wrote:

> * Kernel oops, and locks up when I run xdos (dosemu)
>
> * Occuring in both 2.4.7-ac6 and 2.4.8-ac7. Run 'xdos' in X, and
>   machine locks hard, only output to console is oops. (no sysrq)
>   Tried once with strace, but no oops. (didnt wait long, though)
>   Some oops before window is placed, some a little while after.
>   (mouse movement?) Repeatable.
>
> * Kernels are virgin linus patched with ac. AMD-K6(tm) 3D
>   processor
>
> * If anyone wants any more info or for me to do anything, just
>   ask.
>
> Paul
> set@pobox.com
>
> (2.4.7-ac6 -- two captured, identitcal, first shown)
>
> ksymoops 2.4.1 on i586 2.4.7-ac6.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.7-ac6/ (default)
>      -m /boot/System.map-2.4.7-ac6 (specified)
>
> CPU:    0
> EIP:    0010:[<c0180a18>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: 00001000   ebx: c4562368   ecx: 00000000   edx: 00000001
> esi: c4562368   edi: c4a954d4   ebp: 00000001   esp: c6887d88
> ds: 008   es: 0000   ss: 0018
> Process xdos (pid: 28039, stackpage=c6887000)
> Stack: c4562768 c4562368 00000001 00000000 c4562000 c4a954d4 00000202 00000001
>        00000001 c0181815 c4562000 c4562568 c4562168 00000001 00000000 0000000e
>        00000001 00000202 00000000 00000282 0000000e c0117554 0000000e 00000001
> Call Trace: [<c0181815>] [<c0117554>] [<c01173cc>] [<c01174ac>] [<c017fc3f>]
>    [<c0113e24>] [<c01163f6>] [<c0113d7e>] [<c0113c61>] [<c01139fb>] [<c0107ece>]
>    [<c010760c>] [<c0109cfe>] [<c010760c>] [<c0106bed>] [<c0106ad3>]
> Code: a4 8b 7c 24 1c 8b 8c 24 b0 00 00 00 01 d3 29 d5 ba 00 10 00
>
> >>EIP; c0180a18 <n_tty_receive_buf+a4/edc>   <=====
> Trace; c0181815 <n_tty_receive_buf+ea1/edc>
> Trace; c0117554 <send_sig_info+74/98>
> Trace; c01173cc <send_signal+2c/f0>
> Trace; c01174ac <deliver_signal+1c/50>
> Trace; c017fc3f <flush_to_ldisc+db/e4>
> Trace; c0113e24 <__run_task_queue+4c/60>
> Trace; c01163f6 <tqueue_bh+16/1c>
> Trace; c0113d7e <bh_action+1a/30>
> Trace; c0113c61 <tasklet_hi_action+51/b4>
> Trace; c01139fb <do_softirq+5b/ac>
> Trace; c0107ece <do_IRQ+9e/b0>
> Trace; c010760c <do_general_protection+0/6c>
> Trace; c0109cfe <call_do_IRQ+5/17>
> Trace; c010760c <do_general_protection+0/6c>
> Trace; c0106bed <error_code+2d/40>
> Trace; c0106ad3 <system_call+33/40>
> Code;  c0180a18 <n_tty_receive_buf+a4/edc>
> 00000000 <_EIP>:
> Code;  c0180a18 <n_tty_receive_buf+a4/edc>   <=====
>    0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
> Code;  c0180a19 <n_tty_receive_buf+a5/edc>
>    1:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
> Code;  c0180a1d <n_tty_receive_buf+a9/edc>
>    5:   8b 8c 24 b0 00 00 00      mov    0xb0(%esp,1),%ecx
> Code;  c0180a24 <n_tty_receive_buf+b0/edc>
>    c:   01 d3                     add    %edx,%ebx
> Code;  c0180a26 <n_tty_receive_buf+b2/edc>
>    e:   29 d5                     sub    %edx,%ebp
> Code;  c0180a28 <n_tty_receive_buf+b4/edc>
>   10:   ba 00 10 00 00            mov    $0x1000,%edx
>
>  <0>Kernel panic: Aiee, killing interrupt handler!
>
> ===================================================================
>
> (2.4.8-ac7)
>
> ksymoops 2.4.1 on i586 2.4.8-ac7.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.8-ac7/ (default)
>      -m /boot/System.map-2.4.8-ac7 (specified)
>
> CPU:    0
> EIP:    0010:[<c0180ab8>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: 00001000   ebx: c77dc168   ecx: 00000000   edx: 00000001
> esi: c77dc168   edi: c524c1aa   ebp: 00000001   esp: c7195d88
> ds: 0018   es: 0000   ss: 0018
> Process xdos (pid: 252, stackpage=c7195000)
> Stack: c77dc568 c77dc168 00000000 00000000 00000046 c7195dbc 00000202 00000001
>        007dc000 c524c1aa c77dc984 00000282 00000001 c01818b5 c77dc000 c77dc768
>       c77dc368 00000000 00000000 00000286 0000000e 00000202 00000000 00000001
> Call Trace: [<c01818b5>] [<c0112fe4>] [<c011735c>] [<c011743c>] [<c017fcdf>]
>    [<c0113d94>] [<c0116366>] [<c0113cde>] [<c0113c12>] [<c0113a3b>] [<c0107eee>]
>    [<c010762c>] [<c0109d1e>] [<c010762c>] [<c0106c0d>] [<c0106af3>]
> Code: a4 8b 7c 24 1c 8b 8c 24 b0 00 00 00 01 d3 29 d5 ba 00 10 00
>
> >>EIP; c0180ab8 <n_tty_receive_buf+a4/edc>   <=====
> Trace; c01818b5 <n_tty_receive_buf+ea1/edc>
> Trace; c0112fe4 <it_real_fn+0/44>
> Trace; c011735c <send_signal+2c/f0>
> Trace; c011743c <deliver_signal+1c/50>
> Trace; c017fcdf <flush_to_ldisc+db/e4>
> Trace; c0113d94 <__run_task_queue+4c/60>
> Trace; c0116366 <tqueue_bh+16/1c>
> Trace; c0113cde <bh_action+1a/40>
> Trace; c0113c12 <tasklet_hi_action+42/64>
> Trace; c0113a3b <do_softirq+5b/ac>
> Trace; c0107eee <do_IRQ+9e/b0>
> Trace; c010762c <do_general_protection+0/6c>
> Trace; c0109d1e <call_do_IRQ+5/17>
> Trace; c010762c <do_general_protection+0/6c>
> Trace; c0106c0d <error_code+2d/40>
> Trace; c0106af3 <system_call+33/40>
> Code;  c0180ab8 <n_tty_receive_buf+a4/edc>
> 00000000 <_EIP>:
> Code;  c0180ab8 <n_tty_receive_buf+a4/edc>   <=====
>    0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
> Code;  c0180ab9 <n_tty_receive_buf+a5/edc>
>    1:   8b 7c 24 1c               mov    0x1c(%esp,1),%edi
> Code;  c0180abd <n_tty_receive_buf+a9/edc>
>    5:   8b 8c 24 b0 00 00 00      mov    0xb0(%esp,1),%ecx
> Code;  c0180ac4 <n_tty_receive_buf+b0/edc>
>    c:   01 d3                     add    %edx,%ebx
> Code;  c0180ac6 <n_tty_receive_buf+b2/edc>
>    e:   29 d5                     sub    %edx,%ebp
> Code;  c0180ac8 <n_tty_receive_buf+b4/edc>
>   10:   ba 00 10 00 00            mov    $0x1000,%edx
>
>  <0>Kernel panic: Aiee, killing interrupt handler!
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

