Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUEQTiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUEQTiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUEQTiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:38:23 -0400
Received: from pop.gmx.net ([213.165.64.20]:60902 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262431AbUEQThR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:37:17 -0400
X-Authenticated: #4512188
Message-ID: <40A91467.9060501@gmx.de>
Date: Mon, 17 May 2004 21:37:11 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: Jesse Allen <the3dfxdude@hotmail.com>,
       Ross Dickson <ross@datscreative.com.au>,
       Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>	 <200404282133.34887.ross@datscreative.com.au>	 <20040428205938.GA1995@tesore.local>	 <200404292144.37479.ross@datscreative.com.au>	 <20040429202413.GA1982@tesore.local> <40916638.2040202@gmx.de>	 <20040503204520.GA1994@tesore.local>  <40A8D9C2.7070608@gmx.de> <1084822323.9714.0.camel@amilo.bradney.info>
In-Reply-To: <1084822323.9714.0.camel@amilo.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:
> On Mon, 2004-05-17 at 17:26, Prakash K. Cheemplavam wrote:
> 
>>Hi all,
>>
>>I just made an interesting finding and would like to have comments from 
>>NVidia:
>>
>>Chip   Current Value   New Value
>>C17       1F0FFF01     1F01FF01
>>C18D      9F0FFF01     9F01FF01
>>
>>In fact I have the newer chip revision (lspci says c1), but due to a 
>>post at Abit Forums I tried to use the value for the older revision on 
>>my board, and guess what: I never had such low idle temps! I am 
>>currently even using nvidia binary graphics driver and usually I would 
>>be having around 49-51°C idle temp, but now it is around 45°C, and it 
>>was not the first boot (then the mobo usually shows 5°C less). Instead 
>>the temp steadily fell from >50°C to 45°C.
>>
>>(esp @nvidia:) Is there anything evil using the old chip's value for the 
>>new chip? So far I haven't noticed any bad thing about it. Perhaps some 
>>daring nforce2 user with the new revision should try as well.
>>
> 
> 
> Isnt it the case that that change is the one that brings about
> stability? Was indicated before to be the main causing c1halt crashes.

Nope, I am changing the 9F to 1F. The "stability byte" was changing the 
0F to 01. I am no using 1F01FF01 instead of 9F01FF01. I guess I wasn't 
clear enough.

Prakash
