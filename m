Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVDDOWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDDOWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVDDOWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:22:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:10147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261244AbVDDOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:22:24 -0400
Message-ID: <42514D9C.2070003@osdl.org>
Date: Mon, 04 Apr 2005 07:22:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "David S. Miller" <davem@davemloft.net>, matthew@wil.cx,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: iomapping a big endian area
References: <1112475134.5786.29.camel@mulgrave>	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>	 <20050402183805.20a0cf49.davem@davemloft.net>	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>	 <1112499639.5786.34.camel@mulgrave>	 <20050402200858.37347bec.davem@davemloft.net>	 <1112502477.5786.38.camel@mulgrave>  <1112601039.26086.49.camel@gaston> <1112623143.5813.5.camel@mulgrave>
In-Reply-To: <1112623143.5813.5.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Mon, 2005-04-04 at 17:50 +1000, Benjamin Herrenschmidt wrote:
> 
>>I disagree. The driver will never "know" ...
> 
> 
> ? the driver has to know.  Look at the 53c700 to see exactly how awful
> it is.  This beast has byte and word registers.  When used BE, all the
> byte registers alter their position (to both inb and readb).
> 
> 
>>I don't think it's sane. You know that your device is BE or LE and use
>>the appropriate interface. "native" doesn't make sense to me in this
>>context.
> 
> 
> Well ... it's like this. Native means "pass through without swapping"
> and has an easy implementation on both BE and LE platforms.  Logically
> io{read,write}{16,32}be would have to do byte swaps on LE platforms.
> Being lazy, I'm opposed to doing the work if there's no actual use for
> it, so can you provide an example of a BE bus (or device) used on a LE
> platform that would actually benefit from this abstraction?

I would probably spell "native" as "noswap".
"native" just doesn't convey enough specific meaning...

-- 
~Randy
