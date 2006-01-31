Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWAaJbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWAaJbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 04:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWAaJbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 04:31:36 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:4760 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1750729AbWAaJbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 04:31:35 -0500
Message-ID: <43DF2E85.4000200@shadowconnect.com>
Date: Tue, 31 Jan 2006 10:31:49 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI layer: Need for enable/disable counting (was  disable PCI
 device if it is enabled	before probing)
References: <43D566DB.2010103@shadowconnect.com>	 <1138645069.31089.79.camel@localhost.localdomain>	 <43DE6A06.9030707@shadowconnect.com> <1138662069.31089.89.camel@localhost.localdomain>
In-Reply-To: <1138662069.31089.89.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:
> On Llu, 2006-01-30 at 20:33 +0100, Markus Lidel wrote:
>> I've searched for a function enabled() or so, but didn't find anything. 
>> Could you tell me the right way to do it normally?
> Right now there isn't one. I've hit this problem with the new libata

OK, at least i haven't overseen something :-D

> layer stuff having successfully disabled my root pci bridge on unload at
> least once.

Hmmm, think this is something everyone could use...

> Would be easy to add one but I suspect it should be rcounted so that
> enable/disable just stack naturally ?

Sounds great to me... So the verification if the device is enabled before 
could be completely removed from my and probably others code...

> What do people want from such an interface and should it also start boot
> enabled devices at a count of 1 or just the bridges/video class
> devices ?

Hmmm, i don't know what happens if a boot enabled device is disabled, but 
from my point of view i would start at 1 :-D

Probably also the probing function could also enable the device, so the 
subsystems don't have to do it on there own? But because i don't know PCI 
stuff very well i don't know if this makes sense at all...

Thank you very much!


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
