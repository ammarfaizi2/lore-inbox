Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132799AbRADLVW>; Thu, 4 Jan 2001 06:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132847AbRADLVP>; Thu, 4 Jan 2001 06:21:15 -0500
Received: from [62.172.234.2] ([62.172.234.2]:50665 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S132799AbRADLVH>;
	Thu, 4 Jan 2001 06:21:07 -0500
Date: Thu, 4 Jan 2001 11:23:22 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "A.D.F." <adefacc@tin.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: Confirmation request about new 2.4.x. kernel limits
In-Reply-To: <3A546385.C50B1092@tin.it>
Message-ID: <Pine.LNX.4.21.0101041119230.1506-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, A.D.F. wrote:
> Max. RAM size:			64 GB	(any slowness accessing RAM over 4 GB
> 					 with 32 bit machines ?)

realistic benchmarks (unixbench) will show about 3%-6% performance
degradation with use of PAE. Note that this is not "accessing RAM over
4G" but (what you probably meant) "accessing any RAM in a machine with
over 4G of RAM" or even "accessing any RAM in a machine with less than 4G
or RAM but running kernel capable of accessing >4G". If you really meant
"accessing RAM over 4G" then you are probably talking about 36bit MTRR
support which is present in recent 2.4.x kernels and works very nicely!

You can construct artificial benchmarks that will show 10% performance
degradation. I haven't compared this with other PAE implementation,
e.g. that of UnixWare 7.1.1+ -- this would be a very useful exercise as I 
vaguely remember some people claiming that Linux PAE implementation is
not ideal (if it is true then it ought to be made ideal to be inline with
the rest of the kernel).

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
