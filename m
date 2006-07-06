Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWGFPc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWGFPc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 11:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWGFPc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 11:32:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42398 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030341AbWGFPc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 11:32:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060701150430.GA38488@muc.de>
	<20060703172633.50366.qmail@web50109.mail.yahoo.com>
	<20060703184836.GA46236@muc.de>
	<1151962114.16528.18.camel@localhost.localdomain>
	<20060704092358.GA13805@muc.de>
	<1152007787.28597.20.camel@localhost.localdomain>
	<20060704113441.GA26023@muc.de>
	<1152137302.6533.28.camel@localhost.localdomain>
	<20060705220425.GB83806@muc.de>
	<m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	<20060706130153.GA66955@muc.de>
Date: Thu, 06 Jul 2006 09:31:45 -0600
In-Reply-To: <20060706130153.GA66955@muc.de> (Andi Kleen's message of "6 Jul
	2006 15:01:53 +0200, Thu, 6 Jul 2006 15:01:53 +0200")
Message-ID: <m18xn621i6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> On Thu, Jul 06, 2006 at 12:12:14AM -0600, Eric W. Biederman wrote:
>> 
>> knows the DIMM by requires the reading of hardware registers,
>> some that are not easily accessible to user space so a kernel driver
>> tends to make sense, just to get the information.  
>> 
>> Possibly we could just  export that information and let the
>> user space figure it out from there.   But memory is a key system
>
> You can do it completely in user space. See mcelog as proof.
>
> And figuring out the channel in a lot of code etc. seems overkill to me - or 
> at least i haven't gotten an explanation why it's better than just
> using the reported address.

So breaking this down simply.

With EDAC on my next boot I get positive confirmation that I either
pulled the DIMM that the error happened on, or I pulled a different
DIMM.

Mapping the hardware addresses to the motherboard silk screen label
before hand is unnecessary and just ensures that you pull out the DIMM
you are trying for the first time.  Making it an optimization for
people who do that a lot.

To the best of my knowledge mcelog even with the --dmi option cannot
give me that.

Knowing that we actually pulled out the DIMM that the errors were
reported against is what we get by going beyond the address
in the machine check.

Does that cross the communication divide?

Eric
