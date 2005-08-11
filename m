Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVHKOKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVHKOKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVHKOKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:10:23 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:36248 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750782AbVHKOKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:10:21 -0400
Message-ID: <42FB5C4B.2010205@vc.cvut.cz>
Date: Thu, 11 Aug 2005 16:10:19 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: David King <dave@daveking.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Pls help me understand this MCE
References: <42FB5768.8070608@daveking.com>
In-Reply-To: <42FB5768.8070608@daveking.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David King wrote:
> CPU 0 4 northbridge TSC f03d1e587b
> Northbridge Watchdog error
> bit57 = processor context corrupt
> bit61 = error uncorrected
> bus error 'generic participation, request timed out
> generic error mem transaction
> generic access, level generic'
> STATUS b200000000070f0f MCGSTATUS 4
> 
> That's all meaningless to me so I'm looking for help understanding what
> it means and what parts of my system I should be looking at in order to
> try to resolve this MCE.
> 
> A Google search found one hit that suggested that "Something tried to
> access a physical memory address that was not mapped in the CPU."  If
> that is indeed the correct interpretation, is there any wany to figure
> out what that "something" is?

Try dumping *all* MCE values, as well as a call stack.  Even although
MCE is tagged as processor context corrupt, there is rather big chance
that stack trace will point back to the instruction which caused MCE
(it always did in my case),  especially if it is single processor system.
Then you'll at least know which subsystem/driver did that.

						Best regards,
							Petr Vandrovec

