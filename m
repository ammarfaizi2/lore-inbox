Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135918AbREBTkY>; Wed, 2 May 2001 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135782AbREBTkP>; Wed, 2 May 2001 15:40:15 -0400
Received: from ch-12-44-141-183.lcisp.com ([12.44.141.183]:22533 "EHLO
	debian-home") by vger.kernel.org with ESMTP id <S135795AbREBTkB>;
	Wed, 2 May 2001 15:40:01 -0400
Date: Wed, 2 May 2001 14:43:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.4 oops, will not boot
Message-ID: <20010502144303.B4992@debian-home>
In-Reply-To: <20010502030735.A650@debian-home> <3AEFF4CB.4D2CBE36@uow.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AEFF4CB.4D2CBE36@uow.edu.au>; from andrewm@uow.edu.au on Wed, May 02, 2001 at 09:51:39PM +1000
From: Gordon Sadler <gbsadler1@lcisp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2001 at 09:51:39PM +1000, Andrew Morton wrote:
> Envelope-to: gbsadler@localhost
> From: Andrew Morton <andrewm@uow.edu.au>
> X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
> To: Gordon Sadler <gbsadler1@lcisp.com>
> Subject: Re: PROBLEM: 2.4.4 oops, will not boot
> 
> Gordon Sadler wrote:
> > 
> > Please CC on replies.
> > Attached is REPORTING-BUGS template from source, and a hand copied oops
> > that I ran through ksymoops. I really hope this is resolved, anything
> > further needed, just ask.
> 
> Unfortunately the ksymoops output doesn't show the call trace.
> Can you please try again?  A reproducable oops is, err, rather
> important.  The syntax to feed into ksymoops is
> 
> Call Trace: [<c0111234>] [<c0123456>] ...
> 
> Thanks.
> 

I see you are right, was late at night...
I've attached the file I hand wrote for the oops, which I then fed to
ksymoops. Also attached again is the output from ksymoops.

If something is inconsistent, and I need to regen the output with
ksymoops and my System.map, could someone be so kind as to suggest a
proper commandline? I used:
ksymoops -K -L -o /lib/modules/2.4.4/ -m /boot/System.map-2.4.4
< oops.txt >ksymresult.out

Reformatted for mail, originally one line. Nothing ever made it to
/var/log/ksymoops.

Gordon Sadler



--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000014 printing EIP: c01254b5
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c01254b5>]
eflags: 00010013
eax: c1227e08	ebx: c1227e08	ecx: c7e3ff68	edx: 00000000
esi: 00000286	edi: 00000007	ebp: c12343c0	esp: c7e3feec
ds: 0018	es: 0018	ss: 0018
Process chmod (pid: 119, stackpage = c7e3f000)
stack: 00000000 c1263080 c12630dc c013ec88 c1277e08 00000007 00000000 c1263080
       c12630dc c12343c0 00000005 c01370c8 c12343c0 c7e3ff68 c7e3ff68 00000000
       c12343c0 c7e3ffa4 c0137819 c12343c0 c7e3ff68 00000000 c1265000 00000000
Calltrace: [<c013ec88>] [<c01370c8>] [<c0137819>] [<c0136e4a>] [<c0137e3c>] [<c0134f36>] [<c0106b9b>]
Code: 8b 42 14 ff 42 10 89 c1 0f af 4b 0c 03 4a 0c 8b 44 82 18 89
Segmentation Fault

+30 seconds
VM: refill_inactive, wrong page on list

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymresult.out"

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.4/ (specified)
     -m /boot/System.map-2.4.4 (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000014 printing EIP: c01254b5
*pde = 00000000
Oops: 0000
CPU: 0
EIP: 0010: [<c01254b5>]
Using defaults from ksymoops -t elf32-i386 -a i386
eflags: 00010013
eax: c1227e08   ebx: c1227e08     ecx: c7e3ff68       edx: 00000000
esi: 00000286   edi: 00000007     ebp: c12343c0       esp: c7e3feec
ds: 0018        es: 0018       ss: 0018
stack: 00000000 c1263080 c12630dc c013ec88 c1277e08 00000007 00000000 c1263080
       c12630dc c12343c0 00000005 c01370c8 c12343c0 c7e3ff68 c7e3ff68 00000000
       c12343c0 c7e3ffa4 c0137819 c12343c0 c7e3ff68 00000000 c1265000 00000000
Code: 8b 42 14 ff 42 10 89 c1 0f af 4b 0c 03 4a 0c 8b 44 82 18 89

>>EIP; c01254b5 <kmem_cache_alloc+15/60>   <=====
Code;  c01254b5 <kmem_cache_alloc+15/60>
00000000 <_EIP>:
Code;  c01254b5 <kmem_cache_alloc+15/60>   <=====
   0:   8b 42 14                  mov    0x14(%edx),%eax   <=====
Code;  c01254b8 <kmem_cache_alloc+18/60>
   3:   ff 42 10                  incl   0x10(%edx)
Code;  c01254bb <kmem_cache_alloc+1b/60>
   6:   89 c1                     mov    %eax,%ecx
Code;  c01254bd <kmem_cache_alloc+1d/60>
   8:   0f af 4b 0c               imul   0xc(%ebx),%ecx
Code;  c01254c1 <kmem_cache_alloc+21/60>
   c:   03 4a 0c                  add    0xc(%edx),%ecx
Code;  c01254c4 <kmem_cache_alloc+24/60>
   f:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax
Code;  c01254c8 <kmem_cache_alloc+28/60>
  13:   89 00                     mov    %eax,(%eax)


--qDbXVdCdHGoSgWSk--
