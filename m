Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWEOS1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWEOS1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbWEOS1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:27:50 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:7076 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S965130AbWEOS1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:27:48 -0400
Message-ID: <4468C7DF.7090603@ru.mvista.com>
Date: Mon, 15 May 2006 22:26:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Assorted bugs in the PIIX drivers
References: <1132929808.3298.18.camel@localhost.localdomain>	 <44689A54.4020307@ru.mvista.com> <1147708783.26686.69.camel@localhost.localdomain>
In-Reply-To: <1147708783.26686.69.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

> On Llu, 2006-05-15 at 19:12 +0400, Sergei Shtylyov wrote:

>>    For PIO2+ actually, according to Intel's PRM (29860004.pdf), and it's said
>> to have no effect in the lower modes. This is actually not very correct since
>> when one issues Set Transfer Mode ATA command with the value (8 + PIOn), this
>> means select PIO _flow control_ mode n, so -IORDY is assumed to be in use.

> PIO2 depends on the drive (there is a drive parameter telling you the
> highest timing clock you can do with/without IORDY

    Yes. But when you're setting any _explicit_ PIO mode with Set Features
command, you're tell the drive to use -IORDY at the same time.

>>> I'm also not clear if the "no MWDMA0" list has been updated correctly
>>> for the newer chipsets.

>>    What is/was the point for keeping MW DMA 0 support anyway? On PIIX, it's
>> greatly slowed down (600 vs 480 ns cycle) and was never "offically" supported
>> by Intel.

> Some old old drives only do MWDMA0. The Intel docs I have here don't
> describe it in any way as "unsupported",

    They just don't describe it, period. :-)

> merely broken on some ICH variants.

    ICH errata #55: "Note that DMA Mode-0 is an unsupported mode of the ICH."

> Alan

MBR, Sergei


