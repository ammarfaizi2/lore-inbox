Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSLFSZS>; Fri, 6 Dec 2002 13:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSLFSZR>; Fri, 6 Dec 2002 13:25:17 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:34679 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S265169AbSLFSZR>; Fri, 6 Dec 2002 13:25:17 -0500
Message-ID: <3DF1FF71.6040300@blue-labs.org>
Date: Sat, 07 Dec 2002 09:02:25 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Pavel Machek <pavel@suse.cz>, Eric Altendorf <EricAltendorf@orst.edu>,
       Jochen Hein <jochen@jochen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       andrew.grover@intel.com
Subject: Re: [2.5.50, ACPI] link error
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org> <200212031247.07284.EricAltendorf@orst.edu> <20021205173145.GB731@elf.ucw.cz> <3DEFD17D.4090809@pobox.com> <20021205222431.GB7396@atrey.karlin.mff.cuni.cz> <3DEFD2CE.4070805@pobox.com>
In-Reply-To: <3DEFD2CE.4070805@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The odd part is that I must enable ACPI and SW SUSPEND to get things to 
compile but then I have to turn around and put acpi=off in my boot 
config because it still hangs my laptop (as well as IDE w/ DMA).

So I find it a bit ironic :)

-d

Jeff Garzik wrote:

> Pavel Machek wrote:
>
>> Yes, there are about 10 patches to fix it floating around... I just
>> hope linus takes one of them. (Fix is make ACPI_SLEEP depend on
>> swsusp).
>
>
>
> I haven't seen the patch, but does it make sense for hardware suspend 
> to depend on software suspend?
>
> IMO there should be a common core (CONFIG_SUSPEND?), not force ACPI to 
> depend on swsusp.  That way you get the _least_ common denominator, 
> not the union of two sets.
>
>     Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


