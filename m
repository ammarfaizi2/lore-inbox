Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTFDSdB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTFDSdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:33:01 -0400
Received: from linux.kappa.ro ([194.102.255.131]:46311 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id S262710AbTFDScS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:32:18 -0400
Date: Wed, 4 Jun 2003 21:45:46 +0300
From: Teodor Iacob <Teodor.Iacob@astral.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] linux-2.4.21-rc6
Message-ID: <20030604184546.GA32667@linux.kappa.ro>
References: <20030604112856.GJ32463@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604112856.GJ32463@linux.kappa.ro>
User-Agent: Mutt/1.5.3i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone any idea? is this kernel related? apache related? hardware related?
Please?

On Wed, Jun 04, 2003 at 02:28:56PM +0300, Teodor Iacob wrote:
> Hello,
> 
> I get a loop of OOPSes from httpd and the system locks in this loop. The distro
> is Redhat 8.0, the machine is XP 2200+ on a VIA KT400 chipset with SCSI Adaptec.
> This happens after 3 or 4 days of uptime.. the machine has 1GB of ram and it is
> intensively used. I think the same OOPS I was getting with previous kernel releases
> also ( from 2.4.19 up to this rc I have now )
> 
> 
> 
> 
> -- 
>       Teodor Iacob,
> Network Administrator
> Astral TELECOM Internet

>   <1>Unable to handle kernel paging request at virtual address fec7f014
>   printing eip:
>  c012d36a
>  *pde = 00000000
>  Oops: 0000
>  CPU:    0
>  EIP:    0010:[<c012d36a>]    Not tainted
>  EFLAGS: 00010002
>  eax: 0835ffff   ebx: 0835ffff   ecx: ddeff000   edx: 00000000
>  esi: c1c0df84   edi: 00000246   ebp: 000001f0   esp: e7643e7c
>  ds: 0018   es: 0018   ss: 0018
>  Process httpd (pid: 23267, stackpage=e7643000)
>  Stack: c0283418 000003fd d2eae690 082b6748 c1c1d800 082b67d4 c0149a9f c1c0df84 
>         000001f0 00000000 d2eae690 082b6748 082b4770 c014a617 c1c1d800 c01fd487 
>         c1c1d800 c01fd40c c02833f0 00000005 082b6748 d2eae690 c01fe257 00000003 
>  Call Trace:    [<c0149a9f>] [<c014a617>] [<c01fd487>] [<c01fd40c>] [<c01fe257>]
>    [<c012edcc>] [<c0144851>] [<c0219c37>] [<c01450ff>] [<c01447fa>] [<c01feedb>]
>    [<c010733f>]
>  
>  Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 
> 

> ksymoops 2.4.5 on i686 2.4.21-rc6.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.21-rc6/ (default)
>      -m /boot/System.map-2.4.21-rc6 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
>   <1>Unable to handle kernel paging request at virtual address fec7f014
>  c012d36a
>  *pde = 00000000
>  Oops: 0000
>  CPU:    0
>  EIP:    0010:[<c012d36a>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00010002
>  eax: 0835ffff   ebx: 0835ffff   ecx: ddeff000   edx: 00000000
>  esi: c1c0df84   edi: 00000246   ebp: 000001f0   esp: e7643e7c
>  ds: 0018   es: 0018   ss: 0018
>  Process httpd (pid: 23267, stackpage=e7643000)
>  Stack: c0283418 000003fd d2eae690 082b6748 c1c1d800 082b67d4 c0149a9f c1c0df84 
>         000001f0 00000000 d2eae690 082b6748 082b4770 c014a617 c1c1d800 c01fd487 
>         c1c1d800 c01fd40c c02833f0 00000005 082b6748 d2eae690 c01fe257 00000003 
>  Call Trace:    [<c0149a9f>] [<c014a617>] [<c01fd487>] [<c01fd40c>] [<c01fe257>]
>    [<c012edcc>] [<c0144851>] [<c0219c37>] [<c01450ff>] [<c01447fa>] [<c01feedb>]
>    [<c010733f>]
>  Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 
> 
> 
> >>EIP; c012d36a <__kmem_cache_alloc+4a/f0>   <=====
> 
> >>eax; 0835ffff Before first symbol
> >>ebx; 0835ffff Before first symbol
> >>ecx; ddeff000 <END_OF_CODE+1dbfde68/????>
> >>esi; c1c0df84 <END_OF_CODE+190cdec/????>
> >>esp; e7643e7c <END_OF_CODE+27342ce4/????>
> 
> Trace; c0149a9f <alloc_inode+11f/150>
> Trace; c014a617 <new_inode+17/60>
> Trace; c01fd487 <sock_alloc+17/a0>
> Trace; c01fd40c <sockfd_lookup+1c/80>
> Trace; c01fe257 <sys_accept+57/140>
> Trace; c012edcc <__get_free_pages+1c/20>
> Trace; c0144851 <__pollwait+41/c0>
> Trace; c0219c37 <tcp_poll+37/180>
> Trace; c01450ff <do_pollfd+4f/90>
> Trace; c01447fa <poll_freewait+3a/50>
> Trace; c01feedb <sys_socketcall+cb/260>
> Trace; c010733f <system_call+33/38>
> 
> Code;  c012d36a <__kmem_cache_alloc+4a/f0>
> 00000000 <_EIP>:
> Code;  c012d36a <__kmem_cache_alloc+4a/f0>   <=====
>    0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
> Code;  c012d36e <__kmem_cache_alloc+4e/f0>
>    4:   0f af 5e 18               imul   0x18(%esi),%ebx
> Code;  c012d372 <__kmem_cache_alloc+52/f0>
>    8:   89 41 14                  mov    %eax,0x14(%ecx)
> Code;  c012d375 <__kmem_cache_alloc+55/f0>
>    b:   03 59 0c                  add    0xc(%ecx),%ebx
> Code;  c012d378 <__kmem_cache_alloc+58/f0>
>    e:   40                        inc    %eax
> Code;  c012d379 <__kmem_cache_alloc+59/f0>
>    f:   74 18                     je     29 <_EIP+0x29>
> Code;  c012d37b <__kmem_cache_alloc+5b/f0>
>   11:   57                        push   %edi
> Code;  c012d37c <__kmem_cache_alloc+5c/f0>
>   12:   9d                        popf   
> Code;  c012d37d <__kmem_cache_alloc+5d/f0>
>   13:   89 00                     mov    %eax,(%eax)
> 
> 
> 2 warnings issued.  Results may not be reliable.


-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
