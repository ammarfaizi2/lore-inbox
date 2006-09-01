Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbWIAPsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbWIAPsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWIAPsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:48:41 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:1028 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751670AbWIAPsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:48:40 -0400
Message-ID: <44F8563B.3050505@shadowen.org>
Date: Fri, 01 Sep 2006 16:48:11 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: schwidefsky@de.ibm.com
CC: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com, rhim@cc.gateh.edu
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
References: <20060901110948.GD15684@skybase>	 <1157122667.28577.69.camel@localhost.localdomain> <1157124674.21733.13.camel@localhost>
In-Reply-To: <1157124674.21733.13.camel@localhost>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> On Fri, 2006-09-01 at 07:57 -0700, Dave Hansen wrote:
>>> +#define PG_state_change                21      /* HV page state is changing. */
>>> +#define PG_discarded           22      /* HV page has been discarded. */ 
>> We're already desperately short on page flags on 32-bit architectures.
>> It seems a wee bit silly to add two arch-generic flags for what is a
>> very specialized arch-specific feature at this point.
> 
> There are even three additional page flags if you apply the full set of
> patches.
> 
>> I know that there are 32-bit s390 kernels, but would this be a
>> reasonable feature to restrict to only 64-bit kernels?  That might be a
>> decent compromise.
> 
> Yes, it is definitly an option to make this a 64-bit only features. In
> particular because the ESSA instruction that is used on s390 is only
> available in zarch mode (=64 bit).

Wow.  Well there are only 7 extra bits available in 64 bit mode (the
FIELDS area is larger on 64bit machines).  Do we really, really need
three new bits.  What are they being used for here.

-apw
