Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267805AbTAMKMF>; Mon, 13 Jan 2003 05:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbTAMKMF>; Mon, 13 Jan 2003 05:12:05 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:18154 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S267805AbTAMKME>; Mon, 13 Jan 2003 05:12:04 -0500
Message-ID: <01fe01c2baed$5c123db0$6900a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>,
       "Kai Germaschewski" <kai@tp1.ruhr-uni-bochum.de>
References: <20030112220741.GA15849@mars.ravnborg.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Date: Mon, 13 Jan 2003 11:19:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Recently we have seen seveal changes to arch/*/vmlinux-lds.S,
> mainly introduced by the module support but also other changes.
>
> This is first version, where I have converted i386, s390 and sparc64.
> The latter two is not tested, only to make sure it can be used by more
> than one platform.
>

...

> + TEXT_SECTION_CMD(0xC0000000 + 0x100000,, 0x9090, )


Nice job indeed.

Could you change in arch/i386/vmlinux-lds.S the 0xC0000000 by PAGE_OFFSET
(defined in include/asm-i386/page.h)

TEXT_SECTION_CMD(PAGE_OFFSET + 0x100000,, 0x9090, )

This way, one could change PAGE_OFFSET if he needs too, without having to
change vmlinux-lds.S accordingly

Thanks

