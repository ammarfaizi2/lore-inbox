Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbWFIQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbWFIQQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWFIQQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:16:42 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:9424
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1030223AbWFIQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:16:41 -0400
Message-ID: <44899EE2.2080303@microgate.com>
Date: Fri, 09 Jun 2006 11:16:34 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
References: <1149694978.12920.14.camel@amdx2.microgate.com>  <20060607143138.62855633.rdunlap@xenotime.net> <1149868042.20097.5.camel@amdx2.microgate.com> <Pine.LNX.4.64.0606091757260.17704@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0606091757260.17704@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
>>+config SYNCLINK_HDLC
>>+	bool "Generic HDLC support for SyncLink driver"
>>+	depends on SYNCLINK
>>+	depends on HDLC=y || HDLC=SYNCLINK
> 
> 
> If you replace now 'bool "..."' with 'def_bool y', it's enabled 
> automatically as soon as HDLC is enabled and the user doesn't has to 
> confirm it for every driver separately and it has the same effect as your 
> #ifdef hack.

You need to explain this more.

The only #ifdef in the patch is that which conditionally
compiles the generic HDLC support based on the
kernel configuration option. If I remove those, then
the synclink would require generic HDLC, which
is not what we want.


-- 
Paul Fulghum
Microgate Systems, Ltd.
