Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRIRL1w>; Tue, 18 Sep 2001 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRIRL1m>; Tue, 18 Sep 2001 07:27:42 -0400
Received: from hal.grips.com ([62.144.214.40]:24469 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S267196AbRIRL1d>;
	Tue, 18 Sep 2001 07:27:33 -0400
Message-ID: <3BA72FBC.1030601@grips.com>
Date: Tue, 18 Sep 2001 13:27:56 +0200
From: jury gerold <geroldj@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010803
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <1292125035.20010914214303@port.imtp.ilyichevsk.odessa.ua> <E15i2Bp-00017m-00@the-village.bc.nu> <20010916035207.C7542@ppc.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Vandrovec wrote:

>>+static void __init pci_fixup_athlon_bug(struct pci_dev *d)
>>+{ 
>>+       u8 v; 
>>+       pci_read_config_byte(d, 0x55, &v);
>>+       if(v & 0x80) {
>>+               printk(KERN_NOTICE "Stomping on Athlon bug.\n");
>>+               v &= 0x7f; /* clear bit 55.7 */
>>+               pci_write_config_byte(d, 0x55, v);
>>+       }
>>+}
>>
>>Well, these are cosmetic changes anyway...
>>What is more important now:
>>1) Do we have people who still see Athlon bug with the patch?
>>
>
>Just by any chance - does anybody have KT133 (not KT133A)
>datasheet? I just noticed at home that my KT133 has reg 55 set
>to 0x89 and it happilly lives... So maybe some BIOS vendors
>used KT133 instead of KT133A BIOS image?
>
Same here ... with a board from gigabyte
I had to replace a 128MB PC100 RAM module (maybe related, maybe not)
but now it works.

Gerold Jury

