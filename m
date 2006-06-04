Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751414AbWFDKIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWFDKIw (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWFDKIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:08:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:149 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751414AbWFDKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:08:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gDoAS2y6ewNhPweQDp8hYZ9GNZJ1CChoKhXsK1Ndtw22WXOLmOFK3ELh40l2QlZ9JpFdJiG9kGVUOTsr3aMY7oaSv6L8Cx6ZNonkoxG2dJMFS9oDGy68Bbyo9xfvpKqO5oaHImwPDPQwmIgOnvJjjt90m24tkJeZuWAIFassoqI=
Message-ID: <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
Date: Sun, 4 Jun 2006 12:08:50 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060604024937.0fb57258.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com>
	 <20060604024937.0fb57258.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 04/06/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 4 Jun 2006 02:38:03 -0700
> "Barry K. Nathan" <barryn@pobox.com> wrote:
>
> > When I build ACPI processor support as a module, I get this:
> >
> >   MODPOST
> > WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> > .init.data: from .text between 'acpi_processor_power_init' (at offset
> > 0xfb0) and 'acpi_safe_halt'
>
> yup.  The code in there is actually correct (assuming
> acpi_processor_power_init()'s first invokation is at initcall-time).
>
> Maybe we'll do something to kill the warning, once we're down to the last
> few thousand of them ;)

I have got something similar
WARNING: drivers/usb/storage/usb-storage.o - Section mismatch:
reference to .exit.text: from .smp_locks after '' (at offset 0x3c)
WARNING: net/ipv4/netfilter/ip_conntrack.o - Section mismatch:
reference to .init.text: from .smp_locks after '' (at offset 0x8)
WARNING: net/ipv6/ipv6.o - Section mismatch: reference to .init.text:
from .smp_locks after '' (at offset 0x14c)
WARNING: net/ipv6/ipv6.o - Section mismatch: reference to .init.text:
from .smp_locks after '' (at offset 0x17c)

BTW. I still get this bug
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
