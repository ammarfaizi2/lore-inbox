Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVCCTs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVCCTs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVCCTpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:45:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56484 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261669AbVCCTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:43:04 -0500
Message-ID: <422768B4.3040506@pobox.com>
Date: Thu, 03 Mar 2005 14:42:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, "David S. Miller" <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	 <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>	 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>	 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>	 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	 <20050303170808.GG4608@stusta.de> <1109877336.4032.47.camel@tglx.tec.linutronix.de>
In-Reply-To: <1109877336.4032.47.camel@tglx.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Thu, 2005-03-03 at 18:08 +0100, Adrian Bunk wrote:
> 
> 
>>This only attacks part of the problem.
> 
> 
> It still does not solve the problem of "untested" releases. Users will
> still ignore the linus-tree-rcX kernels. 
> 
> So we move the real -rcX phase after the so called stable release. 
> 
> Doing -rcX from the "sucker" tree up to a stable release makes much more
> sense and would have more testers and get back lost confidence.


Nod.  I really don't think the key penguins understand that there is 
even a problem here.  Let me attempt to re-state the problem:


	There is no flag day when "bugfixes only" mode begins.


There are two component to this problem:

1) Release maintainers need to avoid merging non-bugfixes.  Lately, the 
key penguins _have_ been doing their job here.  This manifested in 
2.6.11-rc4, 2.6.11-rc5.

2) This "flag day" when bugfixes-only mode starts needs to be completely 
obvious to _scripts_ and really dumb people.  Posting to LKML "with this 
-rc, I am only taking serious bugfixes" doesn't cut it.  There must be a 
clear, consistent point where testing may begin.


As a result of this problem, people have learned [just re-read this 
thread if you don't believe me] that "-rc" doesn't really mean Release 
Candidate until -rc2 or -rc3 or so.  And as a result of that, people do 
less testing.

	Jeff


