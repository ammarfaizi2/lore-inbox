Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271075AbUJUW4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271075AbUJUW4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271052AbUJUWvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:51:50 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:54918 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S271051AbUJUWvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:51:04 -0400
Message-ID: <41783CDF.80007@rtr.ca>
Date: Thu, 21 Oct 2004 18:49:03 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
 CF adaptor
References: <41780393.3000606@rtr.ca>	 <58cb370e041021121317083a3a@mail.gmail.com> <1098394354.17096.174.camel@localhost.localdomain>
In-Reply-To: <1098394354.17096.174.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
 >
>>From review I think I've got them all fixed in 2.6, but yes 2.4 is a
> bit of a lost cause there (although ide-cs works generally so its no big
> barrier)

That was my feeling on it too.  Any races that remain in 2.4 are really
a non-issue for removable PC-CARD devices -- the user is popping them
out of the socket regardless, so it cannot really be any more harmful
to tell the kernel they don't physically exist afterwards.  :)

ide-cs does seem to be reliable, as is delkin_cb.  It's not like these
devices are proliferating -- USB flash readers are pretty much taking
over on newer USB2 machines, and this unit is likely the last of the breed.

The adapter I have here is a "Delkin Devices Cardbus 32 eFilm PRO"
compact flash adapter.  They are also sold in Japan under the ASKA name,
and the chipset is by Workbit.  The only North American sources I know
of for this card are B&H Photo in New York (they have a website)
and Downtown Camera in Toronto.

These cards are popular among photographic professionals (and keen
amateurs) because of the compact size, and under Windows they are
much faster than many USB2 or Firewire readers.  Under Linux, they
just plain are not recognized -- unless delkin_cb is configured,
in which case they currently achieve about 2/3 the speed of the
MS driver.

I'll pull down your (Alan) latest tree and re-post a 2.6 patch against it.
But I would really like to see Marcelo pick up the 2.4 version as well,
since that is what people are using today.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
