Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVHKQmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHKQmX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVHKQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:42:23 -0400
Received: from mx1.aub.nl ([213.84.36.140]:40683 "EHLO mx1.aub.nl")
	by vger.kernel.org with ESMTP id S1751114AbVHKQmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:42:22 -0400
Message-ID: <42FB7FC2.10405@aub.nl>
Date: Thu, 11 Aug 2005 18:41:38 +0200
From: Bolke de Bruin <bdbruin@aub.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA
References: <42FB72DE.8000703@aub.nl> <200508111819.45325@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508111819.45325@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>arrays allocated by the driver eat 2kB each, so a stack overflow is very 
>likely. Even with 8kB stack it is still not impossible. Using the version 
>from 2.6.5 will not be a very good idea I think, it's likely to crash your 
>machine one day.
>
>  
>
:-(

>The right solution would be fixing the driver to use kmalloc()/kfree() when he 
>really needs the memory. There was a patch only a few days ago that tried to 
>do that, but it was not really well done and would have crashed. If you are 
>really interested in I can do such a patch. The code of this driver sucks 
>universes through nanotubes, but one day someone _will_ have to start 
>cleaning this up.
>  
>
Define: really interested

So, probably we are really interested. Though there are a couple of caveats:

- Testing can be done only very limited. We have only one raid array 
available and it is in production
- Servers are not in yet, but will been in the next couple of weeks
- As Arjan noted the kernel will be "some vendor 2.6.5". More precisely 
sles9 or rhle 3. This is dictated by the setup of informix 10 on those 
machines, we are stuck with that unfortunately. To be really interesting 
a patch should be backportable to 2.6.5 (or the equivalent rh kernel).

further more

- I am currently investigating if other controllers are able to support 
this raid array and are supported. If so it might be a better idea to 
use those
- We are willing to offer something in exchange. This ranges from 24 
bottles of beer of your choice to something else. The something else 
part needs to be discussed, but the beer part I can be held responsible 
for :-)

Kind Regards,

B. de Bruin
