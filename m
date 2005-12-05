Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVLEQs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVLEQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVLEQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:48:58 -0500
Received: from web30609.mail.mud.yahoo.com ([68.142.200.132]:39324 "HELO
	web30609.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932423AbVLEQs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:48:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DiVJF7Kokz1rvkI24cBM4dFCF+IprYS11Zs1ZLan5jNf2pUc0LfsMGxtPYHSxUjEbD/7P6tNmfHOBLt0o8xiBmfBG6bM5zy9NHoz+N7I4n6JcE2V1ghzxqs6fvedC4iMpOksAxfFjGScz6oTe9KTxbu+FGVjILGZYKjGvRg8f1g=  ;
Message-ID: <20051205164851.45368.qmail@web30609.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 17:48:51 +0100 (CET)
From: zine el abidine Hamid <zine46@yahoo.fr>
Subject: Re: Kernel BUG at page_alloc.c:117!
To: linux-kernel@vger.kernel.org
In-Reply-To: <20051205150530.91163.qmail@web30607.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I don't know if it's helpfull but the output of
ksymoops is :

ksymoops 2.4.4 on i686 2.4.18-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-3/ (default)
     -m /boot/System.map-2.4.18-3 (default)

Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules
that are running
right now and I'll use the default options above for
symbol resolution.
If the current kernel and/or modules do not match the
log, you can get
more accurate output by telling me the kernel version
and where to find
map, modules, ksyms etc.  ksymoops -h explains the
options.

Error (expand_objects): cannot stat(/lib/ext3.o) for
ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for
jbd

....


Warning (compare_maps): parport symbol
parport_unregister_port not found in
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
 Ignoring
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
entry
Warning (compare_maps): parport symbol
parport_wait_event not found in
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
 Ignoring
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
entry
Warning (compare_maps): parport symbol
parport_wait_peripheral not found in
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
 Ignoring
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
entry
Warning (compare_maps): parport symbol parport_write
not found in
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
 Ignoring
/lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
entry
Warning (map_ksym_to_module): cannot match loaded
module ext3 to a unique module object.  Trace may not
be reliable.
Warning (map_ksym_to_module): cannot match loaded
module jbd to a unique module object.  Trace may not
be reliable.
Dec  1 14:54:58 Republique_ncl_a kernel: kernel BUG at
page_alloc.c:117!
Dec  1 14:54:58 Republique_ncl_a kernel: invalid
operand: 0000
Dec  1 14:54:58 Republique_ncl_a kernel: CPU:    0
Dec  1 14:54:58 Republique_ncl_a kernel: EIP:   
0010:[<c01316e7>]    Not tainted

Using defaults from ksymoops -t elf32-i386 -a i386
Dec  1 14:54:58 Republique_ncl_a kernel: EFLAGS:
00010282
Dec  1 14:54:58 Republique_ncl_a kernel: eax: 00000020
  ebx: c16502d8   ecx: 00000001   edx: 000019
Dec  1 14:54:58 Republique_ncl_a kernel: esi: 00000000
  edi: 000001d0   ebp: 00000000   esp: c1755f
Dec  1 14:54:58 Republique_ncl_a kernel: ds: 0018  
es: 0018   ss: 0018
Dec  1 14:54:58 Republique_ncl_a kernel: Process
kswapd (pid: 5, stackpage=c1755000)
Dec  1 14:54:58 Republique_ncl_a kernel: Stack:
c02250b5 00000075 c013d0e3 ddf7e600 c16502d8 000001d
Dec  1 14:54:58 Republique_ncl_a kernel:       
c16502f4 c16502d8 c16502d8 000001d0 000001d0 c012ff8
Dec  1 14:54:58 Republique_ncl_a kernel:       
00000125 c02c473c 00000c24 00000848 0000000f c013038
Dec  1 14:54:58 Republique_ncl_a kernel: Call Trace:
[<c013d0e3>] try_to_free_buffers [kernel] 0xb3
Dec  1 14:54:58 Republique_ncl_a kernel: [<c013b23a>]
try_to_release_page [kernel] 0x3a
Dec  1 14:54:58 Republique_ncl_a kernel: [<c012ff8b>]
page_launder_zone [kernel] 0x42b
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130388>]
page_launder [kernel] 0x168
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130c12>]
do_try_to_free_pages [kernel] 0x12
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130f11>]
kswapd [kernel] 0x101
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0105000>]
stext [kernel] 0x0
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0107136>]
kernel_thread [kernel] 0x26
Dec  1 14:54:58 Republique_ncl_a kernel: [<c0130e10>]
kswapd [kernel] 0x0
Dec  1 14:54:58 Republique_ncl_a kernel: Code: 0f 0b
5d 58 8b 3d f0 e2 32 c0 89 d8 29 f8 69 c0 b7 6d
sh: /usr/bin/objdump: Aucun fichier ou répertoire de
ce type
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for
/tmp/ksymoops.QPZFYU

>>EIP; c01316e7 <__free_pages_ok+57/310>   <=====
Trace; c013d0e3 <try_to_free_buffers+b3/110>
Trace; c013b23a <try_to_release_page+3a/60>
Trace; c012ff8b <page_launder_zone+42b/6c0>
Trace; c0130388 <page_launder+168/300>
Trace; c0130c12 <do_try_to_free_pages+12/180>
Trace; c0130f11 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c0107136 <kernel_thread+26/30>
Trace; c0130e10 <kswapd+0/2d0>


977 warnings and 869 errors issued.  Results may not
be reliable.




Tank's for your help.

Zine

--- zine el abidine Hamid <zine46@yahoo.fr> a écrit :

> Indeed, I tested the application with a 2.4.22
> kernel
> and it seems to work; but I'm not the author of this
> application.
> 
> The module "wdpiano" is C programme which allow us
> to
> use the Watch-Dog Timer of the mother board (ROCKY
> 3703EVR).
> 
> 
> Zine
> 
> PS : The user's manual definition of The Watch-Dog
> Timer is : "a device to ensure thet standalone
> systems
> can always recover from abnormal conditions that
> cause
> the system to crash. These conditions may result
> from
> an external EMI or software bug."
> 
> --- Arjan van de Ven <arjan@infradead.org> a écrit :
> 
> > On Mon, 2005-12-05 at 15:25 +0100, zine el abidine
> > Hamid wrote:
> > > 
> > > I have to use the 2.4.18 kernel because We use
> an
> > > application which is build on this kernel.
> > 
> > the good news is that userspace applications are
> not
> > kernel version
> > specific! At least in general; there are some low
> > level system tools
> > that sometimes are impacted (these are usually the
> > "kernel helpers" like
> > the insmod tool or udev). Regular applications
> work
> > on just about any
> > kernel; applications written for linux in 1994
> still
> > work on 2.6
> > kernels!
> > 
> > > The module are the next one (lsmod):
> > > 
> > > Module                  Size  Used by    Not
> > tainted
> > > wdpiano                 1920   0  (unused)
> > 
> > what is this?
> > 
> > 
> > 
> > -
> > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> 
> 	
> 
> 	
> 		
>
___________________________________________________________________________
> 
> Appel audio GRATUIT partout dans le monde avec le
> nouveau Yahoo! Messenger 
> Téléchargez cette version sur
> http://fr.messenger.yahoo.com
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
