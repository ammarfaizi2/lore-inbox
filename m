Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSJaVsV>; Thu, 31 Oct 2002 16:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265380AbSJaVsV>; Thu, 31 Oct 2002 16:48:21 -0500
Received: from ulima.unil.ch ([130.223.144.143]:1158 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265378AbSJaVsS>;
	Thu, 31 Oct 2002 16:48:18 -0500
Date: Thu, 31 Oct 2002 22:54:41 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
Message-ID: <20021031215441.GD24890@ulima.unil.ch>
References: <20021031110816.GE16875@ulima.unil.ch> <Pine.LNX.4.44.0210311408230.27728-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210311408230.27728-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:13:14PM -0600, Kai Germaschewski wrote:

> > kernel BUG at kernel/workqueue.c:69!

> Well, I thought I had all of these fixed...

Oops: sorry for reporting...

> I cannot really make much sense of the traces, though, are you sure 
> System.map matched the kernel where the oops happened? You might want to 
> select CONFIG_KALLSYMS, that guarantees correct resolving of symbols 
> without the need to run the oops through ksymoops.

If the insmoding of the module isn't enough, I'll recompil with
CONFIG_KALLSYMS:

kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
hisax dvb-ttpci alps_bsrv2 binfmt_misc floppy alps_bsru6 eepro100 mii ext2 ehci-hcd usbcore  
CPU:    0
EIP:    0060:[<c0129775>]    Not tainted
EFLAGS: 00010213
eax: 00000000   ebx: c77b6000   ecx: 00000001   edx: c9d7e958
esi: c9d7e958   edi: c9d7e95c   ebp: dffa2280   esp: c77b7e04
ds: 0068   es: 0068   ss: 0068
Process insmod (pid: 4345, threadinfo=c77b6000 task=c8528680)
Stack: 00000004 c9d7e000 c77b6000 00011bd7 e38b227a c9d7e000 00000002 00000052 
       c9d7e000 00000003 e38af95c c9d7e000 00000003 c9d7e0be c9d7e000 e389f9e3 
       c9d7e000 000000f2 00000000 e38b3169 c9d7e000 c9d7e000 c77b7eda c9d7e0be 
Call Trace: [<e38b227a>]  [<e38af95c>]  [<e389f9e3>]  [<e38b3169>]  [<e389fe0b>]  [<e38b317e>]  [<e38b7e48>]  [<e38b7e64>]  [<e38a0005>]  [<e38b7e48>]  [<e38b6042>]  [<e38a2287>]  [<e38b316f>]  [<e38b7e6a>]  [<e38a0550>]  [<e38b3229>]  [<c011c895>]  [<e389f060>]  [<e389f060>]  [<c0107457>] 
Code: 0f 0b 45 00 98 0e 37 c0 eb 8b 90 83 ec 10 89 7c 24 08 89 1c 
 <6>note: insmod[4345] exited with preempt_count 2
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1

ksymoops 2.4.5 on i686 2.5.45.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.45/ (default)
     -m /boot/System.map-2.5.45 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

SGI XFS CVS-09/15/02:17 with no debug enabled
Call Trace: [<c013609a>]  [<c013613c>]  [<c013640a>]  [<c013651c>]  [<c0184ad0>]  [<c0184bcd>]  [<c0184df8>]  [<c0210000>]  [<c02cf7d7>]  [<c02cf3cd>]  [<c0117e04>]  [<c02cdb83>]  [<e389fca9>]  [<e38b7e48>]  [<e38b7e64>]  [<e38a0005>]  [<e38b7e48>]  [<e38b6042>]  [<e38a2287>]  [<e38b316f>]  [<e38b7e6a>]  [<e38a0550>]  [<e38b3229>]  [<c011c895>]  [<e389f060>]  [<e389f060>]  [<c0107457>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c013609a <kmem_flagcheck+5e/60>
Trace; c013613c <cache_grow+a0/224>
Trace; c013640a <cache_alloc_refill+14a/1b4>
Trace; c013651c <kmem_cache_alloc+40/42>
Trace; c0184ad0 <devfsd_notify_de+58/fc>
Trace; c0184bcd <devfsd_notify+59/86>
Trace; c0184df8 <devfs_register+1fe/350>
Trace; c0210000 <xfs_write+8a/666>
Trace; c02cf7d7 <isdn_register_devfs+71/86>
Trace; c02cf3cd <isdn_add_channels+97/b4>
Trace; c0117e04 <default_wake_function+32/3e>
Trace; c02cdb83 <register_isdn+11f/1c6>
Trace; e389fca9 <[hisax]checkcard+1cb/41a>
Trace; e38b7e48 <[hisax]cards+0/0>
Trace; e38b7e64 <[hisax]HiSaxID+0/8>
Trace; e38a0005 <[hisax]HiSax_inithardware+cd/1a4>
Trace; e38b7e48 <[hisax]cards+0/0>
Trace; e38b6042 <[hisax].rodata.end+3217/4f75>
Trace; e38a2287 <[hisax]Isdnl1New+9b/b6>
Trace; e38b316f <[hisax].rodata.end+344/4f75>
Trace; e38b7e6a <[hisax]HiSaxID+6/8>
Trace; e38a0550 <[hisax]HiSax_init+186/302>
Trace; e38b3229 <[hisax].rodata.end+3fe/4f75>
Trace; c011c895 <sys_init_module+4eb/62e>
Trace; e389f060 <[hisax]HiSax_getrev+0/0>
Trace; e389f060 <[hisax]HiSax_getrev+0/0>
Trace; c0107457 <syscall_call+7/b>

kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0129775>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 00000000   ebx: c77b6000   ecx: 00000001   edx: c9d7e958
esi: c9d7e958   edi: c9d7e95c   ebp: dffa2280   esp: c77b7e04
ds: 0068   es: 0068   ss: 0068
Stack: 00000004 c9d7e000 c77b6000 00011bd7 e38b227a c9d7e000 00000002 00000052 
       c9d7e000 00000003 e38af95c c9d7e000 00000003 c9d7e0be c9d7e000 e389f9e3 
       c9d7e000 000000f2 00000000 e38b3169 c9d7e000 c9d7e000 c77b7eda c9d7e0be 
Call Trace: [<e38b227a>]  [<e38af95c>]  [<e389f9e3>]  [<e38b3169>]  [<e389fe0b>]  [<e38b317e>]  [<e38b7e48>]  [<e38b7e64>]  [<e38a0005>]  [<e38b7e48>]  [<e38b6042>]  [<e38a2287>]  [<e38b316f>]  [<e38b7e6a>]  [<e38a0550>]  [<e38b3229>]  [<c011c895>]  [<e389f060>]  [<e389f060>]  [<c0107457>] 
Code: 0f 0b 45 00 98 0e 37 c0 eb 8b 90 83 ec 10 89 7c 24 08 89 1c 


>>EIP; c0129775 <queue_work+91/9c>   <=====

>>ebx; c77b6000 <_end+73205ec/2245264c>
>>edx; c9d7e958 <_end+98e8f44/2245264c>
>>esi; c9d7e958 <_end+98e8f44/2245264c>
>>edi; c9d7e95c <_end+98e8f48/2245264c>
>>ebp; dffa2280 <_end+1fb0c86c/2245264c>
>>esp; c77b7e04 <_end+73223f0/2245264c>

Trace; e38b227a <[hisax]clear_pending_isac_ints+f2/13e>
Trace; e38af95c <[hisax]AVM_card_msg+6a/d0>
Trace; e389f9e3 <[hisax]init_card+b9/1b4>
Trace; e38b3169 <[hisax].rodata.end+33e/4f75>
Trace; e389fe0b <[hisax]checkcard+32d/41a>
Trace; e38b317e <[hisax].rodata.end+353/4f75>
Trace; e38b7e48 <[hisax]cards+0/0>
Trace; e38b7e64 <[hisax]HiSaxID+0/8>
Trace; e38a0005 <[hisax]HiSax_inithardware+cd/1a4>
Trace; e38b7e48 <[hisax]cards+0/0>
Trace; e38b6042 <[hisax].rodata.end+3217/4f75>
Trace; e38a2287 <[hisax]Isdnl1New+9b/b6>
Trace; e38b316f <[hisax].rodata.end+344/4f75>
Trace; e38b7e6a <[hisax]HiSaxID+6/8>
Trace; e38a0550 <[hisax]HiSax_init+186/302>
Trace; e38b3229 <[hisax].rodata.end+3fe/4f75>
Trace; c011c895 <sys_init_module+4eb/62e>
Trace; e389f060 <[hisax]HiSax_getrev+0/0>
Trace; e389f060 <[hisax]HiSax_getrev+0/0>
Trace; c0107457 <syscall_call+7/b>

Code;  c0129775 <queue_work+91/9c>
00000000 <_EIP>:
Code;  c0129775 <queue_work+91/9c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129777 <queue_work+93/9c>
   2:   45                        inc    %ebp
Code;  c0129778 <queue_work+94/9c>
   3:   00 98 0e 37 c0 eb         add    %bl,0xebc0370e(%eax)
Code;  c012977e <queue_work+9a/9c>
   9:   8b 90 83 ec 10 89         mov    0x8910ec83(%eax),%edx
Code;  c0129784 <delayed_work_timer_fn+4/86>
   f:   7c 24                     jl     35 <_EIP+0x35> c01297aa <delayed_work_timer_fn+2a/86>
Code;  c0129786 <delayed_work_timer_fn+6/86>
  11:   08 89 1c 00 00 00         or     %cl,0x1c(%ecx)

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
