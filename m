Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRCEQWX>; Mon, 5 Mar 2001 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRCEQWN>; Mon, 5 Mar 2001 11:22:13 -0500
Received: from t2.redhat.com ([199.183.24.243]:60917 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129397AbRCEQVz>; Mon, 5 Mar 2001 11:21:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AA0CF0D.CB9D544C@mandrakesoft.com> 
In-Reply-To: <3AA0CF0D.CB9D544C@mandrakesoft.com>  <15008.17278.154154.210086@pizda.ninka.net> <19350125195650.22439@mailhost.mipsys.com> 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.kernel.org
Subject: Re: The IO problem on multiple PCI busses 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Mar 2001 16:20:58 +0000
Message-ID: <11639.983809258@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgarzik@mandrakesoft.com said:
>  You can map and unmap for each call :)  Ugly and slow, but hey, it's
> I/O...

	outb(bus *bus, u8 val, u16 addr);

#ifdef ONE_TRUE_BUS_SPACE
#define outb(bus, val, addr) __outb(val, addr)
#else
#define outb(bus, val, addr) bus->out8(bus, val, addr)
#endif




--
dwmw2


