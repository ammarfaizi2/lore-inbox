Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269598AbRHHWsG>; Wed, 8 Aug 2001 18:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269599AbRHHWr4>; Wed, 8 Aug 2001 18:47:56 -0400
Received: from razor.hemmet.chalmers.se ([193.11.251.99]:8841 "EHLO
	razor.hemmet.chalmers.se") by vger.kernel.org with ESMTP
	id <S269598AbRHHWrn>; Wed, 8 Aug 2001 18:47:43 -0400
Message-ID: <3B70701D.1000701@kjellander.com>
Date: Wed, 08 Aug 2001 00:47:57 +0200
From: Carl-Johan Kjellander <carljohan@kjellander.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 386 boot problems with 2.4.7 and 2.4.7-ac9
In-Reply-To: <3B706C11.7010100@kjellander.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured out how to work ksymoops as well.

This is the panic from 2.4.7-ac9 compiled with gcc-2.96-85 (Red Hat).

ksymoops 2.4.0 on i686 2.4.7.  Options used
      -v vmlinux (specified)
      -K (specified)
      -L (specified)
      -o /lib/modules/2.4.7-ac9/ (specified)
      -m System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address c0800000
c01eb801
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01eb801>]
Using defaults from ksymoops -t elf32-i386 -a i386
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

 >>EIP; c01eb801 <sbf_init+35/184>   <=====
Trace; c0105000 <_stext+0/0>
Trace; c0105041 <init+9/13c>
Trace; c0105000 <_stext+0/0>
Trace; c0105472 <kernel_thread+26/30>
Trace; c0105038 <init+0/13c>
Code;  c01eb801 <sbf_init+35/184>
00000000 <_EIP>:
Code;  c01eb801 <sbf_init+35/184>   <=====
    0:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)   <=====
Code;  c01eb803 <sbf_init+37/184>
    2:   0f 97 c2                  seta   %dl
Code;  c01eb806 <sbf_init+3a/184>
    5:   0f 92 c0                  setb   %al
Code;  c01eb809 <sbf_init+3d/184>
    8:   38 c2                     cmp    %al,%dl
Code;  c01eb80b <sbf_init+3f/184>
    a:   75 45                     jne    51 <_EIP+0x51> c01eb852 <sbf_init+86/184>
Code;  c01eb80d <sbf_init+41/184>
    c:   c6 44 24 03 00            movb   $0x0,0x3(%esp,1)
Code;  c01eb812 <sbf_init+46/184>
   11:   31 f6                     xor    %esi,%esi
Code;  c01eb814 <sbf_init+48/184>
   13:   8a 00                     mov    (%eax),%al

  <0>Kernel panic: Attemted to kill init!

Again, please CC replies to me.

/Carl-Johan Kjellander
-- 
begin 644 carljohan_at_kjellander_dot_com.gif
Y1TE&.#=A(0`F`(```````/___RP`````(0`F```"@XR/!\N<#U.;+MI`<[U(>\!UGQ9BGT%>'D2I
Y*=NX,2@OUF2&<827ILW;^822C>\7!!Z1,!K'B5(6H<SH-"E*TJ3%*/>QI6:7"A>Y?):D2^*U@NCV
R<MOQ=]V(B6>LZYD-_T1U<@3W]A4(^$-W4]A#V")W6#.R"$;IR'@).46BN7$9>5D``#L`

