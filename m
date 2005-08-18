Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVHRJdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVHRJdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 05:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVHRJdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 05:33:39 -0400
Received: from [85.8.12.41] ([85.8.12.41]:58003 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932148AbVHRJdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 05:33:38 -0400
Message-ID: <430455D1.6000409@drzeus.cx>
Date: Thu, 18 Aug 2005 11:33:05 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx>	 <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx>	 <20050817224805.17f29cfb.akpm@osdl.org>	 <20050818073824.C2365@flint.arm.linux.org.uk>  <4304380B.5070406@drzeus.cx> <1124358169.13511.3.camel@localhost.localdomain>
In-Reply-To: <1124358169.13511.3.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2005-08-18 at 09:26 +0200, Pierre Ossman wrote:
>  
>
>>everything out first and then fall back on sector-by-sector to determine
>>where an error occurs. This will only break if the problematic sector
>>keeps shifting around, but at that point the card is probably toast
>>anyway (if the thing keeps moving how can you bad block it?).
>>    
>>
>
>Providing the sectors are not finally completed to higher levels until
>they are written that works fine. 
>

I don't think there's any risk of that. What _might_ happen is that more
data gets written to disk than is reported to the upper layers because
of these buffering issues.

Rgds
Pierre

