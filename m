Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSIIRWp>; Mon, 9 Sep 2002 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317589AbSIIRWo>; Mon, 9 Sep 2002 13:22:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:36738 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317590AbSIIRWn>; Mon, 9 Sep 2002 13:22:43 -0400
Date: Mon, 9 Sep 2002 13:29:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Imran Badr <imran.badr@cavium.com>
cc: "'David S. Miller'" <davem@redhat.com>, phillips@arcor.de,
       linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..
In-Reply-To: <019d01c25823$8714c460$9e10a8c0@IMRANPC>
Message-ID: <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Imran Badr wrote:

> 
> So, what you gurus suggest me to do? How can I get physical address of a
> user buffer (which was originally mmap'ed() from a kmalloc() allocation) and
> which would also be protable across multiple platforms?
> 
> Thanks.
> Imran.

I think there is a virt_to_bus() macro and its inverse. The 'bus' address
is what you need to give to bus-masters that do DMA. This is different
than virt_to_phys(), which happens to be the same on some platforms
but would not be the same on those, like PPC (Motorola), which have
separate address spaces for different things (RAM, I/O, etc).

Isn't this what you want?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

