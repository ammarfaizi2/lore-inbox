Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266755AbTAIPYy>; Thu, 9 Jan 2003 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTAIPYy>; Thu, 9 Jan 2003 10:24:54 -0500
Received: from [213.171.53.133] ([213.171.53.133]:35335 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S266755AbTAIPYx>;
	Thu, 9 Jan 2003 10:24:53 -0500
Date: Thu, 9 Jan 2003 18:35:12 +0300
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <59522031471.20030109183512@wr.miee.ru>
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
Hello Adam and Other.
I have got some stupid questions:
1) As I've understood we need to free all reserved resources when
remove function called, am I right?
2) Who decide card is accessible at some time or not?
3) And the last, where is the place of ISA not PnP cards in the device
lists? As I think, they are fit with PnP bus, but their resources
static(not configurable) or it's just lays under ALSA, apears in
/proc/asound only and ALSA internals?
             Ruslan.

