Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423241AbWJZMWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423241AbWJZMWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423354AbWJZMWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:22:03 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:28962 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S1423241AbWJZMWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:22:01 -0400
Message-ID: <4540A867.307@debian.org>
Date: Thu, 26 Oct 2006 14:21:59 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, proski@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <1161807069.3441.33.camel@dv>	 <1161808227.7615.0.camel@localhost.localdomain>	 <20061025205923.828c620d.akpm@osdl.org> <1161859199.12781.7.camel@localhost.localdomain>
In-Reply-To: <1161859199.12781.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Oct 2006 12:21:59.0795 (UTC) FILETIME=[55E05C30:01C6F8F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The stopping loading is purely because it now uses _GPLONLY symbols,
> which is fine until the user wants to load a windows driver except for
> the old CIPE driver. Some assumptions broke somewhere along the way and
> the chain of events that was never forseen unfolded.
> 
>> Now, if we do want to disallow gpl module loading after ndis-wrapper has
>> been used then fine
> 
> The problem is we do the dynamic link at module load time. We would have
> to unlink the module if it tried to taint itself, which is clearly not
> what the end user needs to suffer. Having the taint function actually
> taint and printk + return a "Linked gplonly you can't" error seems the
> better solution.
> 
> Really ndiswrapper shouldn't be using _GPLONLY symbols, that would
> actually make it useful to the binary driver afflicted again and more
> likely to be legal.

I'm confused on the discussion:
legal? I don't find how a windo$e driver can be "derived work" of Linux,
and anyway they use a "standard" interface. So it is acceptable for GPL
(IMHO and IANAL). so it is not a legal problem.

I see only a development question:
should we allow untrusted module to know and modify the
"intimate" part of kernel, and cause compability and other large
amount of problems into kernel developers, distribution and users?

So it is a political question, not a legal question!

ciao
	cate
