Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277667AbRJIAh6>; Mon, 8 Oct 2001 20:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277668AbRJIAhs>; Mon, 8 Oct 2001 20:37:48 -0400
Received: from [207.21.185.24] ([207.21.185.24]:8976 "EHLO smtp.lynuxworks.com")
	by vger.kernel.org with ESMTP id <S277667AbRJIAhi>;
	Mon, 8 Oct 2001 20:37:38 -0400
Message-ID: <3BC24619.E4A58629@lnxw.com>
Date: Mon, 08 Oct 2001 17:34:33 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: discontig physical memory
In-Reply-To: <3BC22EA6.696604E7@lnxw.com>
		<20011008.160528.85686937.davem@redhat.com>
		<3BC23441.1EF944A2@lnxw.com> <20011008.162935.21930065.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> You need to setup bootmem correctly, earlier on, such that
> you do not tell the kernel that there are any pages in this
> 4 - 16MB region.
> 
> Do something like this instead of whatever your bootmem
> calls are doing now:
> 
>         bootmap_size = init_bootmem(0, (32 * 1024 * 1024));
>         free_bootmem((4 * 1024 * 1024),
>                      ((16 - 4) * 1024 * 1024));
