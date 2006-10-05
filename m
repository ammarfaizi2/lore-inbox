Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWJEI5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWJEI5G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWJEI5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:57:06 -0400
Received: from smtpout.mac.com ([17.250.248.171]:60891 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751250AbWJEI5E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:57:04 -0400
In-Reply-To: <200610051116.12726.ismail@pardus.org.tr>
References: <200609150901.33644.ismail@pardus.org.tr> <200610011034.57158.ismail@pardus.org.tr> <20061001091411.GA9647@uranus.ravnborg.org> <200610051116.12726.ismail@pardus.org.tr>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <6EF4E095-924C-40C8-B591-40B09E15ABEC@mac.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, mchehab@infradead.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: __STRICT_ANSI__ checks in headers
Date: Thu, 5 Oct 2006 04:56:39 -0400
To: Ismail Donmez <ismail@pardus.org.tr>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm away from my regular work systems at the moment, but I have a  
couple ideas:

On Oct 05, 2006, at 04:16:11, Ismail Donmez wrote:
> 01 Eki 2006 Paz 12:14 tarihinde, Sam Ravnborg şunları yazmıştı:
>> On Sun, Oct 01, 2006 at 10:34:56AM +0300, Ismail Donmez wrote:
>>> On Sunday 01 October 2006 08:20, Kyle Moffett wrote:
> [...]
>>>> Just thinking about it we probably also need to educate sparse  
>>>> about
>>>> __extension__ too.  Perhaps somebody could also add an sparse  
>>>> flag to
>>>> make it warn about nonportable constructs in exported header files.
>>>>
>>>> I'd submit a patch but my knowledge of kernel makefiles and  
>>>> depmod is
>>>> somewhere between zero and none, exclusive.
>>>
>>> Thanks, I will have a look at it.
>>
>> I assume you will same errors from the in-kernel modpost.
>> If you do not do so then there is some inconsistency between depmod
>> and modpost that ougth to be fixed.
>
> The problem shows itself in the modpost, somehow __extension__  
> clause seems to
> foobar module CRC. I am not yet successfull on making modpost ignore
> __extension__ .

Since GCC doesn't actually _do_ anything with __extension__ in the  
object output files, it must be a C-file-based parser problem, so you  
should probably be able to build one of the problematic modules and  
diff the resultant .cmd files, the .mod files, and the .mod.c files.   
Sorry I can't be of more help.

Cheers,
Kyle Moffett