Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270869AbTGNVGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 17:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270846AbTGNVDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 17:03:36 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:38396 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S270844AbTGNVCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 17:02:05 -0400
Date: Mon, 14 Jul 2003 14:22:22 -0700
From: Deepak Saxena <dsaxena@mvista.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
Message-ID: <20030714212222.GA21569@xanadu.az.mvista.com>
Reply-To: dsaxena@mvista.com
References: <Sea2-F18ekWo76UaiRN00008964@hotmail.com> <3F12FE4B.2070004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F12FE4B.2070004@pobox.com>
User-Agent: Mutt/1.4i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 14 2003, at 15:02, Jeff Garzik was caught saying:
> David griego wrote:
> >IMHO, there are several cases for some type of TCP/IP offload.  One is 
> >for embedded systems that are just not capable of doing 1Gbps+.  Another 
> >is with 10GbE, even high end servers will not be able keep up with TCP 
> >processing/data movement at these speeds.  Not being proactive in 
> >adopting TCP/IP offload will force Linux into accepting some scheme that 
> >will not necissarily be best.
> 
> 
> How does one evaluate a TOE stack to be sure that all the security fixes 
> in Linux are also in that stack?
> 
> How does one evaluate a TOE stack to be sure it doesn't add new security 
> holes that Linux never had?

I just replied to Jeff privately regarding this on a side thread, but
here it is again:

My question back is how do you evaluate a high-end SCSI RAID controller
to make sure that there is no bug in the firmware that causes you to loose 
all your data? You test it and if it fails miserably, you go yell at the
HW manufacturer. There's no argueing that the question needs to be answered 
b/c opening up a security hole is a dangerous thing to do, but perhaps some 
sort of standardized test could be developed by the community, HW vendors, 
and OSDL?  I agree that TOE has problems and many of the points addressed 
by others in this thread are valid concerns, but simply saying that
because of these issues "TOE will never happen" or "TOE is Evil" is not 
going to make the desire of TOE from HW vendors go away. There needs to 
be an open discussion between HW vendors and the community to determine 
the best way to move forward. This includes addressing questions such as
do we want TOE + non-TOE stacks running at the same time? (I propose
a big no for that since the level of complexity has just increased
many times). Do we want to support multiple TOEs? How do we handle
routing between TOEs? Etc... We either need to start thinking about
these issues now or we'll be stuck with crap implementation requirements
due to already existing TOE support in other OSes.  In a perfect academic 
world TOE might be a horrid idea that should die, but the HW vendors have 
already decided to move in this direction? How is linux going to react to 
this: Just ignore it until it's too late or be pro-active about it?

A minimum step would be moving in the direction of FreeBSD and providing
hooks for alternate stacks. That way if an embedded developer wanted
to provide a different stack, he could do so and take full responsibility 
for supporting that kernel.

Finally, I would like to point out that just b/c something is considered
bad does not preclude it from being in the kernel. I think most kernel
developers agree that PAE, I2O, ISAPNP and other technologies are broken
and we wish they would die, yet Linux still supports them. Why? B/C the
HW requires it.  TOE is going to be no different. 

~Deepak

-- 
Deepak Saxena
MontaVista Software - Powering the Embedded Revolution - www.mvista.com
