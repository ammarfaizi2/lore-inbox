Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTDYXHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 19:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDYXHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 19:07:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13766 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264542AbTDYXHv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 19:07:51 -0400
Date: Fri, 25 Apr 2003 16:19:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: TASK_UNMAPPED_BASE & stack location
Message-ID: <10000000.1051312797@[10.10.2.4]>
In-Reply-To: <3EA9C19E.9020205@zytor.com>
References: <459930000.1051302738@[10.10.2.4]>
 <b8c7no$u59$1@cesium.transmeta.com> <1750000.1051305030@[10.10.2.4]>
 <3EA9B061.600@techsource.com> <3280000.1051308382@[10.10.2.4]>
 <3EA9C19E.9020205@zytor.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> 128Mb of it? The bottom page, or even a few Mb, sure ... 
>>>> but 128Mb seems somewhat excessive ..
>>> 
>>> Considering that your process space is 4gig, and that that 128Mb doesn't
>>> really exist anywhere (no RAM, no page table entries, nothing), it's
>>> really not excessive.  
>> 
>> I need the virtual space.
> 
> As far as I know, you're perfectly free to move the stack whereever you
> feel like, as long as you map the space first, copy the contents and set
> %esp.  mremap() is useful for this.

Right ... I was just suggesting changing it by default. Was wondering if
anyone knew of anything it'd break. Your issue with NULL pointers is
interesting, but I'm not sure this would really affect that much ... the
stack is normally tiny in comparison.

M.

