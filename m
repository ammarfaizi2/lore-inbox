Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTDYXEH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTDYXEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:04:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263741AbTDYXEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:04:06 -0400
Message-ID: <3EA9C19E.9020205@zytor.com>
Date: Fri, 25 Apr 2003 16:15:42 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
References: <459930000.1051302738@[10.10.2.4]> <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]> <3EA9B061.600@techsource.com> <3280000.1051308382@[10.10.2.4]>
In-Reply-To: <3280000.1051308382@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>>128Mb of it? The bottom page, or even a few Mb, sure ... 
>>>but 128Mb seems somewhat excessive ..
>>> 
>>>
>>
>>Considering that your process space is 4gig, and that that 128Mb doesn't
>>really exist anywhere (no RAM, no page table entries, nothing), it's
>>really not excessive.  
> 
> 
> I need the virtual space.
> 

As far as I know, you're perfectly free to move the stack whereever you
feel like, as long as you map the space first, copy the contents and set
%esp.  mremap() is useful for this.

	-hpa

