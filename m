Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIOVpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIOVpu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIOVon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:44:43 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:4758 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S267595AbUIOVlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:41:44 -0400
Date: Wed, 15 Sep 2004 14:41:05 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: David Stevens <dlstevens@us.ibm.com>
cc: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
In-Reply-To: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
Message-ID: <Pine.LNX.4.61.0409151427010.20267@twin.uoregon.edu>
References: <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, David Stevens wrote:

> I've never understood why people are so interested in off-loading
> networking. Isn't that just a multi-processor system where you can't
> use any of the network processor cycles for anything else? And, of
> course, to be cheap, the network processor will be slower, and much
> harder to debug and update software.

I's like to amplify this, adding more general purpose cpu to a machine 
strikes me as the right design choice since they're simply more generally 
useful than dedicated cpu's. look at linux software raid compared to the 
alternatives, frankly I haven't seen a hardware controller that can touch 
it for performance given a similar number of disks and interfaces... 
Currently graphcas card have substantionaly more memory bandwidth and 
pipelines than most general purpose cpu's but eventually that won't be the 
case. as it is gpus still represent the biggest chunk of independat 
computational power in a and at least on the server side we don't even 
use them.

> If the PCI bus is too slow, or MTU's too small, wouldn't
> it be better to fix those directly and use a fast host processor that can
> also do other things when not needed for networking? And why have
> memory on a NIC that can't be used by other things?

Between hyper-transport tunnels, pci-x, pci-express and infinband, the 
bottlnecks between the cpu core and the perhiperals and memory are falling 
away at a rapid clip even as cpu's get faster. we're in a much better 
position to build balanced systems then we were 2 years ago.

> Why don't we off-load filesystems to disks instead?  Or a graphics
> card that implements X ? :-) I'd rather have shared system resources--
> more flexible. :-)
>
>                                        +-DLS
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

