Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTH3Ru6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTH3Ru6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:50:58 -0400
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:52105 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261899AbTH3Rux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:50:53 -0400
Date: Sat, 30 Aug 2003 18:42:21 +0100
From: Dave Bentham <dave.bentham@ntlworld.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre2
Message-Id: <20030830184221.46cf29c4.dave.bentham@ntlworld.com>
In-Reply-To: <Pine.LNX.4.55L.0308301401560.31588@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0308301401560.31588@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__30_Aug_2003_18:42:21_+0100_082ebee0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__30_Aug_2003_18:42:21_+0100_082ebee0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2003 14:06:55 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> > Last Wednesday I posted here that when mounting /dev/scd0 CDROM
> > (hdd=ide-scsi) the new kernel 2.4.22 panicked as 2.4.21 did before
> > that. 2.4.20 is fine in this regard. If I remove the 'hdd=ide-scsi'
> > appendage then my CD is fine.
> 
> Can you please show us all the boot messages before panic?
> 

For now I've attached the original 2.4.21 oops report. It may a
couple of days before I can get round to recapture the stuff for 2.4.22.
Let me know if the 2.4.21 oops is not good enough...


> > Someone has also reported his SCSI Megaraid killed the 2.4.22 too,
> > looking a similar, if not the same, issue.
> 
> I've seen the report but havent looked into it in detail. Will do so
> now.
> 
> > So far there's been no response.
> 
> > It looked to me (a layman as far as the kernel software is
> > concerned) that email's after the 2.4.21 SCSI problem were posted
> > and that the issue was being looked at and even perhaps fixed. Is it
> > believed to have been fixed in 2.4.22 (i.e. I've not built my kernel
> > properly) or is it still a known problem?
> 
> I didnt knew of this problem. Please show the boot messages before
> panic. Also identifying which 2.4.21-pre started the problems is
> helpful.-

I've never installed any -pre or -rc kernels before - just the released
versions. I'm not a kernel developer person - I just want stable kernels
to do my stuff on.

I hope this isn't too unhelpful,

Dave

--Multipart_Sat__30_Aug_2003_18:42:21_+0100_082ebee0
Content-Type: text/plain;
 name="oops2.txt"
Content-Disposition: attachment;
 filename="oops2.txt"
Content-Transfer-Encoding: 7bit

ksymoops 2.4.5 on i686 2.4.21.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /var/log/ksyms.3 (specified)
     -L (specified)
     -o /lib/modules/2.4.21/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000                                                                                
*pde = 00000000               
Oops: 0000          
CPU:    0         
EIP:    0010:[<00000000>]    Not tainted                                        
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202                
eax: c02ecab4   ebx: c02ecca0   ecx: 00000000   edx: 00000170                                                             
esi: cf6f0d60   edi: c12cee80   ebp: cf223a8c   esp: cf223a64                                                             
ds: 0018   es: 0018   ss: 0018                              
Process mount (pid: 2255, stackpage=cf223000)                                             
Stack: c01d8054 c02ecca0 cf6f0d60 0000000c 00000000 000001f4 c12cee80 c02ecca0                                                                              
       00000040 00000000 cf223ac0 c01c21e2 c02ecca0 cf6f0d                                                         
       000001f4 c02ecca0 00000000 00000002 c02ecca0 cff3f260 cf237ea0 cf223ae4                                                                              
Call Trace:    [<c01d8054>] [<c01c21e2>] [<c01c235e>] [<c01c2a2f>] [<c01d8cd4>]                                                                               
  [<c01cd575>] [<c01d2dc0>] [<c01d2b30>] [<c01d4845>] [<c01d2b30>] [<c01d3d35>]                                                                               
  [<c01d3dc9>] [<c01cd6a5>] [<c01ccff0>] [<c01dac15>] [<c01dbe8b>] [<c01d9455>]                                                                               
  [<c01e2c2e>] [<c01e2ca2>] [<c013f45a>] [<c01d9bd8>] [<c01e236a>] [<c01e21c1>]                                                                               
  [<c013abdf>] [<c013f671>] [<c013f6ff>] [<c017d276>] [<c013e17c>] [<c013e583>]                                                                               
  [<c015064d>] [<c0150945>] [<c01507                                   
Code:  Bad EIP value.                     


>>EIP; 00000000 Before first symbol

>>eax; c02ecab4 <ide_hwifs+454/2b48>
>>ebx; c02ecca0 <ide_hwifs+640/2b48>
>>esi; cf6f0d60 <_end+f3fe9c8/10511cc8>
>>edi; c12cee80 <_end+fdcae8/10511cc8>
>>ebp; cf223a8c <_end+ef316f4/10511cc8>
>>esp; cf223a64 <_end+ef316cc/10511cc8>

Trace; c01d8054 <idescsi_transfer_pc+124/130>
Trace; c01c21e2 <start_request+192/210>
Trace; c01c235e <ide_do_request+ae/190>
Trace; c01c2a2f <ide_do_drive_cmd+af/100>
Trace; c01d8cd4 <idescsi_queue+194/2a0>
Trace; c01cd575 <scsi_dispatch_cmd+195/260>
Trace; c01d2dc0 <scsi_old_done+0/650>
Trace; c01d2b30 <scsi_old_times_out+0/140>
Trace; c01d4845 <scsi_request_fn+1a5/360>
Trace; c01d2b30 <scsi_old_times_out+0/140>
Trace; c01d3d35 <__scsi_insert_special+55/80>
Trace; c01d3dc9 <scsi_insert_special_req+29/30>
Trace; c01cd6a5 <scsi_wait_req+65/b0>
Trace; c01ccff0 <scsi_wait_done+0/20>
Trace; c01dac15 <sr_do_ioctl+c5/310>
Trace; c01dbe8b <sr_cd_check+1bb/230>
Trace; c01d9455 <sr_media_change+b5/f0>
Trace; c01e2c2e <media_changed+5e/90>
Trace; c01e2ca2 <cdrom_media_changed+42/50>
Trace; c013f45a <check_disk_change+4a/e0>
Trace; c01d9bd8 <sr_open+18/f0>
Trace; c01e236a <open_for_data+12a/350>
Trace; c01e21c1 <cdrom_open+71/f0>
Trace; c013abdf <getblk+4f/60>
Trace; c013f671 <do_open+121/150>
Trace; c013f6ff <blkdev_get+5f/70>
Trace; c017d276 <devfs_get_ops+76/90>
Trace; c013e17c <get_sb_bdev+ec/280>
Trace; c013e583 <do_kern_mount+123/140>
Trace; c015064d <do_add_mount+8d/180>
Trace; c0150945 <do_mount+145/190>

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010203
eax: c02ecab4   ebx: c02ecca0   ecx: 00000000   edx: 00000170
esi: cf6f0d60   edi: c12cee80   ebp: c02b3e94   esp: c02b3e6c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02b3000)
Stack: c01d8054 c02ecca0 cf6f0d60 0000000c 00000000 000001f4 c12cee80 c02ecca0
       00000040 00000000 c02b3ec8 c01c21e2 c02ecca0 cf6f0d60 00000000 00000088
       000001f4 c02b3eec 00000000 00000018 c02ecca0 cff3f260 cf237ea0 c02b3eec
Call Trace:    [<c01d8054>] [<c01c21e2>] [<c01c235e>] [<c01c260c>] [<c01172a0>]
  [<c01c2520>] [<c0122a9b>] [<c01221f6>] [<c011eff2>] [<c011eee6>] [<c011ed16>]
  [<c010a9b0>] [<c0107250>] [<c010d038>] [<c0107250>] [<c0107273>] [<c0107302>]
  [<c0105000>]
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c02ecab4 <ide_hwifs+454/2b48>
>>ebx; c02ecca0 <ide_hwifs+640/2b48>
>>esi; cf6f0d60 <_end+f3fe9c8/10511cc8>
>>edi; c12cee80 <_end+fdcae8/10511cc8>
>>ebp; c02b3e94 <init_task_union+1e94/2000>
>>esp; c02b3e6c <init_task_union+1e6c/2000>

Trace; c01d8054 <idescsi_transfer_pc+124/130>
Trace; c01c21e2 <start_request+192/210>
Trace; c01c235e <ide_do_request+ae/190>
Trace; c01c260c <ide_timer_expiry+ec/1c0>
Trace; c01172a0 <process_timeout+0/20>
Trace; c01c2520 <ide_timer_expiry+0/1c0>
Trace; c0122a9b <run_timer_list+10b/170>
Trace; c01221f6 <update_wall_time+16/40>
Trace; c011eff2 <bh_action+22/50>
Trace; c011eee6 <tasklet_hi_action+46/70>
Trace; c011ed16 <do_softirq+a6/b0>
Trace; c010a9b0 <do_IRQ+b0/c0>
Trace; c0107250 <default_idle+0/40>
Trace; c010d038 <call_do_IRQ+5/d>
Trace; c0107250 <default_idle+0/40>
Trace; c0107273 <default_idle+23/40>
Trace; c0107302 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>

 <0>Kernel panic: Aiee, killing interrupt handler!


--Multipart_Sat__30_Aug_2003_18:42:21_+0100_082ebee0--
