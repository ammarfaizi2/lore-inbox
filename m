Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135257AbRAHRjw>; Mon, 8 Jan 2001 12:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135797AbRAHRjm>; Mon, 8 Jan 2001 12:39:42 -0500
Received: from user-141-246.jakinternet.co.uk ([212.187.141.246]:24302 "HELO
	aslak.demon.co.uk") by vger.kernel.org with SMTP id <S135669AbRAHRje>;
	Mon, 8 Jan 2001 12:39:34 -0500
Date: Mon, 8 Jan 2001 18:36:51 +0000 (GMT)
From: Lawrence Manning <lawrence@aslak.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.2.18
Message-ID: <Pine.LNX.4.21.0101081829370.1079-100000@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware is a Intel 440LX, with IDE disks, 96meg of memory, voodoo 2
graphics etc.  Nothing remarkable.

For about 3 days now, it has been oopsing at least once a day.  Each time
the machine eventually locks up in X.  The kernel is a standard 2.2.18
linus kernel with Alsa drivers (version 0.5.10) for the onboard soundcard,
a yamaha opl3-sa2.

I can supply a kernel config if needed.  Some sample oopses follow.  
Could replies be cc:d to me as I'm not on the list.

Cheers,

Lawrence

kernel: Unable to handle kernel NULL pointer dereference at virtual
address 00000013
kernel: current->tss.cr3 = 024fb000, %cr3 = 024fb000
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[elf_core_dump+128/3204]
kernel: EFLAGS: 00010286
kernel: eax: 3d090000   ebx: c42cffff   ecx: ffffffff   edx: c0aa6803
kernel: esi: ffffffff   edi: 0000000b   ebp: c24dc000   esp: c24ddc74
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process xfplay (pid: 5186, process nr: 107, stackpage=c24dd000)
kernel: Stack: 0000000b c24ddfc4 c42c3c60 3d090000 08048000 c5e2b3e0
40000000 c24ddee8
kernel:        00000000 c01297be 464c457f 00010101 00000000 ffffffff
00030003 00000001
kernel:        00001990 00000034 464c457f 00010101 c24dc000 00000000
00030003 00000001
kernel: Call Trace: [read_exec+194/316] [wake_up_process+58/68]
[kfree_skbmem+50/64] [__kfree_skb+161/168] [tcp_clean_rtx_queue+259/300]
[tcp_data_queue+212/776] [sock_def_readable+39/44]
kernel:        [tcp_data+239/256] [tcp_send_delayed_ack+57/92]
[tcp_rcv_established+1452/1496] [wake_up_process+58/68]
[wake_up_process+58/68] [kfree_skbmem+50/64] [__kfree_skb+161/168]
[tcp_clean_rtx_queue+259/300]
kernel:        [tcp_data_queue+212/776] [sock_def_readable+39/44]
[tcp_data+239/256] [tcp_send_delayed_ack+57/92]
[tcp_rcv_established+1452/1496] [setup_sigcontext+234/308]
[setup_frame+222/436] [send_sig_info+364/680]
kernel:        [kill_something_info+224/236] [do_signal+426/620]
[sys_sigreturn+170/208] [signal_return+20/24]
kernel: Code: 66 8b 5e 14 f6 c3 07 74 35 f6 c7 40 75 30 f7 c3 02 03 00 00

kernel: Unable to handle kernel NULL pointer dereference at virtual
address 00000007
kernel: current->tss.cr3 = 00101000, %cr3 = 00101000
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[exit_mmap+86/264]
kernel: EFLAGS: 00010286
kernel: eax: ffffffff   ebx: c42c2f20   ecx: ffffffff   edx: c3980dc0
kernel: esi: ffffffff   edi: c3980dc0   ebp: 00000000   esp: c24ddbac
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process xfplay (pid: 5186, process nr: 107, stackpage=c24dd000)
kernel: Stack: 00000013 ffffffff ffffffff c0111bef c3980dc0 c3980dc0
c3980dc0 c011649f
kernel:        c3980dc0 c24ddc38 c24dc000 00000013 ffffffff c0108e73
c24dc000 c0108e78
kernel:        0000000b c24ddc38 c01e5e36 c01e786e 00000000 00000000
c010e0f0 c01e786e
kernel: Call Trace: [mmput+27/52] [do_exit+179/620] [die+51/56]
[die_if_no_fixup+0/64] [error_table+2646/9632] [error_table+9358/9632]
[do_page_fault+708/944]
kernel:        [error_table+9358/9632] [error_code+45/52]
[elf_core_dump+128/3204] [read_exec+194/316] [wake_up_process+58/68]
[kfree_skbmem+50/64] [__kfree_skb+161/168] [tcp_clean_rtx_queue+259/300]
kernel:        [tcp_data_queue+212/776] [sock_def_readable+39/44]
[tcp_data+239/256] [tcp_send_delayed_ack+57/92]
[tcp_rcv_established+1452/1496] [wake_up_process+58/68]
[wake_up_process+58/68] [kfree_skbmem+50/64]
kernel:        [__kfree_skb+161/168] [tcp_clean_rtx_queue+259/300]
[tcp_data_queue+212/776] [sock_def_readable+39/44] [tcp_data+239/256]
[tcp_send_delayed_ack+57/92] [tcp_rcv_established+1452/1496]
[setup_sigcontext+234/308]
kernel:        [setup_frame+222/436] [send_sig_info+364/680]
[kill_something_info+224/236] [do_signal+426/620] [sys_sigreturn+170/208]
[signal_return+20/24]
kernel: Code: 8b 50 08 85 d2 74 0b 55 56 53 ff d2 83 c4 0c 8b 43 28 8b 40


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
