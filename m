Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTAJTE4>; Fri, 10 Jan 2003 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTAJS6p>; Fri, 10 Jan 2003 13:58:45 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:12043 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id <S267011AbTAJS61>;
	Fri, 10 Jan 2003 13:58:27 -0500
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Oops with Linux 2.4.21-pre3-ac2
Organization: Who, me?
User-Agent: tin/1.5.16-20021206 ("Spiders") (UNIX) (Linux/2.4.21-pre3-gzp2 (i686))
Message-ID: <1ec4.3e1f19d6.db05e@gzp1.gzp.hu>
Date: Fri, 10 Jan 2003 19:07:02 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System.map not presents due nfs mount problem, but maybe its
usable.

Same kernel produces total freeze on a longtime stable
system.

ksymoops 2.4.8 on i686 2.4.21-pre3-ac2-gzp2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2-gzp2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0129350
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0129350>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c121e404   ecx: c121e404   edx: dd33e000
esi: 00000000   edi: 00000020   ebp: 00000200   esp: dd33fe48
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 517, stackpage=dd33f000)
Stack: cc54bba0 c121e404 00000020 00000200 c0132e0e c121e404 000001d2 00000020 
       00000200 c013136c cc54bba0 cc54bba0 cc54bba0 c0129983 c0128a6c 00000020 
       000001d2 00000020 00000006 00000006 dd33e000 000044b9 000001d2 c0210ed4 
Call Trace:    [<c0132e0e>] [<c013136c>] [<c0129983>] [<c0128a6c>] [<c0128be0>]
  [<c0128c42>] [<c0129608>] [<c0129892>] [<c0125011>] [<c01295b6>] [<c012502d>]
  [<c014ef37>] [<c012f636>] [<c0106b53>]
Code: 89 58 04 89 03 8d 42 5c 89 43 04 89 5a 5c 89 73 0c ff 42 68 


>>EIP; c0129350 <kmem_find_general_cachep+165c/18ac>   <=====

>>ebx; c121e404 <___strtok+fa11f8/205b7e54>
>>ecx; c121e404 <___strtok+fa11f8/205b7e54>
>>edx; dd33e000 <___strtok+1d0c0df4/205b7e54>
>>esp; dd33fe48 <___strtok+1d0c2c3c/205b7e54>

Trace; c0132e0e <try_to_free_buffers+92/17c>
Trace; c013136c <set_bh_page+1e8/1ec>
Trace; c0129983 <__free_pages+1b/1c>
Trace; c0128a6c <kmem_find_general_cachep+d78/18ac>
Trace; c0128be0 <kmem_find_general_cachep+eec/18ac>
Trace; c0128c42 <kmem_find_general_cachep+f4e/18ac>
Trace; c0129608 <_alloc_pages+68/1e0>
Trace; c0129892 <__alloc_pages+112/160>
Trace; c0125011 <generic_file_write+3e9/20b4>
Trace; c01295b6 <_alloc_pages+16/1e0>
Trace; c012502d <generic_file_write+405/20b4>
Trace; c014ef37 <grok_partitions+215f/ade0>
Trace; c012f636 <default_llseek+39e/9f8>
Trace; c0106b53 <__up_wakeup+101f/13e4>

Code;  c0129350 <kmem_find_general_cachep+165c/18ac>
00000000 <_EIP>:
Code;  c0129350 <kmem_find_general_cachep+165c/18ac>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0129353 <kmem_find_general_cachep+165f/18ac>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0129355 <kmem_find_general_cachep+1661/18ac>
   5:   8d 42 5c                  lea    0x5c(%edx),%eax
Code;  c0129358 <kmem_find_general_cachep+1664/18ac>
   8:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c012935b <kmem_find_general_cachep+1667/18ac>
   b:   89 5a 5c                  mov    %ebx,0x5c(%edx)
Code;  c012935e <kmem_find_general_cachep+166a/18ac>
   e:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0129361 <kmem_find_general_cachep+166d/18ac>
  11:   ff 42 68                  incl   0x68(%edx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0129350
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0129350>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c1374d74   ecx: c1374d90   edx: dd33e000
esi: 00000000   edi: dd8f126c   ebp: 0849b000   esp: dd33fc80
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 517, stackpage=dd33f000)
Stack: c1374d74 00000000 dd8f126c 0849b000 00000080 014c5c48 c0278850 c019151c 
       c0278850 c15a1540 c0278850 c15ab160 00000286 c0129983 c0129d53 c1374d74 
       c011f3d0 c1374d74 00003000 c011f7b3 141c2067 dd8fe180 de6ccb20 00003000 
Call Trace:    [<c019151c>] [<c0129983>] [<c0129d53>] [<c011f3d0>] [<c011f7b3>]
  [<c0121d92>] [<c0111f2e>] [<c011617f>] [<c0107126>] [<c010fcd7>] [<c010f9d8>]
  [<c0152e36>] [<c0158aac>] [<c015091b>] [<c01584bf>] [<c0106c44>] [<c0129350>]
  [<c0132e0e>] [<c013136c>] [<c0129983>] [<c0128a6c>] [<c0128be0>] [<c0128c42>]
  [<c0129608>] [<c0129892>] [<c0125011>] [<c01295b6>] [<c012502d>] [<c014ef37>]
  [<c012f636>] [<c0106b53>]
Code: 89 58 04 89 03 8d 42 5c 89 43 04 89 5a 5c 89 73 0c ff 42 68 


>>EIP; c0129350 <kmem_find_general_cachep+165c/18ac>   <=====

>>ebx; c1374d74 <___strtok+10f7b68/205b7e54>
>>ecx; c1374d90 <___strtok+10f7b84/205b7e54>
>>edx; dd33e000 <___strtok+1d0c0df4/205b7e54>
>>edi; dd8f126c <___strtok+1d674060/205b7e54>
>>esp; dd33fc80 <___strtok+1d0c2a74/205b7e54>

Trace; c019151c <ide_do_request+260/2a8>
Trace; c0129983 <__free_pages+1b/1c>
Trace; c0129d53 <free_pages+3cf/1c7c>
Trace; c011f3d0 <pm_find+dc/5d0>
Trace; c011f7b3 <pm_find+4bf/5d0>
Trace; c0121d92 <do_brk+352/5b0>
Trace; c0111f2e <remove_wait_queue+2a2/1228>
Trace; c011617f <exit_mm+303/4ac>
Trace; c0107126 <dump_stack+20e/f30>
Trace; c010fcd7 <__verify_write+407/774>
Trace; c010f9d8 <__verify_write+108/774>
Trace; c0152e36 <grok_partitions+605e/ade0>
Trace; c0158aac <journal_dirty_metadata+154/174>
Trace; c015091b <grok_partitions+3b43/ade0>
Trace; c01584bf <journal_unlock_updates+4a7/4cc>
Trace; c0106c44 <__up_wakeup+1110/13e4>
Trace; c0129350 <kmem_find_general_cachep+165c/18ac>
Trace; c0132e0e <try_to_free_buffers+92/17c>
Trace; c013136c <set_bh_page+1e8/1ec>
Trace; c0129983 <__free_pages+1b/1c>
Trace; c0128a6c <kmem_find_general_cachep+d78/18ac>
Trace; c0128be0 <kmem_find_general_cachep+eec/18ac>
Trace; c0128c42 <kmem_find_general_cachep+f4e/18ac>
Trace; c0129608 <_alloc_pages+68/1e0>
Trace; c0129892 <__alloc_pages+112/160>
Trace; c0125011 <generic_file_write+3e9/20b4>
Trace; c01295b6 <_alloc_pages+16/1e0>
Trace; c012502d <generic_file_write+405/20b4>
Trace; c014ef37 <grok_partitions+215f/ade0>
Trace; c012f636 <default_llseek+39e/9f8>
Trace; c0106b53 <__up_wakeup+101f/13e4>

Code;  c0129350 <kmem_find_general_cachep+165c/18ac>
00000000 <_EIP>:
Code;  c0129350 <kmem_find_general_cachep+165c/18ac>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0129353 <kmem_find_general_cachep+165f/18ac>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0129355 <kmem_find_general_cachep+1661/18ac>
   5:   8d 42 5c                  lea    0x5c(%edx),%eax
Code;  c0129358 <kmem_find_general_cachep+1664/18ac>
   8:   89 43 04                  mov    %eax,0x4(%ebx)
Code;  c012935b <kmem_find_general_cachep+1667/18ac>
   b:   89 5a 5c                  mov    %ebx,0x5c(%edx)
Code;  c012935e <kmem_find_general_cachep+166a/18ac>
   e:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0129361 <kmem_find_general_cachep+166d/18ac>
  11:   ff 42 68                  incl   0x68(%edx)


1 warning and 1 error issued.  Results may not be reliable.

