Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267581AbTAHJNi>; Wed, 8 Jan 2003 04:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267628AbTAHJNi>; Wed, 8 Jan 2003 04:13:38 -0500
Received: from dns-h4s.com ([216.127.80.99]:18907 "EHLO secure.dns-h4s.com")
	by vger.kernel.org with ESMTP id <S267581AbTAHJN3>;
	Wed, 8 Jan 2003 04:13:29 -0500
Message-ID: <3E1BEDB9.6040101@bonaplus.com>
Date: Wed, 08 Jan 2003 03:22:01 -0600
From: javamaster <javamaster@bonaplus.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops on kernel 2.4.20
Content-Type: multipart/mixed;
 boundary="------------020801090106080603080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020801090106080603080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a RedHat 7.0 distro on a Pentium 200 system with 80mb of ram. I 
just upgraded my kernel to 2.4.20 and I keep getting an oops whenever 
I'm doing something fairly intensive (make dep for the kernel always 
causes it). I've attached the log captured by klogd, the output from 
ksymoops and the gdb disassemble of the offending function shrink_cache. 
  The system works fine with the 2.2.16-22 kernel that came with RedHat 
7.0. The only thing weird about my system is that the primary IDE 
interface is not working. Any ideas?

javamaster@bonaplus.com

--------------020801090106080603080702
Content-Type: text/plain;
 name="gdb_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gdb_output.txt"

GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux"...
(no debugging symbols found)...
(gdb) disassemble shrink_cah che
Dump of assembler code for function shrink_cache:
0xc0129280 <shrink_cache>:	push   %ebp
0xc0129281 <shrink_cache+1>:	push   %edi
0xc0129282 <shrink_cache+2>:	mov    %eax,%edi
0xc0129284 <shrink_cache+4>:	push   %esi
0xc0129285 <shrink_cache+5>:	push   %ebx
0xc0129286 <shrink_cache+6>:	mov    %edi,%ebx
0xc0129288 <shrink_cache+8>:	sub    $0x24,%esp
0xc012928b <shrink_cache+11>:	mov    %edx,0x10(%esp,1)
0xc012928f <shrink_cache+15>:	mov    0xc02b6058,%edx
0xc0129295 <shrink_cache+21>:	mov    %edx,%eax
0xc0129297 <shrink_cache+23>:	sar    $0x1f,%edx
0xc012929a <shrink_cache+26>:	idiv   0x38(%esp,1),%eax
0xc012929e <shrink_cache+30>:	mov    0x38(%esp,1),%edx
0xc01292a2 <shrink_cache+34>:	mov    %eax,%ebp
0xc01292a4 <shrink_cache+36>:	mov    $0xa,%eax
0xc01292a9 <shrink_cache+41>:	mov    %ecx,0xc(%esp,1)
0xc01292ad <shrink_cache+45>:	sub    %edx,%eax
0xc01292af <shrink_cache+47>:	mov    $0x66666667,%edx
0xc01292b4 <shrink_cache+52>:	mov    %al,%cl
0xc01292b6 <shrink_cache+54>:	mov    %edx,%eax
0xc01292b8 <shrink_cache+56>:	imul   %ebp,%eax
0xc01292ba <shrink_cache+58>:	sar    $0x2,%edx
0xc01292bd <shrink_cache+61>:	mov    %ebp,%eax
0xc01292bf <shrink_cache+63>:	sar    $0x1f,%eax
0xc01292c2 <shrink_cache+66>:	shl    %cl,%ebx
0xc01292c4 <shrink_cache+68>:	sub    %eax,%edx
0xc01292c6 <shrink_cache+70>:	cmp    %ebx,%edx
0xc01292c8 <shrink_cache+72>:	jle    0xc01292cc <shrink_cache+76>
0xc01292ca <shrink_cache+74>:	mov    %ebx,%edx
0xc01292cc <shrink_cache+76>:	dec    %ebp
0xc01292cd <shrink_cache+77>:	mov    %edx,0x8(%esp,1)
0xc01292d1 <shrink_cache+81>:	js     0xc0129583 <shrink_cache+771>
0xc01292d7 <shrink_cache+87>:	mov    0xc02613fc,%ecx
0xc01292dd <shrink_cache+93>:	cmp    $0xc02613f8,%ecx
0xc01292e3 <shrink_cache+99>:	je     0xc0129583 <shrink_cache+771>
0xc01292e9 <shrink_cache+105>:	mov    $0xffffe000,%edx
0xc01292ee <shrink_cache+110>:	and    %esp,%edx
0xc01292f0 <shrink_cache+112>:	movl   $0xffffe000,0x4(%esp,1)
0xc01292f8 <shrink_cache+120>:	mov    %edx,0x4(%esp,1)
0xc01292fc <shrink_cache+124>:	lea    0x0(%esi,1),%esi
0xc0129300 <shrink_cache+128>:	mov    0x4(%esp,1),%edx
0xc0129304 <shrink_cache+132>:	mov    0x14(%edx),%eax
0xc0129307 <shrink_cache+135>:	test   %eax,%eax
0xc0129309 <shrink_cache+137>:	je     0xc0129320 <shrink_cache+160>
0xc012930b <shrink_cache+139>:	movl   $0x0,(%edx)
0xc0129311 <shrink_cache+145>:	call   0xc0110840 <schedule>
0xc0129316 <shrink_cache+150>:	jmp    0xc012956e <shrink_cache+750>
0xc012931b <shrink_cache+155>:	nop    
0xc012931c <shrink_cache+156>:	lea    0x0(%esi,1),%esi
0xc0129320 <shrink_cache+160>:	lea    0xffffffe4(%ecx),%esi
0xc0129323 <shrink_cache+163>:	mov    0xfffffffc(%ecx),%eax
0xc0129326 <shrink_cache+166>:	xor    $0x40,%eax
0xc0129329 <shrink_cache+169>:	and    $0x40,%eax
0xc012932c <shrink_cache+172>:	je     0xc0129336 <shrink_cache+182>
0xc012932e <shrink_cache+174>:	ud2a   
0xc0129330 <shrink_cache+176>:	add    %di,0x22(%esp,%ebx,4)
0xc0129335 <shrink_cache+181>:	rorb   $0x0,0x80a9fc41(%ebx)
0xc012933c <shrink_cache+188>:	add    %al,(%eax)
0xc012933e <shrink_cache+190>:	je     0xc0129348 <shrink_cache+200>
0xc0129340 <shrink_cache+192>:	ud2a   
0xc0129342 <shrink_cache+194>:	addr16 add %edi,-100(%si)
0xc0129346 <shrink_cache+198>:	and    %al,%al
0xc0129348 <shrink_cache+200>:	mov    (%ecx),%eax
0xc012934a <shrink_cache+202>:	mov    0x4(%ecx),%edx
0xc012934d <shrink_cache+205>:	xor    %ebx,%ebx
0xc012934f <shrink_cache+207>:	mov    %edx,0x4(%eax)
0xc0129352 <shrink_cache+210>:	mov    %eax,(%edx)
0xc0129354 <shrink_cache+212>:	movl   $0x0,(%ecx)
0xc012935a <shrink_cache+218>:	movl   $0x0,0x4(%ecx)
0xc0129361 <shrink_cache+225>:	mov    0xc02613f8,%eax
0xc0129366 <shrink_cache+230>:	mov    %ecx,0x4(%eax)
0xc0129369 <shrink_cache+233>:	mov    %eax,(%ecx)
0xc012936b <shrink_cache+235>:	movl   $0xc02613f8,0x4(%ecx)
0xc0129372 <shrink_cache+242>:	mov    %ecx,0xc02613f8
0xc0129378 <shrink_cache+248>:	mov    0xfffffff8(%ecx),%eax
0xc012937b <shrink_cache+251>:	test   %eax,%eax
0xc012937d <shrink_cache+253>:	sete   %bl
0xc0129380 <shrink_cache+256>:	test   %ebx,%ebx
0xc0129382 <shrink_cache+258>:	jne    0xc012956e <shrink_cache+750>
0xc0129388 <shrink_cache+264>:	xor    %eax,%eax
0xc012938a <shrink_cache+266>:	mov    0xffffffff(%ecx),%al
0xc012938d <shrink_cache+269>:	mov    0xc02b605c(,%eax,4),%edx
0xc0129394 <shrink_cache+276>:	mov    0x10(%esp,1),%eax
0xc0129398 <shrink_cache+280>:	mov    0x98(%eax),%eax
0xc012939e <shrink_cache+286>:	cmp    %eax,0x98(%edx)
0xc01293a4 <shrink_cache+292>:	jne    0xc012956e <shrink_cache+750>
0xc01293aa <shrink_cache+298>:	cmp    0x10(%esp,1),%edx
0xc01293ae <shrink_cache+302>:	ja     0xc012956e <shrink_cache+750>
0xc01293b4 <shrink_cache+308>:	mov    0x28(%esi),%eax
0xc01293b7 <shrink_cache+311>:	test   %eax,%eax
0xc01293b9 <shrink_cache+313>:	jne    0xc01293d2 <shrink_cache+338>
0xc01293bb <shrink_cache+315>:	mov    0xfffffff8(%ecx),%eax
0xc01293be <shrink_cache+318>:	cmp    $0x1,%eax
0xc01293c1 <shrink_cache+321>:	jne    0xc0129503 <shrink_cache+643>
0xc01293c7 <shrink_cache+327>:	mov    0xffffffec(%ecx),%edx
0xc01293ca <shrink_cache+330>:	test   %edx,%edx
0xc01293cc <shrink_cache+332>:	je     0xc0129503 <shrink_cache+643>
0xc01293d2 <shrink_cache+338>:	bts    %ebx,0xfffffffc(%ecx)
0xc01293d6 <shrink_cache+342>:	sbb    %eax,%eax
0xc01293d8 <shrink_cache+344>:	test   %eax,%eax
0xc01293da <shrink_cache+346>:	je     0xc0129413 <shrink_cache+403>
0xc01293dc <shrink_cache+348>:	mov    0xfffffffc(%ecx),%eax
0xc01293df <shrink_cache+351>:	test   $0x8000,%eax
0xc01293e4 <shrink_cache+356>:	je     0xc012956e <shrink_cache+750>
0xc01293ea <shrink_cache+362>:	testl  $0x100,0xc(%esp,1)
0xc01293f2 <shrink_cache+370>:	je     0xc012956e <shrink_cache+750>
0xc01293f8 <shrink_cache+376>:	incl   0xfffffff8(%ecx)
0xc01293fb <shrink_cache+379>:	mov    0xfffffffc(%ecx),%eax
0xc01293fe <shrink_cache+382>:	and    $0x1,%eax
0xc0129401 <shrink_cache+385>:	je     0xc01294c7 <shrink_cache+583>
0xc0129407 <shrink_cache+391>:	push   %esi
0xc0129408 <shrink_cache+392>:	call   0xc0122f10 <___wait_on_page>
0xc012940d <shrink_cache+397>:	pop    %eax
0xc012940e <shrink_cache+398>:	jmp    0xc01294c7 <shrink_cache+583>
0xc0129413 <shrink_cache+403>:	mov    0xfffffffc(%ecx),%eax
0xc0129416 <shrink_cache+406>:	and    $0x10,%eax
0xc0129419 <shrink_cache+409>:	je     0xc0129480 <shrink_cache+512>
0xc012941b <shrink_cache+411>:	mov    0xfffffff8(%ecx),%edx
0xc012941e <shrink_cache+414>:	mov    0x28(%esi),%ecx
0xc0129421 <shrink_cache+417>:	test   %ecx,%ecx
0xc0129423 <shrink_cache+419>:	je     0xc0129430 <shrink_cache+432>
0xc0129425 <shrink_cache+421>:	xor    %eax,%eax
0xc0129427 <shrink_cache+423>:	cmp    $0x2,%edx
0xc012942a <shrink_cache+426>:	jmp    0xc0129435 <shrink_cache+437>
0xc012942c <shrink_cache+428>:	lea    0x0(%esi,1),%esi
0xc0129430 <shrink_cache+432>:	xor    %eax,%eax
0xc0129432 <shrink_cache+434>:	cmp    $0x1,%edx
0xc0129435 <shrink_cache+437>:	sete   %al
0xc0129438 <shrink_cache+440>:	test   %eax,%eax
0xc012943a <shrink_cache+442>:	je     0xc0129483 <shrink_cache+515>
0xc012943c <shrink_cache+444>:	mov    0x8(%esi),%eax
0xc012943f <shrink_cache+447>:	test   %eax,%eax
0xc0129441 <shrink_cache+449>:	je     0xc0129483 <shrink_cache+515>
0xc0129443 <shrink_cache+451>:	mov    0x1c(%eax),%eax
0xc0129446 <shrink_cache+454>:	testl  $0x100,0xc(%esp,1)
0xc012944e <shrink_cache+462>:	mov    (%eax),%edx
0xc0129450 <shrink_cache+464>:	je     0xc0129483 <shrink_cache+515>
0xc0129452 <shrink_cache+466>:	test   %edx,%edx
0xc0129454 <shrink_cache+468>:	je     0xc0129483 <shrink_cache+515>
0xc0129456 <shrink_cache+470>:	mov    $0x4,%eax
0xc012945b <shrink_cache+475>:	btr    %eax,0x18(%esi)
0xc012945f <shrink_cache+479>:	mov    $0xf,%eax
0xc0129464 <shrink_cache+484>:	bts    %eax,0x18(%esi)
0xc0129468 <shrink_cache+488>:	incl   0x14(%esi)
0xc012946b <shrink_cache+491>:	push   %esi
0xc012946c <shrink_cache+492>:	call   *%edx
0xc012946e <shrink_cache+494>:	mov    %esi,%eax
0xc0129470 <shrink_cache+496>:	xor    %edx,%edx
0xc0129472 <shrink_cache+498>:	call   0xc012a650 <__free_pages>
0xc0129477 <shrink_cache+503>:	pop    %esi
0xc0129478 <shrink_cache+504>:	jmp    0xc012956e <shrink_cache+750>
0xc012947d <shrink_cache+509>:	lea    0x0(%esi),%esi
0xc0129480 <shrink_cache+512>:	mov    0x28(%esi),%ecx
0xc0129483 <shrink_cache+515>:	test   %ecx,%ecx
0xc0129485 <shrink_cache+517>:	je     0xc01294d5 <shrink_cache+597>
0xc0129487 <shrink_cache+519>:	incl   0x14(%esi)
0xc012948a <shrink_cache+522>:	mov    0xc(%esp,1),%ebx
0xc012948e <shrink_cache+526>:	push   %ebx
0xc012948f <shrink_cache+527>:	push   %esi
0xc0129490 <shrink_cache+528>:	call   0xc0131ff0 <try_to_release_page>
0xc0129495 <shrink_cache+533>:	pop    %edx
0xc0129496 <shrink_cache+534>:	test   %eax,%eax
0xc0129498 <shrink_cache+536>:	pop    %ecx
0xc0129499 <shrink_cache+537>:	je     0xc01294c0 <shrink_cache+576>
0xc012949b <shrink_cache+539>:	mov    0x8(%esi),%eax
0xc012949e <shrink_cache+542>:	test   %eax,%eax
0xc01294a0 <shrink_cache+544>:	jne    0xc01294b5 <shrink_cache+565>
0xc01294a2 <shrink_cache+546>:	mov    %esi,%eax
0xc01294a4 <shrink_cache+548>:	call   0xc0122fd0 <unlock_page>
0xc01294a9 <shrink_cache+553>:	mov    %esi,%eax
0xc01294ab <shrink_cache+555>:	call   0xc0128d30 <__lru_cache_del>
0xc01294b0 <shrink_cache+560>:	jmp    0xc0129562 <shrink_cache+738>
0xc01294b5 <shrink_cache+565>:	xor    %edx,%edx
0xc01294b7 <shrink_cache+567>:	mov    %esi,%eax
0xc01294b9 <shrink_cache+569>:	call   0xc012a650 <__free_pages>
0xc01294be <shrink_cache+574>:	jmp    0xc01294d5 <shrink_cache+597>
0xc01294c0 <shrink_cache+576>:	mov    %esi,%eax
0xc01294c2 <shrink_cache+578>:	call   0xc0122fd0 <unlock_page>
0xc01294c7 <shrink_cache+583>:	xor    %edx,%edx
0xc01294c9 <shrink_cache+585>:	mov    %esi,%eax
0xc01294cb <shrink_cache+587>:	call   0xc012a650 <__free_pages>
0xc01294d0 <shrink_cache+592>:	jmp    0xc012956e <shrink_cache+750>
0xc01294d5 <shrink_cache+597>:	mov    0x8(%esi),%ecx
0xc01294d8 <shrink_cache+600>:	test   %ecx,%ecx
0xc01294da <shrink_cache+602>:	je     0xc01294fc <shrink_cache+636>
0xc01294dc <shrink_cache+604>:	mov    0x28(%esi),%ebx
0xc01294df <shrink_cache+607>:	mov    0x14(%esi),%edx
0xc01294e2 <shrink_cache+610>:	test   %ebx,%ebx
0xc01294e4 <shrink_cache+612>:	je     0xc01294f0 <shrink_cache+624>
0xc01294e6 <shrink_cache+614>:	xor    %eax,%eax
0xc01294e8 <shrink_cache+616>:	cmp    $0x2,%edx
0xc01294eb <shrink_cache+619>:	jmp    0xc01294f5 <shrink_cache+629>
0xc01294ed <shrink_cache+621>:	lea    0x0(%esi),%esi
0xc01294f0 <shrink_cache+624>:	xor    %eax,%eax
0xc01294f2 <shrink_cache+626>:	cmp    $0x1,%edx
0xc01294f5 <shrink_cache+629>:	sete   %al
0xc01294f8 <shrink_cache+632>:	test   %eax,%eax
0xc01294fa <shrink_cache+634>:	jne    0xc0129520 <shrink_cache+672>
0xc01294fc <shrink_cache+636>:	mov    %esi,%eax
0xc01294fe <shrink_cache+638>:	call   0xc0122fd0 <unlock_page>
0xc0129503 <shrink_cache+643>:	decl   0x8(%esp,1)
0xc0129507 <shrink_cache+647>:	jns    0xc012956e <shrink_cache+750>
0xc0129509 <shrink_cache+649>:	mov    0x10(%esp,1),%ecx
0xc012950d <shrink_cache+653>:	mov    0xc(%esp,1),%edx
0xc0129511 <shrink_cache+657>:	mov    0x38(%esp,1),%eax
0xc0129515 <shrink_cache+661>:	call   0xc0128dc0 <swap_out>
0xc012951a <shrink_cache+666>:	jmp    0xc0129583 <shrink_cache+771>
0xc012951c <shrink_cache+668>:	lea    0x0(%esi,1),%esi
0xc0129520 <shrink_cache+672>:	mov    0x18(%esi),%eax
0xc0129523 <shrink_cache+675>:	and    $0x10,%eax
0xc0129526 <shrink_cache+678>:	je     0xc0129531 <shrink_cache+689>
0xc0129528 <shrink_cache+680>:	mov    %esi,%eax
0xc012952a <shrink_cache+682>:	call   0xc0122fd0 <unlock_page>
0xc012952f <shrink_cache+687>:	jmp    0xc012956e <shrink_cache+750>
0xc0129531 <shrink_cache+689>:	cmp    $0xc0261460,%ecx
0xc0129537 <shrink_cache+695>:	je     0xc0129542 <shrink_cache+706>
0xc0129539 <shrink_cache+697>:	push   %esi
0xc012953a <shrink_cache+698>:	call   0xc0122460 <__remove_inode_page>
0xc012953f <shrink_cache+703>:	pop    %ecx
0xc0129540 <shrink_cache+704>:	jmp    0xc0129554 <shrink_cache+724>
0xc0129542 <shrink_cache+706>:	mov    0xc(%esi),%ebx
0xc0129545 <shrink_cache+709>:	push   %esi
0xc0129546 <shrink_cache+710>:	call   0xc012a9f0 <__delete_from_swap_cache>
0xc012954b <shrink_cache+715>:	mov    %ebx,(%esp,1)
0xc012954e <shrink_cache+718>:	call   0xc012af10 <swap_free>
0xc0129553 <shrink_cache+723>:	pop    %edx
0xc0129554 <shrink_cache+724>:	mov    %esi,%eax
0xc0129556 <shrink_cache+726>:	call   0xc0128d30 <__lru_cache_del>
0xc012955b <shrink_cache+731>:	mov    %esi,%eax
0xc012955d <shrink_cache+733>:	call   0xc0122fd0 <unlock_page>
0xc0129562 <shrink_cache+738>:	xor    %edx,%edx
0xc0129564 <shrink_cache+740>:	mov    %esi,%eax
0xc0129566 <shrink_cache+742>:	call   0xc012a650 <__free_pages>
0xc012956b <shrink_cache+747>:	dec    %edi
0xc012956c <shrink_cache+748>:	je     0xc0129583 <shrink_cache+771>
0xc012956e <shrink_cache+750>:	dec    %ebp
0xc012956f <shrink_cache+751>:	js     0xc0129583 <shrink_cache+771>
0xc0129571 <shrink_cache+753>:	mov    0xc02613fc,%ecx
0xc0129577 <shrink_cache+759>:	cmp    $0xc02613f8,%ecx
0xc012957d <shrink_cache+765>:	jne    0xc0129300 <shrink_cache+128>
0xc0129583 <shrink_cache+771>:	mov    %edi,%eax
0xc0129585 <shrink_cache+773>:	add    $0x24,%esp
0xc0129588 <shrink_cache+776>:	pop    %ebx
0xc0129589 <shrink_cache+777>:	pop    %esi
0xc012958a <shrink_cache+778>:	pop    %edi
0xc012958b <shrink_cache+779>:	pop    %ebp
0xc012958c <shrink_cache+780>:	ret    
0xc012958d <shrink_cache+781>:	lea    0x0(%esi),%esi
End of assembler dump.
(gdb) q

--------------020801090106080603080702
Content-Type: text/plain;
 name="ksymoops_output.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops_output.txt"

ksymoops 2.4.8 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000400
<4>00000400
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000400>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000004
<4>esi: 00000004   edi: 00000019   ebp: 0000094e   esp: c11aff28
<4>ds: 0018   es: 0018   ss: 0018
<4>Process kswapd (pid: 4, stackpage=c11af000)
<4>Stack: c10aa504 c0129553 c02b60a0 00000020 c11ae000 000000ef 000001d0 c0261570 
<4>       00007006 00000020 00000018 00000018 00000020 000001d0 00000006 00007006 
<4>       c01296e5 00000006 00000003 c0261570 00000006 000001d0 c0261570 00000000 
<4>Call Trace:    [shrink_cache+723/784] [shrink_caches+85/128] [try_to_free_pages_zone+48/80] [kswapd_balance_pgdat+69/144] [kswapd_balance+22/48]
<4>Code:  Bad EIP value.


>>EIP; 00000400 Before first symbol   <=====

>>ebx; c02b60a0 <swap_info+0/680>

<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000300
<4>00000300
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000300>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000003
<4>esi: 00000003   edi: 00000020   ebp: 00000980   esp: c067bd88
<4>ds: 0018   es: 0018   ss: 0018
<4>Process mkdep (pid: 1565, stackpage=c067b000)
<4>Stack: c10a4e38 c0129553 c02b60a0 00000202 c067a000 000000f1 000001d2 c0261570 
<4>       c10df0c0 c34f14c0 c10dfcfc 00000001 00000020 000001d2 00000006 00007222 
<4>       c01296e5 00000006 00000003 c0261570 00000006 000001d2 c0261570 00000000 
<4>Call Trace:    [shrink_cache+723/784] [shrink_caches+85/128] [try_to_free_pages_zone+48/80] [balance_classzone+90/528] [__alloc_pages+274/368]
<4>Code:  Bad EIP value.


>>EIP; 00000300 Before first symbol   <=====

>>ebx; c02b60a0 <swap_info+0/680>


1 warning issued.  Results may not be reliable.

--------------020801090106080603080702
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

klogd 1.3-3, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.4.20
Loaded 15928 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
No module symbols loaded.
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000400
<4> printing eip:
<4>00000400
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000400>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000004
<4>esi: 00000004   edi: 00000019   ebp: 0000094e   esp: c11aff28
<4>ds: 0018   es: 0018   ss: 0018
<4>Process kswapd (pid: 4, stackpage=c11af000)
<4>Stack: c10aa504 c0129553 c02b60a0 00000020 c11ae000 000000ef 000001d0 c0261570 
<4>       00007006 00000020 00000018 00000018 00000020 000001d0 00000006 00007006 
<4>       c01296e5 00000006 00000003 c0261570 00000006 000001d0 c0261570 00000000 
<4>Call Trace:    [shrink_cache+723/784] [shrink_caches+85/128] [try_to_free_pages_zone+48/80] [kswapd_balance_pgdat+69/144] [kswapd_balance+22/48]
<4>  [kswapd+161/192] [kswapd+0/192] [kernel_thread+43/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000300
<4> printing eip:
<4>00000300
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000300>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000003
<4>esi: 00000003   edi: 00000020   ebp: 00000980   esp: c067bd88
<4>ds: 0018   es: 0018   ss: 0018
<4>Process mkdep (pid: 1565, stackpage=c067b000)
<4>Stack: c10a4e38 c0129553 c02b60a0 00000202 c067a000 000000f1 000001d2 c0261570 
<4>       c10df0c0 c34f14c0 c10dfcfc 00000001 00000020 000001d2 00000006 00007222 
<4>       c01296e5 00000006 00000003 c0261570 00000006 000001d2 c0261570 00000000 
<4>Call Trace:    [shrink_cache+723/784] [shrink_caches+85/128] [try_to_free_pages_zone+48/80] [balance_classzone+90/528] [__alloc_pages+274/368]
<4>  [page_cache_read+95/192] [read_cluster_nonblocking+41/64] [filemap_nopage+269/528] [iget4+211/224] [filemap_nopage+0/528] [do_no_page+83/464]
<4>  [handle_mm_fault+88/192] [do_mmap_pgoff+1240/1440] [do_page_fault+390/1227] [open_namei+728/1280] [old_mmap+258/320] [old_mmap+298/320]
<4>  [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000100
<4> printing eip:
<4>00000100
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000100>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000001
<4>esi: 00000001   edi: 00000013   ebp: 0000096c   esp: c43b7dcc
<4>ds: 0018   es: 0018   ss: 0018
<4>Process gdb (pid: 1573, stackpage=c43b7000)
<4>Stack: c10cfcb0 c0129553 c02b60a0 00000003 c43b6000 000000e8 000001d2 c0261570 
<4>       c10dfbb8 c38e7040 c10df48c 00000000 00000020 000001d2 00000006 0000723a 
<4>       c01296e5 00000006 00000003 c0261570 00000006 000001d2 c0261570 00000000 
<4>Call Trace:    [shrink_cache+723/784] [shrink_caches+85/128] [try_to_free_pages_zone+48/80] [balance_classzone+90/528] [__alloc_pages+274/368]
<4>  [do_anonymous_page+94/320] [do_no_page+53/464] [handle_mm_fault+88/192] [do_page_fault+390/1227] [update_process_times+32/176] [update_wall_time+11/64]
<4>  [timer_bh+39/928] [timer_interrupt+116/288] [bh_action+27/80] [tasklet_hi_action+70/112] [do_softirq+85/160] [do_page_fault+0/1227]
<4>  [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000400
<4> printing eip:
<4>00000400
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000400>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000004
<4>esi: 00000004   edi: c4e09ff8   ebp: c1130220   esp: c3dede9c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process rhnsd (pid: 776, stackpage=c3ded000)
<4>Stack: c10b26f4 c0120836 c02b60a0 00000002 bfffef20 00000001 c1130220 c112ef60 
<4>       c0120c2b c1130220 c112ef60 bfffef20 c4e09ff8 00000400 00000001 0000000f 
<4>       c3dec560 c4db619c c4db619c c3dedf30 c01069ed 0000000f c4db619c c1130220 
<4>Call Trace:    [do_swap_page+134/256] [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [dput+289/336]
<4>  [schedule_timeout+132/160] [process_timeout+0/80] [sys_nanosleep+272/400] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000300
<4> printing eip:
<4>00000300
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000300>]    Not tainted
<4>EFLAGS: 00010207
<4>eax: 00000000   ebx: c02b60a0   ecx: c5804000   edx: 00003fde
<4>esi: 00000003   edi: c10b11a4   ebp: c10bf038   esp: c3dedca4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process rhnsd (pid: 776, stackpage=c3ded000)
<4>Stack: c10b11a4 c012aa80 c02b60a0 c02b60a0 c02b60a0 c012b11f c10b11a4 00000300 
<4>       00004000 00003000 c011f8b9 00000300 00000002 c4e0a4e0 00000000 40139000 
<4>       c3def400 40135000 00000000 40139000 c3def400 00000001 c01a0db4 c02c1f14 
<4>Call Trace:    [delete_from_swap_cache+64/80] [free_swap_and_cache+111/160] [zap_page_range+409/640] [poke_blanked_console+100/112] [fput+198/240]
<4>  [exit_mmap+177/288] [mmput+81/112] [do_exit+143/544] [bust_spinlocks+62/80] [die+77/112] [do_page_fault+919/1227]
<4>  [start_request+430/544] [ide_do_request+664/736] [do_ide_request+15/32] [schedule+772/816] [do_page_fault+0/1227] [error_code+52/64]
<4>  [do_swap_page+134/256] [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [dput+289/336] [schedule_timeout+132/160]
<4>  [process_timeout+0/80] [sys_nanosleep+272/400] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel paging request at virtual address 00001300
<4> printing eip:
<4>00001300
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00001300>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000013
<4>esi: 00000013   edi: c41b3798   ebp: c1130520   esp: c3e85e9c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process xfs (pid: 744, stackpage=c3e85000)
<4>Stack: c10a9928 c0120836 c02b60a0 00000001 401e6004 00000000 c1130520 c4496e60 
<4>       c0120c2b c1130520 c4496e60 401e6004 c41b3798 00001300 00000000 0000000f 
<4>       c3e84560 c4af367c c4af367c c3e85f30 c01069ed 0000000f c4af367c c1130520 
<4>Call Trace:    [do_swap_page+134/256] [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [do_sigaction+197/256]
<4>  [sys_rt_sigaction+153/240] [sys_socketcall+289/528] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000500
<4> printing eip:
<4>00000500
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00000500>]    Not tainted
<4>EFLAGS: 00010203
<4>eax: 00000000   ebx: c02b60a0   ecx: c5804000   edx: 00003fdf
<4>esi: 00000005   edi: c10a93d4   ebp: c10a9400   esp: c3e85ca4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process xfs (pid: 744, stackpage=c3e85000)
<4>Stack: c10a93d4 c012aa80 c02b60a0 c02b60a0 c02b60a0 c012b11f c10a93d4 00000500 
<4>       00009000 00004000 c011f8b9 00000500 00000004 c41b322c 00000000 40090000 
<4>       c3e97400 40087000 00000000 40090000 c3e97400 00000001 c01a0db4 c02c1f14 
<4>Call Trace:    [delete_from_swap_cache+64/80] [free_swap_and_cache+111/160] [zap_page_range+409/640] [poke_blanked_console+100/112] [fput+198/240]
<4>  [exit_mmap+177/288] [call_console_drivers+224/240] [mmput+81/112] [do_exit+143/544] [bust_spinlocks+62/80] [die+77/112]
<4>  [do_page_fault+919/1227] [sock_def_readable+34/80] [unix_dgram_sendmsg+804/896] [vsnprintf+681/1088] [do_page_fault+0/1227] [error_code+52/64]
<4>  [do_swap_page+134/256] [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [do_sigaction+197/256] [sys_rt_sigaction+153/240]
<4>  [sys_socketcall+289/528] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel paging request at virtual address 00001600
<4> printing eip:
<4>00001600
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00001600>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 00000016
<4>esi: 00000016   edi: c42934c8   ebp: c11307a0   esp: c40c5e9c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process gpm (pid: 571, stackpage=c40c5000)
<4>Stack: c10b3220 c0120836 c02b60a0 00000001 401325e8 00000000 c11307a0 c4e35980 
<4>       c0120c2b c11307a0 c4e35980 401325e8 c42934c8 00001600 00000000 c1162040 
<4>       c10d9314 000008c0 000008e0 c1162040 c10d9314 00000000 c10d9314 c11307a0 
<4>Call Trace:    [do_swap_page+134/256] [handle_mm_fault+107/192] [do_page_fault+390/1227] [ext2_delete_entry+387/400] [ext2_unlink+73/96]
<4>  [vfs_unlink+285/336] [path_release+16/48] [sys_unlink+186/240] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel paging request at virtual address 00001500
<4> printing eip:
<4>00001500
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00001500>]    Not tainted
<4>EFLAGS: 00010213
<4>eax: 00000000   ebx: c02b60a0   ecx: c5804000   edx: 00003fe0
<4>esi: 00000015   edi: c10b32a4   ebp: 4012f000   esp: c40c5ca4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process gpm (pid: 571, stackpage=c40c5000)
<4>Stack: c10b32a4 c012aa80 c02b60a0 c02b60a0 c02b60a0 c012b11f c10b32a4 00001500 
<4>       00006000 00000000 c011f8b9 00001500 00000000 c42934bc 00000000 40135000 
<4>       c40c6400 4012f000 00000000 40135000 c40c6400 00000001 c01a0db4 c02c1f14 
<4>Call Trace:    [delete_from_swap_cache+64/80] [free_swap_and_cache+111/160] [zap_page_range+409/640] [poke_blanked_console+100/112] [fput+198/240]
<4>  [exit_mmap+177/288] [call_console_drivers+224/240] [mmput+81/112] [do_exit+143/544] [bust_spinlocks+62/80] [die+77/112]
<4>  [do_page_fault+919/1227] [ext2_add_link+762/784] [do_page_fault+0/1227] [error_code+52/64] [do_swap_page+134/256] [handle_mm_fault+107/192]
<4>  [do_page_fault+390/1227] [ext2_delete_entry+387/400] [ext2_unlink+73/96] [vfs_unlink+285/336] [path_release+16/48] [sys_unlink+186/240]
<4>  [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel paging request at virtual address 00001a00
<4> printing eip:
<4>00001a00
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00001a00>]    Not tainted
<4>EFLAGS: 00010202
<4>eax: 00000001   ebx: c02b60a0   ecx: c5804000   edx: 0000001a
<4>esi: 0000001a   edi: c42ea2dc   ebp: c1130720   esp: c4155e9c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process sendmail (pid: 555, stackpage=c4155000)
<4>Stack: c10b3640 c0120836 c02b60a0 00000001 080b7d7c 00000000 c1130720 c426a1e0 
<4>       c0120c2b c1130720 c426a1e0 080b7d7c c42ea2dc 00001a00 00000000 0000000f 
<4>       c4154560 c4530bbc c4530bbc c4155f30 c01069ed 0000000f c4530bbc c1130720 
<4>Call Trace:    [do_swap_page+134/256] [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [do_getitimer+152/160]
<4>  [do_setitimer+115/240] [sys_alarm+50/80] [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
<4> <1>Unable to handle kernel paging request at virtual address 00001900
<4> printing eip:
<4>00001900
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<00001900>]    Not tainted
<4>EFLAGS: 00010207
<4>eax: 00000000   ebx: c02b60a0   ecx: c5804000   edx: 00003fe1
<4>esi: 00000019   edi: c10b5218   ebp: 080a7000   esp: c4155ca4
<4>ds: 0018   es: 0018   ss: 0018
<4>Process sendmail (pid: 555, stackpage=c4155000)
<4>Stack: c10b5218 c012aa80 c02b60a0 c02b60a0 c02b60a0 c012b11f c10b5218 00001900 
<4>       00004000 00000000 c011f8b9 00001900 00000000 c42ea29c 00000000 080ab000 
<4>       c4156080 080a7000 00000000 080ab000 c4156080 00000001 c01a0db4 c02c1f14 
<4>Call Trace:    [delete_from_swap_cache+64/80] [free_swap_and_cache+111/160] [zap_page_range+409/640] [poke_blanked_console+100/112] [vt_console_print+766/784]
<4>  [exit_mmap+177/288] [call_console_drivers+224/240] [mmput+81/112] [do_exit+143/544] [bust_spinlocks+62/80] [die+77/112]
<4>  [do_page_fault+919/1227] [do_no_page+53/464] [handle_mm_fault+88/192] [do_page_fault+0/1227] [error_code+52/64] [do_swap_page+134/256]
<4>  [handle_mm_fault+107/192] [handle_signal+125/256] [do_page_fault+390/1227] [do_getitimer+152/160] [do_setitimer+115/240] [sys_alarm+50/80]
<4>  [do_page_fault+0/1227] [error_code+52/64]
<4>
<4>Code:  Bad EIP value.
Kernel logging (proc) stopped.
Kernel log daemon terminating.

--------------020801090106080603080702--


