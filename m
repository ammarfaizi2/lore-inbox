Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTLOP6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTLOP6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:58:54 -0500
Received: from fmr99.intel.com ([192.55.52.32]:29673 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263809AbTLOP6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:58:49 -0500
Message-ID: <3FDDDA01.20403@intel.com>
Date: Mon, 15 Dec 2003 17:57:53 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>
In-Reply-To: <20031215103142.GA8735@iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:

Gabriel,
I verified with PCI-E designers,
uncacheable memory relates to snoop/non-snoop, not to buffering in 
bridge. Bridge will still buffer writes.
The only way to be sure data has arrived, is to perform read.

Vladimir.

>>>Further, PCI posting:  a writeb() / writew() / writel() will not be 
>>>flushed immediately to the processor.  The CPU and/or PCI bridge may 
>>>post (delay/combine) such writes.  I do not think this is a desireable 
>>>effect, for PCI config register accesses.
>>>
>>>      
>>>
>>Good point. Fixed.
>>    
>>
>
>Here I'm somehwat lost. Writes to uncacheable RAM will be in program 
>order and never combined. The bridge itself should not post writes to 
>config space. So it's a matter of pushing the write to the processor
>bus, a PCI read looks very heavy for this. Isn't there a more
>lightweight solution ?
>
>	Regards,
>	Gabriel
>
>  
>

