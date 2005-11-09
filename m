Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVKINaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVKINaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKINaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:30:08 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:20173 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750736AbVKINaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:30:06 -0500
Message-ID: <4371FA47.1070806@ru.mvista.com>
Date: Wed, 09 Nov 2005 16:31:51 +0300
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Organization: MostaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: libata PATA patches
References: <1131460386.25192.45.camel@localhost.localdomain>
In-Reply-To: <1131460386.25192.45.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

> I've put a new patch versus 2.6.14-mm1 on 
> http://zeniv.linux.org.uk/~alan/IDE

    I found somewhat strange that you check for 0xABCDExxx signature in 32-bit 
PCI config. reg. 0x78 while HighPoint's own drivers read BM reg. 0x90 (i.e. 
PCI config. 0x70) for that. PCI reg. 0x7A is DPLL precision adjust reg. and 
0x7B is the input clock select and IRQ reg., so it'd be quite strange if the 
BIOS used them for any kind of signature...

WBR, Sergei
