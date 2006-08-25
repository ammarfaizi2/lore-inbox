Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWHYUd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWHYUd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWHYUd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:33:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32168 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932462AbWHYUd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:33:28 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sekharan@us.ibm.com
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       rohitseth@google.com, hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156531644.1196.26.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra> <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156211128.11127.37.camel@galaxy.corp.google.com>
	 <1156272902.6479.110.camel@linuxchandra>
	 <1156383881.8324.51.camel@galaxy.corp.google.com>
	 <1156385072.7154.59.camel@linuxchandra>
	 <1156440461.14648.26.camel@galaxy.corp.google.com>
	 <1156463572.19702.46.camel@linuxchandra>  <44EEDB23.9050006@sw.ru>
	 <1156531644.1196.26.camel@linuxchandra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 21:52:47 +0100
Message-Id: <1156539168.3007.264.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 11:47 -0700, ysgrifennodd Chandra Seetharaman:
> I think my original point is getting lost in the discussion, which is,
> there should be way (for the sysadmin) to get a list of tasks belonging
> to a resource group (in a non-container environment).

Ok that much is easy to deal with. You print the luid in /proc.

> - ability for the sysadmin to move a task to a resource group.

So you want a setpluid(pid, luid) ? Trivial to add although you might
want to refuse it in many secure environments but thats an SELinux rule
again.

> - assignment of task to a resource group should be transparent to the 
>   app.

In those cases its akin to and matches security domain transitions which
says to me SELinux (or AppArmour) should do it.

> - a resource group could exist with no tasks associated.

Bean counters can exist with no tasks, and the CKRM people have been
corrected repeatedly on this point.


