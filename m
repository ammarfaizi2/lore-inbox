Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131516AbQL1Wml>; Thu, 28 Dec 2000 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131911AbQL1Wmb>; Thu, 28 Dec 2000 17:42:31 -0500
Received: from 216-80-74-178.dsl.enteract.com ([216.80.74.178]:2308 "EHLO
	kre8tive.org") by vger.kernel.org with ESMTP id <S131516AbQL1WmJ>;
	Thu, 28 Dec 2000 17:42:09 -0500
Date: Thu, 28 Dec 2000 16:11:26 -0600
From: Mike Elmore <mike@kre8tive.org>
To: linux-kernel@vger.kernel.org
Subject: Repeatable 2.4.0-test13-pre4 nfsd Oops rears it head again
Message-ID: <20001228161126.A982@lingas.basement.bogus>
Reply-To: mike@kre8tive.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

All,

Had another nfsd oops today.  I was listening to a mp3
that is located on a nfs partition mounted off the machine
that oops'd with no other network activity.

Ksymoops output is attached as well as the regular console
text.

What the heck, I say what the heck is goin on here?

-- 


Mike Elmore
mike@kre8tive.org

"Never confuse activity with accomplishment."
				-unknown


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sodham-crash2.ksymoops"

ksymoops 2.3.5 on i686 2.4.0-test13-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test13-pre4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kre8tive.org login: Unable to handle kernel paging request at virtual address dbdbdc17
 c01e78b6      
 *pde = 00000000
 Oops: 0000     
 CPU:    0 
 EIP:    0010:[<c01e78b6>]
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010286         
 eax: dbdbdbdb   ebx: c1324140   ecx: c3de4f20   edx: 000005c8
 esi: c3de4f20   edi: 00000000   ebp: 00000000   esp: c22d3c68
 ds: 0018   es: 0018   ss: 0018                               
 Process nfsd (pid: 637, stackpage=c22d3000)
 Stack: c2a02da0 00000000 c3de4f20 0000bbfa 000005c8 c2a02da0 012e3b11 c01e7cd9 
        c2a02da0 c3de4f20 c02e3b4c c22d2000 c23c8680 c3de4f20 c2481010 0101a8c0 
        c22d2000 dbdbdbdb c482a15f c3de4f20 c482c41c c22d3d84 00000003 c22d3d94 
Call Trace: [<c01e7cd9>] [<dbdbdbdb>] [<c482a15f>] [<c482c41c>] [<c4828fc9>] [<c482c41c>] [<c012b9f9>] 
[<c482755a>] [<c01ea33c>] [<c01e1c1c>] [<c01ea33c>] [<c01e1ed1>] [<c01ea33c>] [<c482c41c>] [<c01e9938>] 
[<c01ea33c>] [<c01e9a6e>] [<c01ffe38>] [<c02002cc>] [<c01ffe38>] [<c0205bc8>] [<c0205c06>] [<c01d764d>] 
[<c0205bc8>] [<c0217074>] [<c0217581>] [<c02184d6>] [<c0216c14>] [<c0175b2a>] [<c01074bb>]
Code: 8b 40 3c 8b 4c 24 20 89 41 3c 8b 74 24 24 c7 46 18 00 00 00

>>EIP; c01e78b6 <ip_frag_queue+23e/2a4>   <=====
Trace; c01e7cd9 <ip_defrag+ed/184>
Trace; dbdbdbdb <END_OF_CODE+17581564/????>
Trace; c482a15f <[ip_conntrack]ip_ct_gather_frags+3b/c8>
Trace; c482c41c <[ip_conntrack]ip_conntrack_local_out_ops+0/18>
Trace; c4828fc9 <[ip_conntrack]ip_conntrack_in+39/32c>
Trace; c482c41c <[ip_conntrack]ip_conntrack_local_out_ops+0/18>
Trace; c012b9f9 <kmem_cache_grow+1a1/268>
Trace; c482755a <[ip_conntrack]ip_conntrack_local+5a/60>
Trace; c01ea33c <output_maybe_reroute+0/14>
Trace; c01e1c1c <nf_iterate+34/90>
Trace; c01ea33c <output_maybe_reroute+0/14>
Trace; c01e1ed1 <nf_hook_slow+79/f8>
Trace; c01ea33c <output_maybe_reroute+0/14>
Trace; c482c41c <[ip_conntrack]ip_conntrack_local_out_ops+0/18>
Trace; c01e9938 <ip_build_xmit_slow+3a0/488>
Trace; c01ea33c <output_maybe_reroute+0/14>
Trace; c01e9a6e <ip_build_xmit+4e/320>
Trace; c01ffe38 <udp_getfrag+0/c4>
Trace; c02002cc <udp_sendmsg+388/414>
Trace; c01ffe38 <udp_getfrag+0/c4>
Trace; c0205bc8 <inet_sendmsg+0/44>
Trace; c0205c06 <inet_sendmsg+3e/44>
Trace; c01d764d <sock_sendmsg+81/a4>
Trace; c0205bc8 <inet_sendmsg+0/44>
Trace; c0217074 <svc_sendto+8c/d4>
Trace; c0217581 <svc_udp_sendto+35/64>
Trace; c02184d6 <svc_send+7a/124>
Trace; c0216c14 <svc_process+2f8/544>
Trace; c0175b2a <nfsd+1ca/358>
Trace; c01074bb <kernel_thread+23/30>
Code;  c01e78b6 <ip_frag_queue+23e/2a4>
00000000 <_EIP>:
Code;  c01e78b6 <ip_frag_queue+23e/2a4>   <=====
   0:   8b 40 3c                  mov    0x3c(%eax),%eax   <=====
Code;  c01e78b9 <ip_frag_queue+241/2a4>
   3:   8b 4c 24 20               mov    0x20(%esp,1),%ecx
Code;  c01e78bd <ip_frag_queue+245/2a4>
   7:   89 41 3c                  mov    %eax,0x3c(%ecx)
Code;  c01e78c0 <ip_frag_queue+248/2a4>
   a:   8b 74 24 24               mov    0x24(%esp,1),%esi
Code;  c01e78c4 <ip_frag_queue+24c/2a4>
   e:   c7 46 18 00 00 00 00      movl   $0x0,0x18(%esi)

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sodham-crash2.txt"

Red Hat Linux release 7.0 (Guinness)
Kernel 2.4.0-test13-pre4 on an i686

kre8tive.org login: Unable to handle kernel paging request at virtual address dbdbdc17
 printing eip:                                                                        
 c01e78b6      
 *pde = 00000000
 Oops: 0000     
 CPU:    0 
 EIP:    0010:[<c01e78b6>]
 EFLAGS: 00010286         
 eax: dbdbdbdb   ebx: c1324140   ecx: c3de4f20   edx: 000005c8
 esi: c3de4f20   edi: 00000000   ebp: 00000000   esp: c22d3c68
 ds: 0018   es: 0018   ss: 0018                               
 Process nfsd (pid: 637, stackpage=c22d3000)
 Stack: c2a02da0 00000000 c3de4f20 0000bbfa 000005c8 c2a02da0 012e3b11 c01e7cd9 
        c2a02da0 c3de4f20 c02e3b4c c22d2000 c23c8680 c3de4f20 c2481010 0101a8c0 
        c22d2000 dbdbdbdb c482a15f c3de4f20 c482c41c c22d3d84 00000003 c22d3d94 
Call Trace: [<c01e7cd9>] [<dbdbdbdb>] [<c482a15f>] [<c482c41c>] [<c4828fc9>] [<c482c41c>] [<c012b9f9>] 
[<c482755a>] [<c01ea33c>] [<c01e1c1c>] [<c01ea33c>] [<c01e1ed1>] [<c01ea33c>] [<c482c41c>] [<c01e9938>] 
[<c01ea33c>] [<c01e9a6e>] [<c01ffe38>] [<c02002cc>] [<c01ffe38>] [<c0205bc8>] [<c0205c06>] [<c01d764d>] 
[<c0205bc8>] [<c0217074>] [<c0217581>] [<c02184d6>] [<c0216c14>] [<c0175b2a>] [<c01074bb>]
Code: 8b 40 3c 8b 4c 24 20 89 41 3c 8b 74 24 24 c7 46 18 00 00 00
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing           

--J/dobhs11T7y2rNN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
