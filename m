Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbUCDV2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUCDV2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:28:09 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:30934 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261926AbUCDV2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:28:05 -0500
Message-ID: <40479F3C.1010703@nortelnetworks.com>
Date: Thu, 04 Mar 2004 16:27:24 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org, Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl> <200403031829.41394.mmazur@kernel.pl> <m3brnc8zun.fsf@defiant.pm.waw.pl> <200403042149.36604.mmazur@kernel.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:
> Parts of abi that are standardized 
> (http://www.opengroup.org/onlinepubs/007904975/ - this thing; check the 
> headers section), should be imho provided by C libs. These things do not 
> change (they can't or everything would blow up) and I see no reason why glibc 
> should rely on having additional headers available, just to do what it's 
> supposed to.

And how do you propose to handle a kernel developer that wants to add a 
new feature (a scheduling class, for instance) and make it available to 
userspace apps?

For the sched class example, the standard says, "Four scheduling 
policies are defined; others may be defined by the implementation."  I 
would like to make it easy for kernel developers to extend the 
implementation and expose that to userspace.

It would be nice to have apps be able to include <linux/sched.h> and get 
the *real* kernel sched.h userspace export.  Then when I add 
SCHED_NEW_CLASS to the kernel, userspace can pick up the changes without 
me having to modify glibc headers as well.

> As to linux-common linux-kernelonly and linux-userland headers (linux-common 
> used by both) - I just find it weird for userland to require kernel sources. 
> Linux is supposed to have stable abi.

I would prefer to have the standard userspace kernel headers be owned by 
the kernel.  If we do it right, we could go back to the days of the 
symlink to the headers of the real running kernel.  As far as I can 
tell, that's the only way to avoid having to make changes in multiple 
places.

Chris






-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

