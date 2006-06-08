Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWFHAUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWFHAUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWFHAUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 20:20:50 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:22414
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932506AbWFHAUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 20:20:49 -0400
Message-ID: <44876D59.1000509@microgate.com>
Date: Wed, 07 Jun 2006 19:20:41 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com> <20060607230202.GA12210@havoc.gtf.org>
In-Reply-To: <20060607230202.GA12210@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> On Wed, Jun 07, 2006 at 10:42:58AM -0500, Paul Fulghum wrote:
> 
>>Fix build errors caused by generic HDLC
>>and synclink configuration mismatch. Generic HDLC
>>symbols referenced from synclink drivers do not
>>resolve if synclink drivers are built-in and generic
>>HDLC is modularized.
> 
> 
> Please fix the code instead.  _No_ kernel code should be doing
> 	#define CONFIG_{xxx}
> 
> because that is a reserved namespace.

I'm happy to leave the code as is, as it has been working
for the past 8 years. I'm just trying to fix build errors
for random (unusable) kernel configs that a few people
have complained about.

Many, many people have chimed in so far without looking
at the details and I keep responding many, many, many times
that the generic HDLC support is *optional* for the synclink drivers.

So your suggestion of 'fixing' the code will *break* it.
Either unnecessary code is forced on someone, or
they are deprived of necessary code.

But OK, I'm willing to listen: how do you suggest optionally
including generic HDLC support in the synclink drivers,
depending on whether generic HDLC is enabled without
referring to a configuration option?

--
Paul

