Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264303AbRFHTcg>; Fri, 8 Jun 2001 15:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264310AbRFHTcZ>; Fri, 8 Jun 2001 15:32:25 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:30218 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S264303AbRFHTcM>; Fri, 8 Jun 2001 15:32:12 -0400
Date: Fri, 8 Jun 2001 12:32:10 -0700 (PDT)
From: Paul Buder <paulb@aracnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Large ramdisk crashes system
In-Reply-To: <Pine.LNX.4.21.0106071847040.1156-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106081223030.17187-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Marcelo Tosatti wrote:

> On Thu, 7 Jun 2001, Paul Buder wrote:
>
> > I am trying to create a system which boots off of a cd and has no hard
> > disks.  So it needs ramdisks.  But I haven't had much luck creating
> > large ones.

[ explanation of large ram disks crashing the system edited out
for brevity]
>
> Can you get the (traced by ksymoops) backtrace of dd and kswapd
> everything is locked?
>
> You can do that with sysrq.


I copied the sysreq-t screen to paper and then typed it up and fed
it to ksymoops.  I get some errors since this kernel has module support
turned off. I also get a message from ksymoops saying
Warning (Oops_read): Code line not seen, dumping what data is available
which I'm not sure of the meaning. So anyway, my oops file and
the output from ksymoops follow.  Hopefully I've done this right.
If there is anything else I can provide let me know.


kswapd    R f7d5abfc   0     3      1        (L-TLB)       4     2
Call Trace: c010fd6b>] [<c010fd6b>] [<c0162bab>] [<c01964c1>] [<c019d90e>] [<c019d804>] [<c0117d8c>]
[<c010e526>] [<c01247e4>] [<c01247e4>] [<c010e030>] [<c01247e4>] [<c010deab>] [<c01260aa>] [<c0126115>]
[<c0126299>] [<c0126349>] [<c01263dc>] [<c011153f>] [<c012727d>] [<c0127459>] [<c01274d2>] [<c012753b>]
[<c01056d0>]
dd        R current     756   249   187        (NOTLB)
Call Trace: [<c015c184>] [<c01964c1>] [<c019ddab>] [<c019d804>] [<c0194799>] [<c01974f2>] [<c011043e>]
[<c012e4e5>] [<c0173b8b>] [<c0173bbf>] [<c0173bd9>] [<c01964c1>] [<c019ddab>] [<c019d804>] [<c0197499>]
[<c01974f2>] [<c020e742>] [<c01e81b0>] [<c020956b>] [<c01df693>] [<c01d923d>] [<c01e8253>] [<c01df143>]
[<c01e6da2>] [<c01e81b0>] [<c01e81a9>] [<c01df143>] [<c01e7a5f>] [<c01e819c>] [<c0201c1c>] [<c0201a2c>]
[<c0201c30>] [<c0202322>] [<c017184c>] [<c016be8f>] [<c016b159>] [<c01150ea>] [<c012f88a>] [<c017184c>]
[<c01c5df0>] [<c0167ff2>] [<c016b464>] [<c0112d86>] [<c0112d86>] [<f8800000>] [<c01071d8>] [<c01071d8>]
[<c0107207>] [<c0111033>] [<c01110ee>] [<c017307f>] [<c0171747>] [<c01728bd>] [<c0172948>] [<c01085f0>]
[<c01087d7>] [<c0106f40>] [<c021ce04>] [<c0122880>] [<c012d7aa>] [<c0106e67>]



ksymoops 2.4.1 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: c010fd6b>] [<c010fd6b>] [<c0162bab>] [<c01964c1>] [<c019d90e>] [<c019d804>] [<c0117d8c>]
[<c010e526>] [<c01247e4>] [<c01247e4>] [<c010e030>] [<c01247e4>] [<c010deab>] [<c01260aa>] [<c0126115>]
[<c0126299>] [<c0126349>] [<c01263dc>] [<c011153f>] [<c012727d>] [<c0127459>] [<c01274d2>] [<c012753b>]
[<c01056d0>]
Call Trace: [<c015c184>] [<c01964c1>] [<c019ddab>] [<c019d804>] [<c0194799>] [<c01974f2>] [<c011043e>]
[<c012e4e5>] [<c0173b8b>] [<c0173bbf>] [<c0173bd9>] [<c01964c1>] [<c019ddab>] [<c019d804>] [<c0197499>]
[<c01974f2>] [<c020e742>] [<c01e81b0>] [<c020956b>] [<c01df693>] [<c01d923d>] [<c01e8253>] [<c01df143>]
[<c01e6da2>] [<c01e81b0>] [<c01e81a9>] [<c01df143>] [<c01e7a5f>] [<c01e819c>] [<c0201c1c>] [<c0201a2c>]
[<c0201c30>] [<c0202322>] [<c017184c>] [<c016be8f>] [<c016b159>] [<c01150ea>] [<c012f88a>] [<c017184c>]
[<c01c5df0>] [<c0167ff2>] [<c016b464>] [<c0112d86>] [<c0112d86>] [<f8800000>] [<c01071d8>] [<c01071d8>]
[<c0107207>] [<c0111033>] [<c01110ee>] [<c017307f>] [<c0171747>] [<c01728bd>] [<c0172948>] [<c01085f0>]
[<c01087d7>] [<c0106f40>] [<c021ce04>] [<c0122880>] [<c012d7aa>] [<c0106e67>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c010fd6b <reschedule_idle+63/214>
Trace; c010e526 <smp_apic_timer_interrupt+ea/fc>
Trace; c01247e4 <do_ccupdate_local+0/34>
Trace; c01247e4 <do_ccupdate_local+0/34>
Trace; c010e030 <smp_call_function+8c/c4>
Trace; c01247e4 <do_ccupdate_local+0/34>
Trace; c010deab <flush_tlb_page+7b/84>
Trace; c01260aa <try_to_swap_out+9a/1b4>
Trace; c0126115 <try_to_swap_out+105/1b4>
Trace; c0126299 <swap_out_pmd+d5/f0>
Trace; c0126349 <swap_out_vma+95/d8>
Trace; c01263dc <swap_out_mm+50/7c>
Trace; c011153f <mmput+13/50>
Trace; c012727d <refill_inactive_scan+f1/160>
Trace; c0127459 <refill_inactive+6d/a4>
Trace; c01274d2 <do_try_to_free_pages+42/58>
Trace; c012753b <kswapd+53/e0>
Trace; c01056d0 <kernel_thread+28/38>
Trace; c015c184 <do_tty_hangup+0/314>
Trace; c01964c1 <ide_set_handler+61/74>
Trace; c019ddab <do_rw_disk+12f/2e8>
Trace; c019d804 <read_intr+0/11c>
Trace; c0194799 <drm_dma_takedown+1d9/1e4>
Trace; c01974f2 <start_request+182/1f0>
Trace; c011043e <schedule+3aa/5ac>
Trace; c012e4e5 <__wait_on_buffer+85/94>
Trace; c0173b8b <__make_request+15b/6bc>
Trace; c0173bbf <__make_request+18f/6bc>
Trace; c0173bd9 <__make_request+1a9/6bc>
Trace; c01964c1 <ide_set_handler+61/74>
Trace; c019ddab <do_rw_disk+12f/2e8>
Trace; c019d804 <read_intr+0/11c>
Trace; c0197499 <start_request+129/1f0>
Trace; c01974f2 <start_request+182/1f0>
Trace; c020e742 <ip_nat_fn+1a2/1ac>
Trace; c01e81b0 <ip_finish_output2+0/dc>
Trace; c020956b <ip_refrag+23/54>
Trace; c01df693 <qdisc_restart+13/178>
Trace; c01d923d <dev_queue_xmit+10d/258>
Trace; c01e8253 <ip_finish_output2+a3/dc>
Trace; c01df143 <nf_hook_slow+11b/180>
Trace; c01e6da2 <ip_output+126/130>
Trace; c01e81b0 <ip_finish_output2+0/dc>
Trace; c01e81a9 <output_maybe_reroute+d/14>
Trace; c01df143 <nf_hook_slow+11b/180>
Trace; c01e7a5f <ip_build_xmit+2df/36c>
Trace; c01e819c <output_maybe_reroute+0/14>
Trace; c0201c1c <icmp_reply+16c/188>
Trace; c0201a2c <icmp_glue_bits+0/84>
Trace; c0201c30 <icmp_reply+180/188>
Trace; c0202322 <icmp_echo+4a/54>
Trace; c017184c <handle_scancode+2ac/2e8>
Trace; c016be8f <poke_blanked_console+57/5c>
Trace; c016b159 <console_softint+81/d4>
Trace; c01150ea <tasklet_action+4e/7c>
Trace; c012f88a <bread+16/60>
Trace; c017184c <handle_scancode+2ac/2e8>
Trace; c01c5df0 <vgacon_cursor+1a8/1b0>
Trace; c0167ff2 <set_cursor+6e/80>
Trace; c016b464 <vt_console_print+2b8/2d0>
Trace; c0112d86 <printk+176/184>
Trace; c0112d86 <printk+176/184>
Trace; f8800000 <END_OF_CODE+384f734c/????>
Trace; c01071d8 <show_trace+88/a8>
Trace; c01071d8 <show_trace+88/a8>
Trace; c0107207 <show_trace_task+f/14>
Trace; c0111033 <show_task+15b/160>
Trace; c01110ee <show_state+3e/58>
Trace; c017307f <handle_sysrq+15f/230>
Trace; c0171747 <handle_scancode+1a7/2e8>
Trace; c01728bd <handle_kbd_event+121/190>
Trace; c0172948 <keyboard_interrupt+1c/28>
Trace; c01085f0 <handle_IRQ_event+58/84>
Trace; c01087d7 <do_IRQ+a7/f8>
Trace; c0106f40 <ret_from_intr+0/20>
Trace; c021ce04 <stext_lock+1514/6de8>
Trace; c0122880 <generic_file_write+498/540>
Trace; c012d7aa <sys_write+8e/c4>
Trace; c0106e67 <system_call+37/40>


1 warning and 1 error issued.  Results may not be reliable.

