Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUCRM0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUCRM0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:26:41 -0500
Received: from www02.ies.inet6.fr ([62.210.153.202]:10192 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262571AbUCRM0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:26:38 -0500
Message-ID: <4059957B.2010704@inet6.fr>
Date: Thu, 18 Mar 2004 13:26:35 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>
Cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SiS APIC, hacker looking for docs/help, was : Re: 2.6.4 under
 heavy ioload disables sis5513 DMA
References: <opr410iiid4evsfm@smtp.pacific.net.th> <40598849.1070409@inet6.fr> <opr41292b64evsfm@smtp.pacific.net.th>
In-Reply-To: <opr41292b64evsfm@smtp.pacific.net.th>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote the following on 03/18/2004 12:52 PM :

>
>>
>> Is reading the arch/i386/kernel/*pic* files (and probably others) enough
>> to start or is there somewhere else to look for information ?
>>
>
> Dunno how DMA timeout is related to interrupts or are you suggesting it
> is loosing dma-complete interrupts?
>

I don't know the details (yet I hope), but I'm quite sure that interrupt 
handling in XT-PIC mode leads to problems on several SiS configurations 
(when you reorganize PCI cards in a system and the behaviour changes or 
when you disable the VGA IRQ and some things start to work, the suspect 
becomes obvious). One user reported that putting 2 disks on one channel 
instead of one on each (so 1 IRQ used instead of 2) solve instability 
issues too... I ruled out IDE driver problems several times by 
repeatedly checking the code and the run-time register values against 
known-good values. My lack of knowledge on the interrupt handling 
details is what prevents me from being 100% sure that the problem lies 
here. This is why I'm willing to work on this subject.

> Same board runs same and higher loads with 2.4.2[345] flawlessly. Also
> 8 hours OK with 2.4.26-pre4 last night + 430 cycles of swsusp2.
>

Now I remember why your name ringed a bell ! Thanks for your testing 
work on swsusp, my amount of free time went up thanks to 2.4's swsusp.

Regards,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

