Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKQQOd>; Fri, 17 Nov 2000 11:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129148AbQKQQOY>; Fri, 17 Nov 2000 11:14:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:1041 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129132AbQKQQOR>; Fri, 17 Nov 2000 11:14:17 -0500
Date: Fri, 17 Nov 2000 13:43:05 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducable oops in 2.2.17 and 2.2.18pre21
In-Reply-To: <20001117144938.F12733@jaquet.dk>
Message-ID: <Pine.LNX.4.21.0011171339490.4089-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 17 Nov 2000, Rasmus Andersen wrote:

> Hi.
> 
> I get an oops reproducably with 2.2.17 and 2.2.18pre21 on a stock RH 6.2
> system. I cannot trigger it with the RH supplied kernel (2.2.14-5.0).
> I also got it with 2.2.17pre10 which prompted me to upgrade the kernel.
> I initially suspected bad RAM but have exchanged the RAM with memtest86'ed
> RAM for no improvement.

<snip>

> Code;  c0121b43 <__get_free_pages+1eb/2b8>
> 00000000 <_EIP>:
> Code;  c0121b43 <__get_free_pages+1eb/2b8>   <=====
>    0:   89 70 04                  mov    %esi,0x4(%eax)   <=====
> Code;  c0121b46 <__get_free_pages+1ee/2b8>
>    3:   89 e8                     mov    %ebp,%eax
> Code;  c0121b48 <__get_free_pages+1f0/2b8>
>    5:   2b 05 ec da 1d c0         sub    0xc01ddaec,%eax
> Code;  c0121b4e <__get_free_pages+1f6/2b8>
>    b:   8d 04 40                  lea    (%eax,%eax,2),%eax
> Code;  c0121b51 <__get_free_pages+1f9/2b8>
>    e:   89 c2                     mov    %eax,%edx
> Code;  c0121b53 <__get_free_pages+1fb/2b8>
>   10:   c1 e2 04                  shl    $0x4,%edx
> Code;  c0121b56 <__get_free_pages+1fe/2b8>
>   13:   01 00                     add    %eax,(%eax)

Which compiler are you using? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
