Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267052AbUBMP1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267053AbUBMP1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:27:42 -0500
Received: from gw-nl3.philips.com ([161.85.127.49]:39559 "EHLO
	gw-nl3.philips.com") by vger.kernel.org with ESMTP id S267052AbUBMP1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:27:40 -0500
Message-ID: <402CED8C.4040203@basmevissen.nl>
Date: Fri, 13 Feb 2004 16:30:20 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tevaugha@ball.com, tevaughan@comcast.net
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernel boot crashing
References: <20040211154044.GA656@ball.com> <E1Aqxgm-0005G4-00@chiark.greenend.org.uk> <20040211213243.GA5133@ball.com>
In-Reply-To: <20040211213243.GA5133@ball.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas E. Vaughan wrote:
> On Wed, Feb 11, 2004 at 04:58:16PM +0000, Matthew Garrett
> wrote:
> 
>>Thomas E. Vaughan wrote:
>>
>>
>>>PnPBIOS: PnP BIOS version 1.0, entry 0xf000:0x6d5a, dseg 0xf000
>>>general protection fault: 0000 [#1]
>>
>>There have been problems with PnP BIOS support on various
>>motherboards.  Try rebuilding the kernel package without
>>PNPBIOS support (you probably don't need it - it's there
>>in order to manage resource allocation for legacy hardware
>>like serial ports, and in most cases the BIOS will happily
>>set those up on its own) and see if that works.
> 
> 
> That did the trick.  The only config option that matters is
> 
>    "Plug and Play BIOS support (EXPERIMENTAL)",
> 
> which must *not* be selected.  I noticed that the top-level
> 
>    "Plug and Play support"
> 
> and also
> 
>    "ISA Plug and Play support (EXPERIMENTAL)"
> 
> can be selected, and the kernel still boots OK.  But that
> PnPBIOS support crashes the kernel hard.
> 

I can confirm that on an Asus P4P800 Deluxe motherboard too for at least 
kernel 2.6.0 and 2.6.1.

Setting the command line option pnpbios=off is a good fix for people who 
would like to run a pre-compiled kernel on those mainboards.

Regards,

Bas.

