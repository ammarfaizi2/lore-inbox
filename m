Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbULKUh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbULKUh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbULKUhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:37:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21137 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261638AbULKUhR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:37:17 -0500
Message-ID: <41BB5A78.1040008@pobox.com>
Date: Sat, 11 Dec 2004 15:37:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: EC <wingman@waika9.com>
CC: "'Alan J. Wylie'" <alan@wylie.me.uk>, linux-kernel@vger.kernel.org,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
References: <20041211202423.6CF4B1734ED@postfix3-1.free.fr>
In-Reply-To: <20041211202423.6CF4B1734ED@postfix3-1.free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EC wrote:
>>-----Message d'origine-----
>>De : Jeff Garzik [mailto:jgarzik@pobox.com]
>>Envoyé : samedi 11 décembre 2004 19:52
>>À : Alan J. Wylie
>>Cc : linux-kernel@vger.kernel.org; EC; Marcelo Tosatti
>>Objet : Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
>>
>>Alan J. Wylie wrote:
>>
>>>Code;  c01ccd07 <ata_host_add+57/80>
>>>00000000 <_EIP>:
>>>Code;  c01ccd07 <ata_host_add+57/80>   <=====
>>>   0:   ff 50 50                  call   *0x50(%eax)   <=====
>>>Code;  c01ccd0a <ata_host_add+5a/80>
>>>   3:   89 da                     mov    %ebx,%edx
>>>Code;  c01ccd0c <ata_host_add+5c/80>
>>>   5:   85 c0                     test   %eax,%eax
>>>Code;  c01ccd0e <ata_host_add+5e/80>
>>>   7:   75 12                     jne    1b <_EIP+0x1b>
>>>Code;  c01ccd10 <ata_host_add+60/80>
>>>   9:   8b 5c 24 14               mov    0x14(%esp),%ebx
>>>Code;  c01ccd14 <ata_host_add+64/80>
>>>   d:   89 d0                     mov    %edx,%eax
>>>Code;  c01ccd16 <ata_host_add+66/80>
>>>   f:   8b 74 24 18               mov    0x18(%esp),%esi
>>>Code;  c01ccd1a <ata_host_add+6a/80>
>>>  13:   8b 00                     mov    (%eax),%eax
>>
>>If you are getting an oops there, it looks like your ata_piix driver is
>>mismatched from the libata core.  Did you compile them both at the same
>>time, from the same source kernel?
>>
>>The assembly code above is where function ata_host_add in libata-core.c
>>calls "ap->ops->port_start", which definitely exists in ata_piix.c.
>>
>>	Jeff
> 
> 
> After some more testing I made my system work again. 
> With 2.4.27 kernel + patch : SATA Only works fine in BIOS.
> With 2.4.28 kerenl, no patch : *Must* put enhanced mode (SATA Only makes
> oops).

Can you provide oops output decoded with ksymoops?

	Jeff



