Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUBRWO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 17:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268282AbUBRWO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 17:14:29 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:42211 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S268278AbUBRWO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 17:14:27 -0500
Message-ID: <4033E3A4.80509@nortelnetworks.com>
Date: Wed, 18 Feb 2004 17:13:56 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Raphael Rigo <raphael.rigo@inp-net.eu.org>, linux-kernel@vger.kernel.org,
       andrea@suse.de
Subject: Re: New do_mremap vulnerabitily.
References: <4033841A.6020802@inp-net.eu.org> <Pine.LNX.4.58.0402180954590.2686@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Fixed in 2.6.3 and 2.4.25 (and, I think, vendor kernels), please upgrade
> if you allow local shell access to untrusted users.

There is still a call to do_munmap() that does not check the return 
code, called from move_vma(), which in turn is called in do_mremap().

Can that call ever fail and cause Bad Things to happen?

If we know that its never going to fail, it might be useful to have a 
comment explaining it so we don't open up more exploits in the future.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

