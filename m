Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268175AbTBNELr>; Thu, 13 Feb 2003 23:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268178AbTBNELr>; Thu, 13 Feb 2003 23:11:47 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:37644 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S268175AbTBNELq>;
	Thu, 13 Feb 2003 23:11:46 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A333@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "'Jeff Garzik '" <jgarzik@pobox.com>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC
Date: Fri, 14 Feb 2003 13:21:36 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita
Cc: Linux Kernel Mailing List; Alan Cox; Jeff Garzik
Sent: 2003/02/13 0:38
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (13/34) NIC

>> +#ifdef CONFIG_X86_PC9800
>> +#undef __ISAPNP__
>> +#endif
> 
> Don't do s.th. like that!
#if deined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
Each places are better?
PC98 has no EL3 PNP card, but has other PNP cards.

>> +#ifndef CONFIG_X86_PC9800
   ....
>> +#else
>> +	id_port = 0x71d0;
>> +#endif
> 
> use ifdef, not ifndef here
I see.

Regards,
Osamu Tomita
