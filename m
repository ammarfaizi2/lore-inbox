Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbQKHGoV>; Wed, 8 Nov 2000 01:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQKHGoK>; Wed, 8 Nov 2000 01:44:10 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:16397 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129272AbQKHGoF>;
	Wed, 8 Nov 2000 01:44:05 -0500
Message-ID: <3A08F5E9.61F424A0@ihug.co.nz>
Date: Wed, 08 Nov 2000 19:42:49 +1300
From: david <sector2@ihug.co.nz>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: off topic a bit but i realy need help c++ and kernel
X-Priority: 2 (High)
Content-Type: multipart/alternative;
 boundary="------------4212772E468A86840C898065"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------4212772E468A86840C898065
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi i am writing a video kernel driver for linux lexos and have got stuck

this is how NVIDIA do their regs

#define NV_PFIFO_RAMHT                                   0x00002210 /*
RW-4R */
#define NV_PFIFO_RAMHT_BASE_ADDRESS                             8:4 /*
RWIUF */
#define NV_PFIFO_RAMHT_BASE_ADDRESS_10000                0x00000010 /*
RWI-V */
#define NV_PFIFO_RAMHT_SIZE                                   17:16 /*
RWIUF */
#define NV_PFIFO_RAMHT_SIZE_4K                           0x00000000 /*
RWI-V */
#define NV_PFIFO_RAMHT_SIZE_8K                           0x00000001 /*
RW--V */
#define NV_PFIFO_RAMHT_SIZE_16K                          0x00000002 /*
RW--V */
#define NV_PFIFO_RAMHT_SIZE_32K                          0x00000003 /*
RW--V */
#define NV_PFIFO_RAMHT_SEARCH                                 25:24 /*
RWIUF */
#define NV_PFIFO_RAMHT_SEARCH_16                         0x00000000 /*
RWI-V */
#define NV_PFIFO_RAMHT_SEARCH_32                         0x00000001 /*
RW--V */
#define NV_PFIFO_RAMHT_SEARCH_64                         0x00000002 /*
RW--V */
#define NV_PFIFO_RAMHT_SEARCH_128                        0x00000003 /*
RW--V */

this can be used like setreg( NV_PFIFO_RAMHT , htbase << ( 0 ?
NV_PFIFO_RAMHT_BASE_ADDRESS)) ;
but i wont to make it better so i tried it this way

#define NV_PFIFO_RAMHT_BASE_ADDRESS 0x00002210:8:4:3 /* address : high
bit : low bit : mode 3 = rw
this seemed much better all on one line so you can do
setreg(NV_PFIFO_RAMHT_BASE_ADDRESS , htbase) ;
but ( 2 ? 1:2:3 ) dose not work
and NV_PFIFO_RAMHT_BASE_ADDRESS 0x00002210,8,4,3 dose not work as
setreg(a,h,l,m) thinks this is
all one agr
the other would be to have it as a big struct

but then compiler can not optimize it ( i think )
if i can use #define 's the it quicker and setreg can be an inline asm
marco

how would it work if i used 64 bit like this

bits 32 - 63 reg address
bits 24 - 31 high bit
bits 16 - 23 low  bit
bits 0  - 7  mode

#define NV_PFIFO_RAMHT_BASE_ADDRESS  0x0000221008040003

so if i sent this to the setreg(unsigned long long , data) asm macro it
would be in EAX:EDX (64 bit)
can the kernel use (long long) and (unsigned long long)  ( 64 bit ints)

that 64 bit way look good but is it ?
                   ( opps i wold need an extr 32 bits for value but can
have 64:32 i think )

has anyone got any help they can give me on this !please email me thank
you!
as i am stuck
also is there a down loadable book on c++ as i am just learning from
others ppl code and really
need a book to do it right

thank you david rundle <sector2@ihug.co.nz>








--------------4212772E468A86840C898065
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<tt>hi i am writing a video kernel driver for linux lexos and have got
stuck</tt><tt></tt>
<p><tt>this is how NVIDIA do their regs</tt><tt></tt>
<p><tt>#define NV_PFIFO_RAMHT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00002210 /* RW-4R */</tt>
<br><tt>#define NV_PFIFO_RAMHT_BASE_ADDRESS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
8:4 /* RWIUF */</tt>
<br><tt>#define NV_PFIFO_RAMHT_BASE_ADDRESS_10000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000010 /* RWI-V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
17:16 /* RWIUF */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SIZE_4K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000000 /* RWI-V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SIZE_8K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000001 /* RW--V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SIZE_16K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000002 /* RW--V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SIZE_32K&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000003 /* RW--V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SEARCH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
25:24 /* RWIUF */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SEARCH_16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000000 /* RWI-V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SEARCH_32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000001 /* RW--V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SEARCH_64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000002 /* RW--V */</tt>
<br><tt>#define NV_PFIFO_RAMHT_SEARCH_128&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0x00000003 /* RW--V */</tt><tt></tt>
<p><tt>this can be used like setreg( NV_PFIFO_RAMHT , htbase &lt;&lt; (
0 ? NV_PFIFO_RAMHT_BASE_ADDRESS)) ;</tt>
<br><tt>but i wont to make it better so i tried it this way</tt><tt></tt>
<p><tt>#define NV_PFIFO_RAMHT_BASE_ADDRESS 0x00002210:8:4:3 /* address
: high bit : low bit : mode 3 = rw</tt>
<br><tt>this seemed much better all on one line so you can do setreg(NV_PFIFO_RAMHT_BASE_ADDRESS
, htbase) ;</tt>
<br><tt>but ( 2 ? 1:2:3 ) dose not work</tt>
<br><tt>and NV_PFIFO_RAMHT_BASE_ADDRESS 0x00002210,8,4,3 dose not work
as setreg(a,h,l,m) thinks this is</tt>
<br><tt>all one agr</tt>
<br><tt>the other would be to have it as a big struct</tt><tt></tt>
<p><tt>but then compiler can not optimize it ( i think )</tt>
<br><tt>if i can use #define 's the it quicker and setreg can be an inline
asm marco</tt><tt></tt>
<p><tt>how would it work if i used 64 bit like this</tt><tt></tt>
<p><tt>bits 32 - 63 reg address</tt>
<br><tt>bits 24 - 31 high bit</tt>
<br><tt>bits 16 - 23 low&nbsp; bit</tt>
<br><tt>bits 0&nbsp; - 7&nbsp; mode</tt><tt></tt>
<p><tt>#define NV_PFIFO_RAMHT_BASE_ADDRESS&nbsp; 0x0000221008040003</tt><tt></tt>
<p><tt>so if i sent this to the setreg(unsigned long long , data) asm macro
it would be in EAX:EDX (64 bit)</tt>
<br><tt>can the kernel use (long long) and (unsigned long long)&nbsp; (
64 bit ints)</tt><tt></tt>
<p><tt>that 64 bit way look good but is it ?</tt>
<br><tt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
( opps i wold need an extr 32 bits for value but can have 64:32 i think
)</tt><tt></tt>
<p><tt>has anyone got any help they can give me on this !please email me
thank you!</tt>
<br><tt>as i am stuck</tt>
<br><tt>also is there a down loadable book on c++ as i am just learning
from others ppl code and really</tt>
<br><tt>need a book to do it right</tt><tt></tt>
<p><tt>thank you david rundle &lt;sector2@ihug.co.nz></tt>
<br><tt>&nbsp;</tt>
<br><tt></tt>&nbsp;
<br><tt></tt>&nbsp;
<br><tt></tt>&nbsp;
<br><tt></tt>&nbsp;
<br><tt></tt>&nbsp;
<br><tt></tt>&nbsp;</html>

--------------4212772E468A86840C898065--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
