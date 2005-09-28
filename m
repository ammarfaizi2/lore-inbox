Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVI1XXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVI1XXJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVI1XXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:23:09 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54246 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751226AbVI1XXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:23:08 -0400
Message-ID: <433B25CD.7040809@pobox.com>
Date: Wed, 28 Sep 2005 19:22:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Luben Tuikov <luben_tuikov@adaptec.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org> <433B0374.4090100@adaptec.com> <20050928223542.GA12559@alpha.home.local>
In-Reply-To: <20050928223542.GA12559@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> And when they go to adaptec site to find latest drivers and they only
> find patches which forces them to find another Linux to install the
> sources and guess how to patch and build, do you know which OS they
> consider as hobbyist's ? The Red Hat ! (which they can call "Linux"
> again then).

Adaptec is unfortunately a special case.  QLogic and other enterprise 
vendors get along with quite well on $100k machines.

Both Luben and his predecessor, Justin Gibbs, were severely dissatisfied 
with the SCSI core.  Often they have raised valid issues that need 
addressing, but their choice has been to work around or ignore existing 
code (and maintainers), rather than work with it, and fix it.


> When they will buy hundreds of TB of SAS-based racks in the next few
> years, and they will learn the hard way that Linux does not even see
> them as disks, it will be too late to give my preferred OS a second
> chance.

Hardly.  SAS support is coming, whether from Adaptec or someone else.


> Having read the discussion from the start here a few days ago, I
> believe that Luben maybe has not explained well to non-competent
> people like me what the goal of his work is. I've looked at the GIF
> on T10.org, but I think that the equivalent with what it currently
> implemented in Linux would be worth doing. Maybe we would even
> notice that current maintainers cannot agree on a same representation.

The current maintainers seem to agree on the path to transport independence.


> Anyway Luben, I fear that for some time, you'll have to provide
> pre-patched sources as well as binary kernels to enterprise customers
> who still try to get Linux working in production. I hope that this sad
> experience will not discourage other vendors from trying to take the
> opensource wagon, as it clearly brings fuel to closed-source drivers
> at the moment (no need to argue).

Yes, let's not argue this silliness.  Other vendors don't seem to have 
this level of problem.


> Eventhough I don't have SAS, I sincerely hope that a quick and smart
> solution will be found which keeps everyone's pride intact, as it
> seems to matter much those days. In an ideal situation, 2.7 would
> have been opened for a long time, and Luben's code would have been
> discussed to death as a new development needed to be merged before
> 2.8. Right now, as 2.7 is 2.6.<odd>, probably that ideas can gem
> before 2.6.15.

Sigh.  This is not about pride.  There's already a path to fixing up the 
SCSI core to work nicely with SAS (and nicer with FC/iSCSI).  Changing 
to a new path midstream, in the middle of addressing the stated 
problems, causes more delay, more harm than good.

	Jeff


