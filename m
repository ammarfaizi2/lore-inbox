Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbULKUYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbULKUYq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULKUYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:24:46 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:17596 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262005AbULKUY1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:24:27 -0500
From: "EC" <wingman@waika9.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "'Alan J. Wylie'" <alan@wylie.me.uk>
Cc: <linux-kernel@vger.kernel.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Subject: RE: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
Date: Sat, 11 Dec 2004 21:24:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <41BB41DC.6020808@pobox.com>
Thread-Index: AcTfsq6eP/E2KFFhThi+d/BvB+DzggACcGaA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Message-Id: <20041211202423.6CF4B1734ED@postfix3-1.free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Message d'origine-----
>De : Jeff Garzik [mailto:jgarzik@pobox.com]
>Envoyé : samedi 11 décembre 2004 19:52
>À : Alan J. Wylie
>Cc : linux-kernel@vger.kernel.org; EC; Marcelo Tosatti
>Objet : Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
>
>Alan J. Wylie wrote:
>> Code;  c01ccd07 <ata_host_add+57/80>
>> 00000000 <_EIP>:
>> Code;  c01ccd07 <ata_host_add+57/80>   <=====
>>    0:   ff 50 50                  call   *0x50(%eax)   <=====
>> Code;  c01ccd0a <ata_host_add+5a/80>
>>    3:   89 da                     mov    %ebx,%edx
>> Code;  c01ccd0c <ata_host_add+5c/80>
>>    5:   85 c0                     test   %eax,%eax
>> Code;  c01ccd0e <ata_host_add+5e/80>
>>    7:   75 12                     jne    1b <_EIP+0x1b>
>> Code;  c01ccd10 <ata_host_add+60/80>
>>    9:   8b 5c 24 14               mov    0x14(%esp),%ebx
>> Code;  c01ccd14 <ata_host_add+64/80>
>>    d:   89 d0                     mov    %edx,%eax
>> Code;  c01ccd16 <ata_host_add+66/80>
>>    f:   8b 74 24 18               mov    0x18(%esp),%esi
>> Code;  c01ccd1a <ata_host_add+6a/80>
>>   13:   8b 00                     mov    (%eax),%eax
>
>If you are getting an oops there, it looks like your ata_piix driver is
>mismatched from the libata core.  Did you compile them both at the same
>time, from the same source kernel?
>
>The assembly code above is where function ata_host_add in libata-core.c
>calls "ap->ops->port_start", which definitely exists in ata_piix.c.
>
>	Jeff

After some more testing I made my system work again. 
With 2.4.27 kernel + patch : SATA Only works fine in BIOS.
With 2.4.28 kerenl, no patch : *Must* put enhanced mode (SATA Only makes
oops).

:)

EC.


