Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269597AbRHHWaw>; Wed, 8 Aug 2001 18:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRHHWad>; Wed, 8 Aug 2001 18:30:33 -0400
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:5257 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S269597AbRHHWa1>; Wed, 8 Aug 2001 18:30:27 -0400
Message-ID: <3B706C11.7010100@kjellander.com>
Date: Wed, 08 Aug 2001 00:30:41 +0200
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 386 boot problems with 2.4.7 and 2.4.7-ac9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old 386 which ran 2.4.3 just fine. Last night i tried
to upgrade it but it didnt work at all.

I compiled a stock 2.4.7, and since I had seen some postings on
that egcs-2.91.66 didn't compile 2.4.7 I switched to gcc-2.96-85.
The only thing I added to the kernel was ISAPNP support.

The 2.4.7 kernel seems to boot fine, no error messages or nothing,
but it won't start init. The last line is:

   Freeing unused kernel memory: 52K freed

And then it just stops. The kernel is still resonsive but init won't
start. Shift-PageUp still works. SysRQ shows that the EIP almost
always is on the same spot in schedule. I tried init=/bin/sh but
the boot stops at the same place every time.

Then I tried 2.4.7-ac9, same configuration, but that kernel panics.

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Unable to handle kernel paging request at virtual address c0800000
   printing eip:
c01eb801
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01eb801>]
EFLAGS: 00010283
eax: ffffff00   ebx: c0800000   ecx: 00000008   edx: 00000001
esi: c0800000   edi: c01be12e   ebp: 00800000   esp: c022bfb8
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c022b000)
Stack: 001f4df8 00000000 00000000 c01f4dfc c01e7fd8 c0105000 0008e000 c01e87d2
        00010f00 c0105041 00010f00 c01e7fd8 c0105000 0008e000 c0105472 00000000
        c0105038 00098700
Call Trace: [<c0105000>] [<c0105041>] [<c0105000>] [<c0105472>] [<c0105038>]

Code: f3 a6 0f 97 c2 0f 92 c0 38 c2 75 45 c6 44 24 03 00 31 f6 8a
  <0>Kernel panic: Attemted to kill init!

Relevant parts from System.map are:
c0105000 t rest_init
c0105000 T _stext
c0105000 T stext

c0105038 t init

c010544c T kernel_thread

c01eb7cc t sbf_init

The system is a 386DX with an Award 3.15c BIOS. The distribution
is smalllinux i think, but I've modified it a lot.

Please CC replies to me.

/Carl-Johan Kjellander

-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

