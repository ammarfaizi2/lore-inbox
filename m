Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVG1VaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVG1VaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVG1V2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:28:05 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:61558 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261471AbVG1V06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:26:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=tvkBvha1b0gKjClFxdnDexqN/RyM2RD+NiaaElmul/8SNygruzhXBbGFC04aniu9yv4OSsAYI0nCrpqu7e35mhdS2OO04nOZyZSYpawVphbcrf+ydDYBxwqGPR4P4RfhDmsNT1GfbhC5y33Pgo5+D3YQ3fDWZ6Ez6ZxNnHiS92s=
Message-ID: <42E96A42.7060405@gmail.com>
Date: Thu, 28 Jul 2005 23:29:06 +0000
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050726)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

here again I have two problems. With 2.6.13-rc3-mm3 I have problems 
using my SATA drives on Intel ICH6.
The kernel can't route there IRQs or can't discover them. the option 
irqpoll got them to work now.
The problem is new because 2.6.13-rc3[-mm1,mm2] work without any problems.

The SATA drives are Samsung HD160JJ SATAII. The mainboard I use is a 
ASUS P4GPL-X.

Second one is about Intel HD-Codec (snd-hda-intel) on modprobe when 
loading the module it gives me

---> snip
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f88713f4
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
last sysfs file:
Modules linked in: snd_hda_intel snd_hda_codec nvidia
CPU:    0
EIP:    0060:[<f88713f4>]    Tainted: P      VLI
EFLAGS: 00010293   (2.6.13-rc3-mm3pm)
eax: fffffffe   ebx: f3b33548   ecx: 00000000   edx: 00000000
esi: f3b33400   edi: 00000000   ebp: 00000006   esp: f0371ddc
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 7398, threadinfo=f0370000 task=f4183560)
Stack: 00000000 00000000 00000000 00000000 f3b33400 f3b33548 f0f1d000 
f8871933
       f3b33400 f0f1d000 f8871bbd f8875478 f88748f6 00000001 f886d77e 
00000f00
       00000005 00000000 f0f1d000 f54d04c0 00000000 f886d984 00000f00 
00000002
Call Trace:
 [<f8871933>]
 [<f8871bbd>]
 [<f886d77e>]
 [<f886d984>]
 [<f886d592>]
 [<c025b87e>]
 [<f8f5c871>]
 [<f8f5c100>]
 [<f8f5c220>]
 [<f8f5d533>]
 [<c026866a>]
 [<c02686be>]
 [<c02686f6>]
 [<c02bf763>]
 [<c02bf899>]
 [<c02bee1a>]
 [<c02bf8b6>]
 [<c02bf860>]
 [<c02bf30c>]
 [<c02bfc85>]
 [<c0268958>]
 [<c013b5c9>]
 [<c0102fcb>]
Code: 31 c0 53 83 ec 10 89 d3 89 e7 f3 ab 8b 12 31 ff 83 fa 00 7e 45 89 
f6 0f b7 44 7b 04 8d 48 ec 66 83 f9 03 77 13 8b 56 3c 83 e8 16 <66> 89 
04 7a 8b 13 c7 04 8c 01 00 00 00 47 39 fa 7f da 31 ff 83
--> snip

I also attached the kernel-config and the lspci -vv output.

Thanks again for the patience and the help.

Best regards
            Michael




