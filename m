Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbREXNwT>; Thu, 24 May 2001 09:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261975AbREXNwJ>; Thu, 24 May 2001 09:52:09 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:10464 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261960AbREXNwG>; Thu, 24 May 2001 09:52:06 -0400
To: John Lenton <jlenton@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to crash 2.4.4 w/SBLive
In-Reply-To: <20010524063754.5547.qmail@web11607.mail.yahoo.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 24 May 2001 09:50:31 -0400
In-Reply-To: John Lenton's message of "Wed, 23 May 2001 23:37:54 -0700 (PDT)"
Message-ID: <m23d9ux3dk.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Lenton <jlenton@yahoo.com> writes:

 John> I found to my dismay that it's extremely easy to crash 2.4.4 if
 John> it has a Live! in it. I have no way of getting at the oops, but
 John> somebody out there probably has both this soundcard and a
 John> serial console (or somethin').  I present it in the form of a
 John> script, but you'll probably have no problem realizing where the
 John> problem is. The number of "writers" never gets past 64. I guess
 John> the 65th should probably get the same as the 2nd writer does on
 John> other cards...

Extremely easy is relative.  At any rate, Alan Cox has some patches
that list fixes in the SBLive support (a memory leak).  I have ac13
installed and I ran your script.  I was able to get `Oops' messages,
and I found them in my dmesg.  I am unfamiliar with how I should use
ksyms to decode this for people... Are these physical addresses or
virtual?  I guess I should look at the source...  Anyways, the script
does *work* but not as advertised ;-)

fwiw,
Bill Pringlemeir.

inting eip:
c01caa92
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01caa92>]
EFLAGS: 00010097
eax: dfdfdfdf   ebx: ffffffff   ecx: c31f8f0c   edx: dfdfdfdf
esi: c11d8000   edi: c11d8000   ebp: 00000097   esp: c39e5f38
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 3424, stackpage=c39e5000)
Stack: c31f8e00 c11d8000 c09c0d00 00000000 dfdfdfdf c01c7957 c11d8000 c31f8e78 
       c09c0d00 c31f8e00 c11d8000 c01c78fa c09c0d00 00000246 c31f8e00 00001000 
       c01c400a c09c0d00 ffffffea c278e7e0 00001000 00000000 00001000 c39e4000 
Call Trace: [<dfdfdfdf>] [<c01c7957>] [<c01c78fa>] [<c01c400a>] [<c0130196>] 
   [<c0106b73>] 

Code: 89 50 04 89 02 8b 97 70 40 00 00 8d b7 70 40 00 00 89 54 24 
 <1>Unable to handle kernel paging request at virtual address 00008004
 printing eip:
c01caa92
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01caa92>]
EFLAGS: 00010086
eax: 00008000   ebx: ffffffff   ecx: c365b10c   edx: 00000001
esi: c11d8000   edi: c11d8000   ebp: 00000086   esp: c301ff38
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 3426, stackpage=c301f000)
Stack: c365b000 c11d8000 c09c0ce0 00000000 00000001 c01c7957 c11d8000 c365b078 
       c09c0ce0 c365b000 c11d8000 c01c78fa c09c0ce0 00000246 c365b000 00001000 
       c01c400a c09c0ce0 ffffffea c278e840 00001000 00000000 00001000 c301e000 
Call Trace: [<c01c7957>] [<c01c78fa>] [<c01c400a>] [<c0130196>] [<c0106b73>] 

Code: 89 50 04 89 02 8b 97 70 40 00 00 8d b7 70 40 00 00 89 54 24 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
 





