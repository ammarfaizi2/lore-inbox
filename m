Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbRGUPWs>; Sat, 21 Jul 2001 11:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267676AbRGUPWj>; Sat, 21 Jul 2001 11:22:39 -0400
Received: from sun.rhrk.uni-kl.de ([131.246.137.50]:22512 "HELO
	sun.rhrk.uni-kl.de") by vger.kernel.org with SMTP
	id <S267672AbRGUPWS>; Sat, 21 Jul 2001 11:22:18 -0400
Date: Sat, 21 Jul 2001 17:22:19 +0200
From: Martin Vogt <mvogt@rhrk.uni-kl.de>
To: Guest section DW <dwguest@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.6 segfault in scsi sr.c
Message-ID: <20010721172219.A122976@rhrk.uni-kl.de>
In-Reply-To: <20010719095750.B36012@rhrk.uni-kl.de> <20010719123801.A6750@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010719123801.A6750@win.tue.nl>; from dwguest@win.tue.nl on Thu, Jul 19, 2001 at 12:38:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



Hello,


>I have an Adaptec AIC-7881U (rev 1) controller and kernel 2.4.6. 
>When I try to mount a CD the kernel segfaults. 
>This is the lines it prints: 
>
>sr0: unsupported sector size 2336. 

and here is the requested ksyms thing output.

I hope this helps.

Martin


ksymoops 2.4.1 on i586 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) n
ot found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c683a61f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c683a61f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000920   ecx: c5fcfc00   edx: c4e6de00
esi: c4e6da00   edi: c4e6db04   ebp: 00000000   esp: c1941d5c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 2201, stackpage=c1941000)
Stack: 00000800 c5fcfc00 c4e6da00 c5fcfc58 c4e6db04 c4e6da00 c0193bcb c4e6da00 
       c683cbc0 c5fe57e0 c11e2360 00000000 00000282 c1941db0 c1941de8 00000010 
       c017e5fe c11e2378 c1941db0 c0116f18 c11e2378 c11e23dc c11e23dc c5483800 
Call Trace: [<c0193bcb>] [<c017e5fe>] [<c0116f18>] [<c0130256>] [<c0131444>] [<c
015dadd>] [<c018fa9e>] 
       [<c013441f>] [<c013463f>] [<c01394fe>] [<c0134f33>] [<c0135233>] [<c0129d
58>] [<c01350de>] [<c01352c4>] 
       [<c0106d23>] 
Code: 0f b6 40 18 50 e8 37 1a 00 00 58 5a eb 0b 68 c0 c4 83 c6 e8 

>>EIP; c683a61f <[ide-mod].bss.end+1da0/5781>   <=====
Trace; c0193bcb <scsi_request_fn+25b/300>
Trace; c017e5fe <generic_unplug_device+1e/30>
Trace; c0116f18 <__run_task_queue+48/70>
Trace; c0130256 <__wait_on_buffer+56/90>
Trace; c0131444 <bread+44/80>
Trace; c015dadd <isofs_read_super+12d/690>
Trace; c018fa9e <scsi_ioctl+41e/460>
Trace; c013441f <read_super+5f/b0>
Trace; c013463f <get_sb_bdev+14f/1a0>
Trace; c01394fe <cached_lookup+e/50>
Trace; c0134f33 <do_add_mount+103/250>
Trace; c0135233 <do_mount+f3/110>
Trace; c0129d58 <__alloc_pages+68/270>
Trace; c01350de <copy_mount_options+5e/c0>
Trace; c01352c4 <sys_mount+74/c0>
Trace; c0106d23 <system_call+33/40>
Code;  c683a61f <[ide-mod].bss.end+1da0/5781>
00000000 <_EIP>:
Code;  c683a61f <[ide-mod].bss.end+1da0/5781>   <=====
   0:   0f b6 40 18               movzbl 0x18(%eax),%eax   <=====
Code;  c683a623 <[ide-mod].bss.end+1da4/5781>
   4:   50                        push   %eax
Code;  c683a624 <[ide-mod].bss.end+1da5/5781>
   5:   e8 37 1a 00 00            call   1a41 <_EIP+0x1a41> c683c060 <[ide-mod].
bss.end+37e1/5781>
Code;  c683a629 <[ide-mod].bss.end+1daa/5781>
   a:   58                        pop    %eax
Code;  c683a62a <[ide-mod].bss.end+1dab/5781>
   b:   5a                        pop    %edx
Code;  c683a62b <[ide-mod].bss.end+1dac/5781>
   c:   eb 0b                     jmp    19 <_EIP+0x19> c683a638 <[ide-mod].bss.
end+1db9/5781>
Code;  c683a62d <[ide-mod].bss.end+1dae/5781>
   e:   68 c0 c4 83 c6            push   $0xc683c4c0
Code;  c683a632 <[ide-mod].bss.end+1db3/5781>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c683a637 <[ide-mod].bss.
end+1db8/5781>


2 warnings issued.  Results may not be reliable.





On Thu, Jul 19, 2001 at 12:38:01PM +0200, Guest section DW wrote:
> On Thu, Jul 19, 2001 at 09:57:50AM +0200, Martin Vogt wrote:
> 
> > >Unable to handle kernel NULL pointer dereference at virtual address 00000018
> > > printing eip:
> > >c683a61f
> > >*pde = 00000000
> > >Oops: 0000
> > [.....]
> > 
> > I have looked in the source code:
> > 
> > drivers/scsi/sr.c:
> > 
> > 
> > In line 604 begins a switch statement:
> > 
> >                 switch (sector_size) {
> >                 case 0:   
> >                 case 2340:
> >                 case 2352:
> >                         sector_size = 2048;
> >                         /* fall through */
> >                 case 2048:
> >                         scsi_CDs[i].capacity *= 4;
> >                         /* fall through */
> 
> (1) you might add a "case 2336:" above the "case 2340:".
> that will prevent the message
> (2) but the Oops must be corrected, and you just deleted all very useful
> information. This Oops may be entirely unrelated to this sector size thing,
> or may be related but occur in an entirely different code fragment.
> 
> Post the Oops (fed to ksymoops so that it has a symbol table).
