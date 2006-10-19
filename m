Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946097AbWJSOtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946097AbWJSOtD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946098AbWJSOtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:49:01 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:5980 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946097AbWJSOtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:49:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YqZr0UJLMCIpuqPRfANA0aWr0p5uJYMU2zo/X9ngyHvwCzmnh32/PrMoaxnNQ9pZ9HGgHmUh1tOL7N+6Udvyi4a99TYxNh21M+zn+7Fay1bn9PHU3AxSSzVCbBFhkKI+PcRv5aNnV58RGxbhssxini0Ro3EweSq/YatWMeGRbFs=  ;
Message-ID: <45379031.601@yahoo.com.au>
Date: Fri, 20 Oct 2006 00:48:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mingo@elte.hu, tglx@linutronix.de
Subject: Re: + i386-time-avoid-pit-smp-lockups.patch added to -mm tree
References: <200610112126.k9BLQqKG002529@shell0.pdx.osdl.net> <1161266225.11264.13.camel@c-67-180-230-165.hsd1.ca.comcast.net> <45378A35.5020101@yahoo.com.au> <200610191626.10662.ak@suse.de>
In-Reply-To: <200610191626.10662.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>An SMP kernel can boot on UP hardware, in which case I think
>>num_possible_cpus() will be 1, won't it?
> 
> 
> 0 was a typo, i meant 1 for UP of course. 0 would be nonsensical.

Sure, I realised that. For a UP kernel, the test will compile away.

But Daniel seems to say there is dead code that could be compiled
out for SMP kernels. I just don't think that is possible because the
SMP kernel can boot a UP system where num_possible_cpus() is 1.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
