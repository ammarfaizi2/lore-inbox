Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUCQAQF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUCQAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:16:05 -0500
Received: from alt.aurema.com ([203.217.18.57]:1924 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261863AbUCQAQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:16:00 -0500
Message-ID: <405798B2.5090601@aurema.com>
Date: Wed, 17 Mar 2004 11:15:46 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: finding out the value of HZ from userspace
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it>	<1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it>	<1AaWr-655-7@gated-at.bofh.it>	<m3fzc9o7bc.fsf@averell.firstfloor.org>	<40569655.2030802@aurema.com>	<20040316061611.GA77627@colin2.muc.de>	<40578A87.8030501@aurema.com> <20040316235658.GA70879@colin2.muc.de>
In-Reply-To: <20040316235658.GA70879@colin2.muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>These programs could (and should) use sysconfig(_SC_CLK_TCK) to find out 
>>how many ticks there are in a second so this does not constitute a good 
>>reason for USER_HZ not being equal to HZ.
> 
> 
> These programs are usually shell scripts that initialise some sysctls.

Which ones?  Top and ps don't appear to be scripts on my system (Red Hat 
9.0).

> It's not easy to call sysconf from there.

A small utility program would suffice.

> Also we tend to avoid breaking
> things that would fail silently instead of failing with an obvious error 
> message.  This would be such a case. Silent breakage is an extremly bad
> thing.

This is the responsibility of the authors of the programs in question 
not the kernel.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

