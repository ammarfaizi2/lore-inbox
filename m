Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUH3HE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUH3HE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUH3HE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:04:58 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:42501 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S266289AbUH3HEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:04:51 -0400
Message-ID: <4132D16E.6010003@tuxbox.org>
Date: Mon, 30 Aug 2004 09:04:14 +0200
From: Florian Schirmer <jolt@tuxbox.org>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Pietikainen <pp@ee.oulu.fi>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org> <41324158.4020709@pobox.com> <200408292304.25447.jolt@tuxbox.org> <20040829164528.220424e5.davem@davemloft.net> <20040829234928.GA10060@havoc.gtf.org> <20040830061020.GA21270@ee.oulu.fi>
In-Reply-To: <20040830061020.GA21270@ee.oulu.fi>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while i do agree that this patch is needed and should do what it is 
supposed to do i'm still wondering what the idea behind  
pci_map_single() returning inaccessible DMA addresses is. The pci layer 
knows that the device can only handle addresses up to 1GB. For what 
reasons should it return addresses above that limit? Reading the 
DMA-mappings.txt didn't reveal an answer so maybe someone can shed some 
light onto this topic?

Thanks,
   Florian

Pekka Pietikainen wrote:

>On Sun, Aug 29, 2004 at 07:49:28PM -0400, Jeff Garzik wrote:
>  
>
>>>BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
>>>please :-)  3/4 of this driver have been rewritten since I last
>>>touched it, heh.
>>>      
>>>
>>hehe.  I'll take care of it tonight when I queue Florian's stuff
>>to netdev-2.6 (and thus -mm, and thus eventually mainline).
>>    
>>
>And here's a resend of the bounce buffer patch, which should still
>apply on top of Florians (or without) just fine.
>  
>
