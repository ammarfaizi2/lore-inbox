Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269995AbUJNJQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269995AbUJNJQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbUJNJQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 05:16:23 -0400
Received: from mail.donpac.ru ([80.254.111.2]:15262 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S269995AbUJNJQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 05:16:08 -0400
Message-ID: <21579.80.80.111.240.1097745358.squirrel@80.80.111.240>
In-Reply-To: <416CBC9C.8010905@osdl.org>
References: <b2fa632f04101204385c09459f@mail.gmail.com>	
    <416CB8FC.9020503@osdl.org> <b2fa632f041012222745006916@mail.gmail.com>
    <416CBC9C.8010905@osdl.org>
Date: Thu, 14 Oct 2004 13:15:58 +0400 (MSD)
Subject: Re: Build problems with APM/Subarch type
From: "Andrey Panin" <pazke@donpac.ru>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Raj" <inguva@gmail.com>, "linux-kernel" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Raj wrote:
>>>Using an editor or make *config?  which *config?
>>>
>>
>> xconfig
>>
>>
>>>>The build failed with an error 'Undefined reference to
>>>> machine_real_restart'
>>>
>>>Yep, I see that also.
>>>
>>>
>>>>It seems that , unless Subarch is PC-Compatible ( CONFIG_PC ) ,
>>>>CONFIG_X86_BIOS_REBOOT will not be set and thusly, reboot.c would not
>>>> be
>>>>compiled.
>>>>
>>>>( yeah, i know messing around with configs is suicidal, but.... )
>>>>
>>>>Can this be fixed ?? At the very least, hide APM options #if
>>>> !(CONFIG_PC) ??
>>>
>>>Do you/we/maintainer know that APM is not applicable to all of the
>>>other PC sub-arches?
>>>
>>>I agree that it should be fixed, one way or another.
>>
>>
>> i am not aware much about the apm dependencies. maintainers might answer
>> this more correctly.
>
> True.  I should have copied Andrey on it earlier.
>
> Andrey, any thoughts about how to keep VISWS from building APM
> support?  use Kconfig?  or does VISWS support APM?

IMHO Kconfig is the best choise. VISWS has no PC compatible BIOS at all,
it uses ARC compilant firmware for startup and configuration. Even though
this firmware does limited BIOS emulation for running ROMs on PCI cards, i
dont think it has working APM BIOS implementation.


