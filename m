Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbSLKQcn>; Wed, 11 Dec 2002 11:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSLKQcn>; Wed, 11 Dec 2002 11:32:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:2043 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267212AbSLKQcl>;
	Wed, 11 Dec 2002 11:32:41 -0500
Message-ID: <B9ECACBD6885D5119ADC00508B68C1EA0D19B993@orsmsx107.jf.intel.com>
From: "Moore, Robert" <robert.moore@intel.com>
To: "'Andrew McGregor'" <andrew@indranet.co.nz>, Pavel Machek <pavel@suse.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Ducrot Bruno <ducrot@poupinou.org>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: RE: [ACPI] Dell i8k was: Re: [2.5.50, ACPI] link error
Date: Wed, 11 Dec 2002 08:40:05 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is related to this message:

    ACPI-0189: *** Warning: Buffer created with zero length in AML

I have a patch for the oops caused by this, but there may be an additional
underlying problem where the AML is causing a zero length buffer to be
created.

Bob


-----Original Message-----
From: Andrew McGregor [mailto:andrew@indranet.co.nz] 
Sent: Tuesday, December 10, 2002 7:45 PM
To: Pavel Machek; Alan Cox
Cc: Grover, Andrew; 'Ducrot Bruno'; Ducrot Bruno; Patrick Mochel; Linux
Kernel Mailing List; ACPI mailing list
Subject: Re: [ACPI] Dell i8k was: Re: [2.5.50, ACPI] link error

Hmm, when I boot 2.5.51 w/ACPI on it with a battery installed, it panics. 
By booting without and then inserting the battery, I got the attached oops. 
See also the messages in the dmesg output.

Andrew

--On Wednesday, December 11, 2002 09:50:48 +1300 Andrew McGregor 
<andrew@indranet.co.nz> wrote:

> I strongly suspect that s4bios will work on this machine, but swsusp
> won't. Why?  It's a Dell Inspiron 8000 with an NVidia Geforce2go, and
> until NVidia put pm support in their driver, it's game over for Linux.
> Except that the BIOS knows how to suspend it, so some kernel/driver
> combinations work with APM.  I suspect any Geforce2go Dell is the same.
>
> Andrew
>
> --On Tuesday, December 10, 2002 21:40:31 +0100 Pavel Machek
> <pavel@suse.cz> wrote:
>
>> Hi!
>>
>>> > I concur with your pros and cons. This makes me think that if S4BIOS
>>> > support ever gets added, it should get added to 2.4 only.
>>
>> And S4BIOS will never get added to 2.4 since it needs driver model
>> :-(.
>>
>>> That assumes no box exists where S4bios works an S4 doesnt (eg due to
>>> bad tables or "knowing" what other-os does)
>>
>> We have full control over S4 (== swsusp), so we can fix that in most
>> cases.
>>
>> S4BIOS is still little friendlier to the user -- no need to set up
>> swap partition and command line parameter, can't go wrong if you boot
>> without resume=, etc.
>> 								Pavel
>>
>> --
>> Casualities in World Trade Center: ~3k dead inside the building,
>> cryptography in U.S.A. and free speech in Czech Republic.
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

