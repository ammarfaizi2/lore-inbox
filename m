Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUGGCFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUGGCFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 22:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGGCFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 22:05:10 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:17615 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S264798AbUGGCFE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 22:05:04 -0400
Subject: Re: 0xdeadbeef vs 0xdeadbeefL
From: Ray Lee <ray-lk@madrabbit.org>
To: tomstdenis@yahoo.com, eger@havoc.gtf.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1089165901.4373.175.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 19:05:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tom st denis quoted David Eger saying:

>> Is there a reason to add the 'L' to such a 32-bit constant like
>> this? There doesn't seem a great rhyme to it in the headers...
> 
> IIRC it should have the L [probably UL instead] since numerical 
> constants are of type ``int'' by default. 
> [...]
> However, by the standard 0xdeadbeef is not a valid unsigned 
> long constant.

I think you have a different standard than I do [1]. According to K&R,
2nd ed, section A2.5.1 (Integer Constants):

        The type of an integer depends on its form, value and suffix.
        [...] If it is unsuffixed octal or hexadecimal, it has the first
        possible of these types ["in which its value can be represented"
        -- from omitted]: int, unsigned int, long int, unsigned long
        int.

Which means 0xdeadbeef is a perfectly valid literal for an unsigned int.

Ray

	[1] "The great thing about standards is that there are so many
	     of them to choose from."  Wish I could remember who said
	     that.


