Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUFBMLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUFBMLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUFBMLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:11:18 -0400
Received: from [213.239.201.226] ([213.239.201.226]:13479 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262256AbUFBMKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:10:51 -0400
Message-ID: <40BDC553.4060809@shadowconnect.com>
Date: Wed, 02 Jun 2004 14:17:23 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0406011228130.1794@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Zwane Mwaikambo wrote:
>>>probably too large an area to be remapping.  Try remapping only the
>>>memory area needed, and not the entire area.
>>Is there a way, to increase the size, which could be remapped, or is
>>there a way, to find out what is the maximum size which could be remapped?
>>Thank you very much for the fast answer!
> You could try a 4G/4G enabled kernel, /proc/meminfo tells you how much
> vmalloc (ioremap) space there is too.

VmallocTotal:   245752 kB
VmallocUsed:    137720 kB
VmallocChunk:   107904 kB

Okay, i see the problem now, the largest piece of memory which could be 
allocated is 107904 kB, right?

Is the 4G/4G split already in the kernel? If yes, which entry activates it?

BTW, CONFIG_HIGHMEM4G is enabled already :-)

Thanks for the hint!


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
