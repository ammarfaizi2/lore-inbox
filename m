Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264991AbSJRG6K>; Fri, 18 Oct 2002 02:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265013AbSJRG6K>; Fri, 18 Oct 2002 02:58:10 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:59403 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S264991AbSJRG6K>;
	Fri, 18 Oct 2002 02:58:10 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A307@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Andrey Panin '" <pazke@orbita1.ru>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'Russell King '" <rmk@arm.linux.org.uk>
Subject: RE: [PATCH][RFC] add support for PC-9800 architecture (20/26) ser
	ial #1
Date: Fri, 18 Oct 2002 16:04:02 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> Did you see the next patch (21/26 serial #2) ? It looks even more
> interesting.
> As I understand serial98.c driver should support older i8251 UART.
> However it does it by perverting 8250.c and EMULATING i8250 on top of
> i8251,
> see ugly code in serial_in() and serial_out() functions.
Yes. serial98.c is based on 8250.c. And we add codes for emulating.
Old PC-9800 has 8251 USART. Newer PC-9801 has both 16550A and 8251 like
custom chip. Its custom chip is enhanced for support up to 115.2kbps and
 has FIFO. 
On kernel 2.1.x to 2.4.x, based on serial.c version are working well.
But It's ugly code, I think too. :)

Regards
Osamu Tomita
