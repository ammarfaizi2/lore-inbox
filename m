Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSKEAGS>; Mon, 4 Nov 2002 19:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbSKEAFJ>; Mon, 4 Nov 2002 19:05:09 -0500
Received: from saturno.fis.uc.pt ([193.136.215.208]:21010 "EHLO
	saturno.fis.uc.pt") by vger.kernel.org with ESMTP
	id <S263246AbSKEAEn>; Mon, 4 Nov 2002 19:04:43 -0500
Date: Tue, 5 Nov 2002 00:11:05 GMT
From: Luis Miguel Tavora <lmtavora@saturno.fis.uc.pt>
Message-Id: <200211050011.AAA18071@saturno.fis.uc.pt>
To: linux-kernel@vger.kernel.org
Reply-To: lmtavora@saturno.fis.uc.pt
Cc: Nuno Monteiro <nuno@itsari.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP3 Imap webMail Program 2.0.11
X-Originating-IP: 193.137.239.227
Subject: re: Ext3 journalling file system
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno.

First of all, many thanks for your prompt reply!!

Concerning kernel marked as "Tainted", it might be 
the drivers of my Lucent modem that I compiled as
 modules. But at the time of the crash they weren't 
loaded. 


I piped the Oops message through ksymoops hopping 
that they might help....


Regards, 

Luis

ksymoops 2.4.4 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol 
information.  I will
assume that the log matches the kernel and modules 
that are running
right now and I'll use the default options above 
for symbol resolution.
If the current kernel and/or modules do not match 
the log, you can get
more accurate output by telling me the kernel 
version and where to find
map, modules, ksyms etc.  ksymoops -h explains the 
options.

Error (expand_objects): cannot stat(/lib/ext3.o) 
for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for 
jbd
Warning (map_ksym_to_module): cannot match loaded 
module ext3 to a unique module
object.  Trace may not be reliable.
Oct 30 11:47:19 Fargo kernel: kernel BUG at 
inode.c:513!
Oct 30 11:47:19 Fargo kernel: invalid operand: 0000
Oct 30 11:47:19 Fargo kernel: CPU:    0
Oct 30 11:47:19 Fargo kernel: EIP:    
0010:[<c0146379>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 30 11:47:19 Fargo kernel: EFLAGS: 00010206
Oct 30 11:47:19 Fargo kernel: eax: 00000100   ebx: 
c02890a0   ecx: c02890c0   edx:
c02890a0
Oct 30 11:47:19 Fargo kernel: esi: c7f51a00   edi: 
c02890a0   ebp: c76885e0   esp:
c39efe54
Oct 30 11:47:19 Fargo kernel: ds: 0018   es: 0018   
ss: 0018
Oct 30 11:47:19 Fargo kernel: Process rpm (pid: 
7187, stackpage=c39ef000)
Oct 30 11:47:19 Fargo kernel: Stack: c76885e0 
c33ed320 00000000 00000000 c02890a0
c880ee08 c02890a0 c02890a0
Oct 30 11:47:19 Fargo kernel:        00000000 
00000000 c76885e0 c5f03a20 c8812be4
0004ab8f c8812bf5 c33ed320
Oct 30 11:47:19 Fargo kernel:        c39ee000 
c76885f4 c39efebc c02890a0 c39efebc
c02890a0 c8812ce7 c76885e0
Oct 30 11:47:19 Fargo kernel: Call Trace:    
[<c880ee08>] [<c8812be4>] [<c8812bf5>]
[<c8812ce7>] [<c880fed7>]
Oct 30 11:47:19 Fargo kernel:   [<c881c340>] 
[<c880fe00>] [<c881c340>] [<c0146cf4>]
[<c013f54c>] [<c0144a16>]
Oct 30 11:47:19 Fargo kernel:   [<c013f724>] 
[<c013f72f>] [<c0163872>] [<c01409d3>]
[<c010891b>]
Oct 30 11:47:19 Fargo kernel: Code: 0f 0b 01 02 b0 
2d 1e c0 8b 83 08 01 00 00 a9 10
00 00 00 75

>>EIP; c0146379 <clear_inode+19/d0>   <=====
Trace; c880ee08 <[ext3].text.start+1da8/a8df>
Trace; c8812be4 <[ext3].text.start+5b84/a8df>
Trace; c8812bf5 <[ext3].text.start+5b95/a8df>
Trace; c8812ce7 <[ext3].text.start+5c87/a8df>
Trace; c880fed7 <[ext3].text.start+2e77/a8df>
Trace; c881c340 <[ext3].data.start+200/2bf>
Trace; c880fe00 <[ext3].text.start+2da0/a8df>
Trace; c881c340 <[ext3].data.start+200/2bf>
Trace; c0146cf4 <iput+f4/1d0>
Trace; c013f54c <vfs_rename+3c/90>
Trace; c0144a16 <dput+d6/130>
Trace; c013f724 <sys_rename+184/210>
Trace; c013f72f <sys_rename+18f/210>
Trace; c0163872 <tty_ioctl+342/360>
Trace; c01409d3 <sys_ioctl+183/190>
Trace; c010891b <system_call+33/38>
Code;  c0146379 <clear_inode+19/d0>
00000000 <_EIP>:
Code;  c0146379 <clear_inode+19/d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014637b <clear_inode+1b/d0>
   2:   01 02                     add    %eax,(%edx)
Code;  c014637d <clear_inode+1d/d0>
   4:   b0 2d                     mov    $0x2d,%al
Code;  c014637f <clear_inode+1f/d0>
   6:   1e                        push   %ds
Code;  c0146380 <clear_inode+20/d0>
   7:   c0 8b 83 08 01 00 00      rorb   
$0x0,0x10883(%ebx)
Code;  c0146387 <clear_inode+27/d0>
   e:   a9 10 00 00 00            test   $0x10,%eax
Code;  c014638c <clear_inode+2c/d0>
  13:   75 00                     jne    15 
<_EIP+0x15> c014638e <clear_inode+2e/d0>

Oct 30 11:47:19 Fargo kernel: kernel BUG at 
transaction.c:226!
Oct 30 11:47:19 Fargo kernel: invalid operand: 0000
Oct 30 11:47:19 Fargo kernel: CPU:    0
Oct 30 11:47:19 Fargo kernel: EIP:    
0010:[<c88002f8>]    Tainted: P
Oct 30 11:47:19 Fargo kernel: EFLAGS: 00010296
Oct 30 11:47:19 Fargo kernel: eax: 00000076   ebx: 
c76885e0   ecx: c5c14000   edx:
c5c15f64
Oct 30 11:47:19 Fargo kernel: esi: c39ee000   edi: 
c146e7c0   ebp: c5cd1000   esp:
c39efbdc
Oct 30 11:47:19 Fargo kernel: ds: 0018   es: 0018   
ss: 0018
Oct 30 11:47:19 Fargo kernel: Process rpm (pid: 
7187, stackpage=c39ef000)
Oct 30 11:47:19 Fargo kernel: Stack: c8806e80 
c8806750 c8806730 000000e2 c8806f20
c76885e0 c76885e0 ffffffe2
Oct 30 11:47:19 Fargo kernel:        c146e7c0 
c6ce9840 c8812d58 c5cd1000 00000001
5251504f 56555453 5a595857
Oct 30 11:47:19 Fargo kernel:        76757400 
c146e7c0 c5ddde00 00000001 c0145a3e
c146e7c0 00000004 c146e7c0
Oct 30 11:47:19 Fargo kernel: Call Trace:    
[<c8806e80>] [<c8806750>] [<c8806730>]
[<c8806f20>] [<c8812d58>]
Oct 30 11:47:19 Fargo kernel:   [<c0145a3e>] 
[<c0129ddd>] [<c0170fa8>] [<c011d9c5>]
[<c011d9f9>] [<c011a277>]
Oct 30 11:47:19 Fargo kernel:   [<c011423e>] 
[<c0108ecd>] [<c0109120>] [<c01091a1>]
[<c0146379>] [<c880132c>]
Oct 30 11:47:19 Fargo kernel:   [<c8800d46>] 
[<c880132c>] [<c0108a0c>] [<c0146379>]
[<c880ee08>] [<c8812be4>]
Oct 30 11:47:19 Fargo kernel:   [<c8812bf5>] 
[<c8812ce7>] [<c880fed7>] [<c881c340>]
[<c880fe00>] [<c881c340>]
Oct 30 11:47:19 Fargo kernel:   [<c0146cf4>] 
[<c013f54c>] [<c0144a16>] [<c013f724>]
[<c013f72f>] [<c0163872>]
Oct 30 11:47:19 Fargo kernel:   [<c01409d3>] 
[<c010891b>]
Oct 30 11:47:19 Fargo kernel: Code: 0f 0b e2 00 30 
67 80 c8 83 c4 14 ff 43 08 eb 6a
6a 01 68 f0

>>EIP; c88002f8 
<[jbd]__kstrtab_journal_check_available_features+38/40> 
  <=====
Trace; c8806e80 <[jbd].rodata.end+761/4ca9>
Trace; c8806750 <[jbd].rodata.end+31/4ca9>
Trace; c8806730 <[jbd].rodata.end+11/4ca9>
Trace; c8806f20 <[jbd].rodata.end+801/4ca9>
Trace; c8812d58 <[ext3].text.start+5cf8/a8df>
Trace; c0145a3e <__mark_inode_dirty+2e/80>
Trace; c0129ddd <generic_file_write+34d/720>
Trace; c0170fa8 <vt_console_print+68/2c0>
Trace; c011d9c5 <do_acct_process+215/230>
Trace; c011d9f9 <acct_process+19/26>
Trace; c011a277 <do_exit+67/210>
Trace; c011423e <bust_spinlocks+3e/50>
Trace; c0108ecd <die+4d/70>
Trace; c0109120 <do_invalid_op+0/90>
Trace; c01091a1 <do_invalid_op+81/90>
Trace; c0146379 <clear_inode+19/d0>
Trace; c880132c 
<[jbd]journal_dirty_metadata+15c/180>
Trace; c8800d46 <[jbd]do_get_write_access+546/570>
Trace; c880132c 
<[jbd]journal_dirty_metadata+15c/180>
Trace; c0108a0c <error_code+34/3c>
Trace; c0146379 <clear_inode+19/d0>
Trace; c880ee08 <[ext3].text.start+1da8/a8df>
Trace; c8812be4 <[ext3].text.start+5b84/a8df>
Trace; c8812bf5 <[ext3].text.start+5b95/a8df>
Trace; c8812ce7 <[ext3].text.start+5c87/a8df>
Trace; c880fed7 <[ext3].text.start+2e77/a8df>
Trace; c881c340 <[ext3].data.start+200/2bf>
Trace; c880fe00 <[ext3].text.start+2da0/a8df>
Trace; c881c340 <[ext3].data.start+200/2bf>
Trace; c0146cf4 <iput+f4/1d0>
Trace; c013f54c <vfs_rename+3c/90>
Trace; c0144a16 <dput+d6/130>
Trace; c013f724 <sys_rename+184/210>
Trace; c013f72f <sys_rename+18f/210>
Trace; c0163872 <tty_ioctl+342/360>
Trace; c01409d3 <sys_ioctl+183/190>
Trace; c010891b <system_call+33/38>
Code;  c88002f8 
<[jbd]__kstrtab_journal_check_available_features+38/40>
00000000 <_EIP>:
Code;  c88002f8 
<[jbd]__kstrtab_journal_check_available_features+38/40> 
  <=====
   0:   0f 0b                     ud2a      <=====
Code;  c88002fa 
<[jbd]__kstrtab_journal_check_available_features+3a/40>
   2:   e2 00                     loop   4 
<_EIP+0x4> c88002fc
<[jbd]__kstrtab_journal_check_available_features+3c/40>
Code;  c88002fc 
<[jbd]__kstrtab_journal_check_available_features+3c/40>
   4:   30 67 80                  xor    
%ah,0xffffff80(%edi)
Code;  c88002ff 
<[jbd]__kstrtab_journal_check_available_features+3f/40>
   7:   c8 83 c4 14               enter  
$0xc483,$0x14
Code;  c8800303 
<[jbd]__kstrtab_journal_set_features+3/1f>
   b:   ff 43 08                  incl   0x8(%ebx)
Code;  c8800306 
<[jbd]__kstrtab_journal_set_features+6/1f>
   e:   eb 6a                     jmp    7a 
<_EIP+0x7a> c8800372
<[jbd]__kstrtab_journal_recover+9/17>
Code;  c8800308 
<[jbd]__kstrtab_journal_set_features+8/1f>
  10:   6a 01                     push   $0x1
Code;  c880030a 
<[jbd]__kstrtab_journal_set_features+a/1f>
  12:   68 f0 00 00 00            push   $0xf0


2 warnings and 2 errors issued.  Results may not be 
reliable.
 
-----------------------------------------------------
>On 31.10.02 13:09 Luis Miguel Tavora wrote:
>> 
>> [1.] Ext3 jornalling file system
>> 
> [2.] The system pt-get to update RH 7.3, on a
>>Compaq M700 Laptop the system is turned into a
> highly critical stage: impossible to lauch
> applications, no disk access and the machine 
doesn't
> reboot with the shutdown command (but the CPU &
> clock keep working ok, I think...)

Hi Luis,

Please pipe the oops messages through ksymoops 
(check 


linux/Documentation/oops-tracing.txt on how to do 
so), as they're really 
not useful as is. Also, you may want to check 
2.4.20-rc1, quite a few ext3 
fixes went in during the .20-pre series. I seem to 
remember some bugs in 
transaction.c:226 during 2.4.18/.19-pre...

Also, it would help a great deal if you could 
reproduce the crash without 

any proprietary modules ever being loaded -- your 
kernel was marked as 
"tainted", although all modules from the list you 
provide below should be 
ok (GPL or Dual BSD/GPL). Did you have any nVidia 
binary only drivers 
loaded at the the time of the crash?

Cheers,

                Nuno

-----------------------------------------------------
This mail sent through IMP: http://web.horde.org/imp/
