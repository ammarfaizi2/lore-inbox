Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267544AbTBRB1k>; Mon, 17 Feb 2003 20:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267548AbTBRB1k>; Mon, 17 Feb 2003 20:27:40 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:58632 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S267544AbTBRB1j>;
	Mon, 17 Feb 2003 20:27:39 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A338@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: =?iso-2022-jp?B?J1lPU0hJRlVKSSBIaWRlYWtpIC8gGyRCNUhGIzFRTEAbKEogJw==?= 
	<yoshfuji@wide.ad.jp>
Cc: "'jgarzik@pobox.com '" <jgarzik@pobox.com>,
       "'bgerst@didntduck.org '" <bgerst@didntduck.org>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'alan@lxorguk.ukuu.org.uk '" <alan@lxorguk.ukuu.org.uk>,
       "'hch@infradead.org '" <hch@infradead.org>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC
Date: Tue, 18 Feb 2003 10:37:36 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Thanks for the comment.

-----Original Message-----
From: YOSHIFUJI Hideaki / 吉藤英明
To: bgerst@didntduck.org
Cc: jgarzik@pobox.com; tomita@cinet.co.jp; linux-kernel@vger.kernel.org;
alan@lxorguk.ukuu.org.uk; hch@infradead.org
Sent: 2003/02/18 4:02
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (16/26) NIC

In article <3E5124AC.80505@didntduck.org> (at Mon, 17 Feb 2003 13:06:36
-0500), Brian Gerst <bgerst@didntduck.org> says:

>> >  > -#ifdef __ISAPNP__   
>> >  > +#if defined(__ISAPNP__) && !defined(CONFIG_X86_PC9800)
> :
>> > Perhaps a dumb question, but I wonder if the above ifdef can be 
>> > simplified by turning off ISAPNP on PC9800?
>> 
>> As long as the machine has ISA expansion slots, ISAPNP is possible.
It 
>> is a property of the card, not the system.
> 
> Some C-bus (this is the name of the bus of the PC-9800 expansion slots) 
> cards seems PnP-capable while PC-9800 series have no ISA slots as I
> remember.  
> I don't know if Linux ISAPNP suport work well with them.
C-Bus PNP feature is compatible with ISA PNP except for control port
address.
By changing them from 0x259/0x279 to 0xa59/0xa79, PNP works fine.

Thanks,
Osamu Tomita
