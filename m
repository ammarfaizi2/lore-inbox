Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVHPXua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVHPXua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 19:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVHPXua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 19:50:30 -0400
Received: from terminus.zytor.com ([209.128.68.124]:11736 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750746AbVHPXu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 19:50:29 -0400
Message-ID: <43027B79.9070702@zytor.com>
Date: Tue, 16 Aug 2005 16:49:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: zach@vmware.com, akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 4/14] i386 / Clean up asm and volatile keywords in desc
References: <200508110453.j7B4rpe9019530@zach-dev.vmware.com> <20050816234205.GE27628@wotan.suse.de>
In-Reply-To: <20050816234205.GE27628@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Aug 10, 2005 at 09:53:51PM -0700, zach@vmware.com wrote:
> 
>>Stop using extra underscores on asm and volatiles, that is just silly.
> 
> Actually the volatiles might be still useful. Or if you drop them
> at least add memory clobbers. I had sometimes bugs  on x86-64
> with the compiler moving such assembly statements with invisible 
> side effects around too aggressively and causing weird problems.
> 
> Agreed on the underscores, I hate them too :)
> 

Well, put volatiles in *unless* the only effect of an asm statement is 
producing the output values.

	-hpa

