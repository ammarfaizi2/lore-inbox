Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbTA2Q33>; Wed, 29 Jan 2003 11:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTA2Q33>; Wed, 29 Jan 2003 11:29:29 -0500
Received: from fmr09.intel.com ([192.52.57.35]:53224 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S266296AbTA2Q32>;
	Wed, 29 Jan 2003 11:29:28 -0500
Subject: Re: [Pcihpd-discuss] [RFC] Enhance CPCI Hot Swap driver
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Stanley Wang <stanley.wang@linux.co.intel.com>
Cc: Scott Murray <scottm@somanetworks.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301291538190.10354-100000@manticore.sh.intel.com>
References: <Pine.LNX.4.44.0301291538190.10354-100000@manticore.sh.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Jan 2003 00:40:26 -0800
Message-Id: <1043743227.10693.10.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 23:50, Stanley Wang wrote:
> Hi, Scott,
> After reading your CPCI Hot Swap support codes, I have a suggestion
> to enhance it:
> How about to make it be full hot swap compliant?
> I mean we could also do some works like "disable_slot" when we receive
> the #ENUM & EXT signal. Hence the user could yank the hot swap board 
> without issuing command on the console.
> How do you think about it?
> 

How does this behavior translate to "full hot swap compliant"?  I assume
you are talking about wording from PICMG 2.16, which in my opinion
describes the full software stack, not just the driver.  Any kind of
full CPCI solution would have all the user space components to
coordinate disabling a slot before the operator physically yanks the
board (and therefore behave as PICMG specifies).  I'm not so sure the
driver knows enough to make a policy decision on what to do when an
operator bypasses the world and just yanks a board out with no warning.

    --rustyl

