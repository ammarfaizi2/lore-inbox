Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTENKWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 06:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTENKWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 06:22:35 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:62914 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261824AbTENKWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 06:22:32 -0400
Subject: Re: 2.5.69-bk8: sunrpc
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <16065.39634.214317.736721@notabene.cse.unsw.edu.au>
References: <1052866301.588.1.camel@teapot.felipe-alfaro.com>
	 <16065.39634.214317.736721@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Message-Id: <1052908494.586.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 14 May 2003 12:34:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-14 at 03:24, Neil Brown wrote:
> On  May 14, felipe_alfaro@linuxmail.org wrote:
> > I saw the following oops just after compiling 2.5.69-bk8 and booting it
> > up. It happened while booting Red Hat Linux 9. Data copied by hand...
> > 
> > EIP:    0060:[<e08d1ece>]   Not tainted
> > EFLAGS: 00010246
> > EIP is at svc_sock_update_bufs+0x74/0x17d [sunrpc]
> 
> Are you able to
>    echo disassemble svc_sock_update_bufs | gdb -batch -x /dev/stdin  net/sunrpc/sunrpc.o 
> 
> and send me the output?

Of course! Here it is:

(no debugging symbols found)...Dump of assembler code for function
svc_sock_update_bufs:
0x0000de5a <svc_sock_update_bufs+0>:	push   %ebp
0x0000de5b <svc_sock_update_bufs+1>:	mov    $0xffffe000,%eax
0x0000de60 <svc_sock_update_bufs+6>:	and    %esp,%eax
0x0000de62 <svc_sock_update_bufs+8>:	mov    %esp,%ebp
0x0000de64 <svc_sock_update_bufs+10>:	push   %esi
0x0000de65 <svc_sock_update_bufs+11>:	push   %ebx
0x0000de66 <svc_sock_update_bufs+12>:	sub    $0x1c,%esp
0x0000de69 <svc_sock_update_bufs+15>:	mov    0x8(%ebp),%esi
0x0000de6c <svc_sock_update_bufs+18>:	addl   $0x100,0x14(%eax)
0x0000de73 <svc_sock_update_bufs+25>:	cmpl   $0x1d244b3c,0x18(%esi)
0x0000de7a <svc_sock_update_bufs+32>:	je     0xde9f
<svc_sock_update_bufs+69>
0x0000de7c <svc_sock_update_bufs+34>:	lea    0x18(%esi),%eax
0x0000de7f <svc_sock_update_bufs+37>:	movl   $0x41d,0x8(%esp,1)
0x0000de87 <svc_sock_update_bufs+45>:	movl   $0x6c2,0x4(%esp,1)
0x0000de8f <svc_sock_update_bufs+53>:	mov    %eax,0xc(%esp,1)
0x0000de93 <svc_sock_update_bufs+57>:	movl   $0x23e0,(%esp,1)
0x0000de9a <svc_sock_update_bufs+64>:	call   0xde9b
<svc_sock_update_bufs+65>
0x0000de9f <svc_sock_update_bufs+69>:	mov    0x1c(%esi),%eax
0x0000dea2 <svc_sock_update_bufs+72>:	test   %eax,%eax
0x0000dea4 <svc_sock_update_bufs+74>:	je     0xdeb1
<svc_sock_update_bufs+87>
0x0000dea6 <svc_sock_update_bufs+76>:	mov    0x20(%esi),%eax
0x0000dea9 <svc_sock_update_bufs+79>:	test   %eax,%eax
0x0000deab <svc_sock_update_bufs+81>:	jne    0xdf91
<svc_sock_update_bufs+311>
0x0000deb1 <svc_sock_update_bufs+87>:	movl   $0x1,0x1c(%esi)
0x0000deb8 <svc_sock_update_bufs+94>:	movl   $0x6c2,0x28(%esi)
0x0000debf <svc_sock_update_bufs+101>:	movl   $0x41d,0x2c(%esi)
0x0000dec6 <svc_sock_update_bufs+108>:	mov    0x3c(%esi),%edx
0x0000dec9 <svc_sock_update_bufs+111>:	mov    (%edx),%eax
0x0000decb <svc_sock_update_bufs+113>:	lea    0x0(%esi,1),%esi
0x0000decf <svc_sock_update_bufs+117>:	lea    0x3c(%esi),%ebx
0x0000ded2 <svc_sock_update_bufs+120>:	cmp    %ebx,%edx
0x0000ded4 <svc_sock_update_bufs+122>:	je     0xdeeb
<svc_sock_update_bufs+145>
0x0000ded6 <svc_sock_update_bufs+124>:	mov    $0x7,%ecx
0x0000dedb <svc_sock_update_bufs+129>:	bts    %ecx,0x18(%edx)
0x0000dedf <svc_sock_update_bufs+133>:	mov    %eax,%edx
0x0000dee1 <svc_sock_update_bufs+135>:	mov    (%eax),%eax
0x0000dee3 <svc_sock_update_bufs+137>:	lea    0x0(%esi,1),%esi
0x0000dee7 <svc_sock_update_bufs+141>:	cmp    %ebx,%edx
0x0000dee9 <svc_sock_update_bufs+143>:	jne    0xdedb
<svc_sock_update_bufs+129>
0x0000deeb <svc_sock_update_bufs+145>:	mov    0x44(%esi),%edx
0x0000deee <svc_sock_update_bufs+148>:	mov    (%edx),%eax
0x0000def0 <svc_sock_update_bufs+150>:	lea    0x0(%esi,1),%esi
0x0000def4 <svc_sock_update_bufs+154>:	lea    0x44(%esi),%ebx
0x0000def7 <svc_sock_update_bufs+157>:	cmp    %ebx,%edx
0x0000def9 <svc_sock_update_bufs+159>:	je     0xdf10
<svc_sock_update_bufs+182>
0x0000defb <svc_sock_update_bufs+161>:	mov    $0x7,%ecx
0x0000df00 <svc_sock_update_bufs+166>:	bts    %ecx,0x18(%edx)
0x0000df04 <svc_sock_update_bufs+170>:	mov    %eax,%edx
0x0000df06 <svc_sock_update_bufs+172>:	mov    (%eax),%eax
0x0000df08 <svc_sock_update_bufs+174>:	lea    0x0(%esi,1),%esi
0x0000df0c <svc_sock_update_bufs+178>:	cmp    %ebx,%edx
0x0000df0e <svc_sock_update_bufs+180>:	jne    0xdf00
<svc_sock_update_bufs+166>
0x0000df10 <svc_sock_update_bufs+182>:	cmpl   $0x1d244b3c,0x18(%esi)
0x0000df17 <svc_sock_update_bufs+189>:	je     0xdf3c
<svc_sock_update_bufs+226>
0x0000df19 <svc_sock_update_bufs+191>:	lea    0x18(%esi),%eax
0x0000df1c <svc_sock_update_bufs+194>:	movl   $0x428,0x8(%esp,1)
0x0000df24 <svc_sock_update_bufs+202>:	movl   $0x6c2,0x4(%esp,1)
0x0000df2c <svc_sock_update_bufs+210>:	mov    %eax,0xc(%esp,1)
0x0000df30 <svc_sock_update_bufs+214>:	movl   $0x23e0,(%esp,1)
0x0000df37 <svc_sock_update_bufs+221>:	call   0xdf38
<svc_sock_update_bufs+222>
0x0000df3c <svc_sock_update_bufs+226>:	mov    0x1c(%esi),%eax
0x0000df3f <svc_sock_update_bufs+229>:	test   %eax,%eax
0x0000df41 <svc_sock_update_bufs+231>:	jne    0xdf4a
<svc_sock_update_bufs+240>
0x0000df43 <svc_sock_update_bufs+233>:	mov    0x20(%esi),%eax
0x0000df46 <svc_sock_update_bufs+236>:	test   %eax,%eax
0x0000df48 <svc_sock_update_bufs+238>:	jne    0xdf5c
<svc_sock_update_bufs+258>
0x0000df4a <svc_sock_update_bufs+240>:	movl   $0x0,0x1c(%esi)
0x0000df51 <svc_sock_update_bufs+247>:	add    $0x1c,%esp
0x0000df54 <svc_sock_update_bufs+250>:	pop    %ebx
0x0000df55 <svc_sock_update_bufs+251>:	pop    %esi
0x0000df56 <svc_sock_update_bufs+252>:	pop    %ebp
0x0000df57 <svc_sock_update_bufs+253>:	jmp    0xdf58
<svc_sock_update_bufs+254>
0x0000df5c <svc_sock_update_bufs+258>:	lea    0x18(%esi),%eax
0x0000df5f <svc_sock_update_bufs+261>:	mov    %eax,0x10(%esp,1)
0x0000df63 <svc_sock_update_bufs+265>:	mov    0x24(%esi),%eax
0x0000df66 <svc_sock_update_bufs+268>:	movl   $0x428,0x8(%esp,1)
0x0000df6e <svc_sock_update_bufs+276>:	movl   $0x6c2,0x4(%esp,1)
0x0000df76 <svc_sock_update_bufs+284>:	mov    %eax,0xc(%esp,1)
0x0000df7a <svc_sock_update_bufs+288>:	movl   $0x2420,(%esp,1)
0x0000df81 <svc_sock_update_bufs+295>:	call   0xdf82
<svc_sock_update_bufs+296>
0x0000df86 <svc_sock_update_bufs+300>:	mov    0x20(%esi),%eax
0x0000df89 <svc_sock_update_bufs+303>:	sub    $0x1,%eax
0x0000df8c <svc_sock_update_bufs+306>:	mov    %eax,0x20(%esi)
0x0000df8f <svc_sock_update_bufs+309>:	jmp    0xdf4a
<svc_sock_update_bufs+240>
0x0000df91 <svc_sock_update_bufs+311>:	mov    0x2c(%esi),%eax
0x0000df94 <svc_sock_update_bufs+314>:	mov    %eax,0x18(%esp,1)
0x0000df98 <svc_sock_update_bufs+318>:	mov    0x28(%esi),%eax
0x0000df9b <svc_sock_update_bufs+321>:	mov    %eax,0x14(%esp,1)
0x0000df9f <svc_sock_update_bufs+325>:	lea    0x18(%esi),%eax
0x0000dfa2 <svc_sock_update_bufs+328>:	mov    %eax,0x10(%esp,1)
0x0000dfa6 <svc_sock_update_bufs+332>:	mov    0x24(%esi),%eax
0x0000dfa9 <svc_sock_update_bufs+335>:	movl   $0x41d,0x8(%esp,1)
0x0000dfb1 <svc_sock_update_bufs+343>:	movl   $0x6c2,0x4(%esp,1)
0x0000dfb9 <svc_sock_update_bufs+351>:	mov    %eax,0xc(%esp,1)
0x0000dfbd <svc_sock_update_bufs+355>:	movl   $0x2600,(%esp,1)
0x0000dfc4 <svc_sock_update_bufs+362>:	call   0xdfc5
<svc_sock_update_bufs+363>
0x0000dfc9 <svc_sock_update_bufs+367>:	mov    0x20(%esi),%eax
0x0000dfcc <svc_sock_update_bufs+370>:	sub    $0x1,%eax
0x0000dfcf <svc_sock_update_bufs+373>:	mov    %eax,0x20(%esi)
0x0000dfd2 <svc_sock_update_bufs+376>:	jmp    0xdeb1
<svc_sock_update_bufs+87>
End of assembler dump.

Hope this helps!

