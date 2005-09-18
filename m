Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVIRGF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVIRGF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 02:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVIRGF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 02:05:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11220
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751122AbVIRGF4 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 02:05:56 -0400
Date: Sat, 17 Sep 2005 23:03:46 -0700 (PDT)
Message-Id: <20050917.230346.117470427.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: zippel@linux-m68k.org, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050917072736.GA16523@flint.arm.linux.org.uk>
References: <Pine.LNX.4.61.0509170234180.3743@scrub.home>
	<20050917.001822.46482906.davem@davemloft.net>
	<20050917072736.GA16523@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sat, 17 Sep 2005 08:27:36 +0100

> gcc did have some support to pass condition codes into assembly.
> On ARM, you used to be able to do things like:
> 
> 	if (foo)
> 		asm("blah%?	whatever");
> 
> and gcc would replace %? with whatever condition was appropriate
> for the current block of code.  You can still write it as the
> above.
> 
> However, this optimisation was disabled on ARM apparantly because
> it was very hard to for people to get correct - if you forgot the
> %?, you need to add a "cc" clobber, and if you forget that as well
> you might get unconditional behaviour.

Yes, that is an error prone syntax to use, that's for sure.
That is, incidentally, why I said the condition test should
be an explicit input arg to the asm.
