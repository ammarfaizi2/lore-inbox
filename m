Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277717AbRJICql>; Mon, 8 Oct 2001 22:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277710AbRJICqb>; Mon, 8 Oct 2001 22:46:31 -0400
Received: from [207.21.185.24] ([207.21.185.24]:65298 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S277705AbRJICqS>; Mon, 8 Oct 2001 22:46:18 -0400
Message-ID: <3BC26440.66EED412@lnxw.com>
Date: Mon, 08 Oct 2001 19:43:12 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
In-Reply-To: <3BC23441.1EF944A2@lnxw.com>
		<20011008.162935.21930065.davem@redhat.com>
		<3BC2467B.C8093B19@lnxw.com> <20011008.183718.01458450.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    >         bootmap_size = init_bootmem(0, (32 * 1024 * 1024));
>    >         free_bootmem((4 * 1024 * 1024),
>    >                      ((16 - 4) * 1024 * 1024));
> 
>    This is suppose to tell the kernel about the gap?
> 
> Precisely.  How else did you expect to let the kernel know?

Unfortunately this didn't work. I also tried to declare
16MB hole starting from offset 0 so the kernel is supposed
to boot from phys addr 0x01000000. It crashed when tried to
execute kernel_thread()
Do you think there is a mechanism to tell the kernel that first
16MB is a non DMA-able area?


	Petko
