Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTAIMda>; Thu, 9 Jan 2003 07:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTAIMda>; Thu, 9 Jan 2003 07:33:30 -0500
Received: from [213.171.53.133] ([213.171.53.133]:22541 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266233AbTAIMd2>;
	Thu, 9 Jan 2003 07:33:28 -0500
Date: Thu, 9 Jan 2003 15:43:51 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <49511761313.20030109154351@wr.miee.ru>
To: Adam Belay <ambx1@neo.rr.com>
CC: Zwane Mwaikambo <zwane@holomorphy.com>, Jaroslav Kysela <perex@perex.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5.54][PATCH] SB16 convertation to new PnP layer.
In-Reply-To: <20030108160939.GA17701@neo.rr.com>
References: <Pine.BSF.4.05.10301081959130.88742-100000@wildrose.miee.ru>
 <20030108160939.GA17701@neo.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AB> On Wed, Jan 08, 2003 at 08:20:13PM +0300, Ruslan U. Zakirov wrote:
>> Hello Adam and All.
>> Here is patch to sb16.c that makes it posible to compile and use this
>> driver under 2.5.54-vanilla.
>> It working for me as module and built in kernel, but it's need testing.
>>                             Ruslan. 

AB> Hi Ruslan,

AB> I haven't had a chance to test this yet but everything does look ok.  I
AB> think it will be ready once the below function is completed.  Jaroslav,
AB> any comments?  Also, if anyone has a built in wavetable, as previously
AB> mentioned by Zwane, I'd like to hear how this patch works for you.  This
AB> patch makes full use of pnp card services, which is prefered for cards
AB> that have several closely related devices, and it would be great to 
AB> further test those code paths.

AB> Thanks,
AB> Adam

>>
>> -#endif /* __ISAPNP__ */
>> +static void snd_sb16_isapnp_remove(struct pnp_card * card)
>> +{
>> +     /*FIX ME*/
>> +}
>> +
>>
AB> -
AB> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
AB> the body of a message to majordomo@vger.kernel.org
AB> More majordomo info at  http://vger.kernel.org/majordomo-info.html
AB> Please read the FAQ at  http://www.tux.org/lkml/
Hi All!
I've got only one problem with this driver.
It's appear when I remove module and try to probe it again, then
modprobe oopsing. Problem lays somewhere under PCI_HACK.
It have been repaired in 2.5.55 with this patch
Dave Jones <davej@codemonkey.org.uk>:
  o Fix up dma_alloc_coherent with 64bit DMA masks on i386
OK. I've just tested it. It's been fixed.
         Ruslan.

