Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSDJNqL>; Wed, 10 Apr 2002 09:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313068AbSDJNqL>; Wed, 10 Apr 2002 09:46:11 -0400
Received: from sebula.traumatized.org ([193.121.72.130]:23172 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S313062AbSDJNqK>; Wed, 10 Apr 2002 09:46:10 -0400
Date: Wed, 10 Apr 2002 15:39:08 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: arch/sparc64/kernel/traps.c
Message-ID: <20020410133908.GJ11858@sparkie.is.traumatized.org>
In-Reply-To: <20020409212000.GK9996@sparkie.is.traumatized.org> <20020409.142329.55241651.davem@redhat.com> <20020409214734.GL9996@sparkie.is.traumatized.org> <20020409.155757.34666328.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i (Linux 2.4.19-pre5 sparc64)
X-unexpected: Noone expects the unexpected header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:10:10AM +0200, David S. Miller wrote:
> 
> ksymoops should be already installed on your system
> at /usr/bin/ksymoops, if it isn't find the package
> to install or complain to your distribution maintainer :-)
> 
> If you still want to compile ksymoops from source you need to update
> and install a new binutils to get the latest BFD library.

allright, ksymoops doesn't come with my distribution (Splack)
so i got the source, and went from there.

now it compiled nicely.

here's the output that i get (i'm not quite sure what to expect, so i
hope this is what you need:)


# ksymoops -m /boot/System.map-2.4.19-pre5 -v
/usr/src/linux2419pre5/vmlinux < oops.txt 
ksymoops 2.4.5 on sparc64 2.4.19-pre5.  Options used
     -v /usr/src/linux2419pre5/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5/ (default)
     -m /boot/System.map-2.4.19-pre5 (specified)

              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
TSTATE: 0000009911009601 TPC: 00000000005a39c0 TNPC: 00000000005a39c4
Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 0000000000000000 g1: 0000000000000084 g2: 0000000000000001 g3:
fffff800002131c0
g4: fffff80000000000 g5: 0000000000000001 g6: fffff80001ec4000 g7:
0000000000000001
o0: 0000000000000001 o1: 00fcfd0000000028 o2: 0000000000008027 o3:
0000000000000009
o4: fffff8002075b78a o5: 0000000019999997 sp: fffff80001ec7211
ret_pc: 0000000000486cac
l0: 0000000000000027 l1: fffff800263f7740 l2: 00fcfd0000000000 l3:
fffff80027ed5f50
l4: 000000000001aa6c l5: 0000000000000000 l6: fffff80024ac6000 l7:
0000000000000000
i0: fffff80007782620 i1: fffff8002075b6e0 i2: 00000000005d5158 i3:
0000000000486bc0
i4: 000000007015f0ec i5: 000000007015f0ec i6: fffff80001ec72d1 i7:
00000000004730a8
Caller[00000000004730a8]
Caller[0000000000473a24]
Caller[0000000000473d2c]
Caller[0000000000474268]
Caller[00000000004703ec]
Caller[00000000004112f4]
Caller[00000000700fc9cc]
Instruction DUMP: 00000000  00000000  00000000 <ca024000> 8e014008
cfe25005  80a14007  1247fffc  8143e00a 
Error (Oops_bfd_perror): set_section_contents Bad value


>>PC;  005a39c0 <__atomic_add+0/0>   <=====

>>g3; fffff800002131c0 <END_OF_CODE+fffff7fffe1f0329/????>
>>g4; fffff80000000000 <END_OF_CODE+fffff7fffdfdd169/????>
>>g6; fffff80001ec4000 <END_OF_CODE+fffff7ffffea1169/????>
>>o1; fcfd0000000028 <END_OF_CODE+fcfcfffdfdd191/????>
>>o2; 00008027 Before first symbol
>>o4; fffff8002075b78a <END_OF_CODE+fffff8001e7388f3/????>
>>o5; 19999997 <END_OF_CODE+17976b00/????>
>>sp; fffff80001ec7211 <END_OF_CODE+fffff7ffffea437a/????>
>>ret_pc; 00486cac <proc_lookupfd+ec/1a0>
>>l1; fffff800263f7740 <END_OF_CODE+fffff800243d48a9/????>
>>l2; fcfd0000000000 <END_OF_CODE+fcfcfffdfdd169/????>
>>l3; fffff80027ed5f50 <END_OF_CODE+fffff80025eb30b9/????>
>>l4; 0001aa6c Before first symbol
>>l6; fffff80024ac6000 <END_OF_CODE+fffff80022aa3169/????>
>>i0; fffff80007782620 <END_OF_CODE+fffff8000575f789/????>
>>i1; fffff8002075b6e0 <END_OF_CODE+fffff8001e738849/????>
>>i2; 005d5158 <proc_fd_inode_operations+0/80>
>>i3; 00486bc0 <proc_lookupfd+0/1a0>
>>i4; 7015f0ec <END_OF_CODE+6e13c255/????>
>>i5; 7015f0ec <END_OF_CODE+6e13c255/????>
>>i6; fffff80001ec72d1 <END_OF_CODE+fffff7ffffea443a/????>
>>i7; 004730a8 <real_lookup+68/140>

Trace; 004730a8 <real_lookup+68/140>
Trace; 00473a24 <link_path_walk+764/a60>
Trace; 00473d2c <path_walk+c/20>
Trace; 00474268 <__user_walk+48/80>
Trace; 004703ec <sys_lstat64+c/80>
Trace; 004112f4 <linux_sparc_syscall32+34/40>
Trace; 700fc9cc <END_OF_CODE+6e0d9b35/????>


1 error issued.  Results may not be reliable.
