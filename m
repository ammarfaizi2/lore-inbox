Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbVKNB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKNB60 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVKNB60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:58:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41354 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750829AbVKNB6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:58:25 -0500
Message-ID: <4377EF3A.7060908@austin.ibm.com>
Date: Sun, 13 Nov 2005 19:58:18 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051104010021.4180A184531@thermo.lanl.gov> <1131392070.14381.133.camel@localhost.localdomain> <436FE561.7080703@austin.ibm.com> <200511122030.35542.rob@landley.net>
In-Reply-To: <200511122030.35542.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, what I was thinking is that if you use the swsusp infrastructure to 
> suspend all processes, all dma, quiesce the heck out of the devices, and 
> _then_ try to move the kernel...  Well, you at least have a much more 
> controlled problem.  Yeah, it's pretty darn intrusive, but if you're doing 
> "suspend to ram" perhaps the downtime could be only 5 or 10 seconds...

I don't think suspend to ram for a memory hotplug remove would be acceptable to 
users.  The other methods add some complexity to the kernel, but are transparent 
to userspace.  Downtime of 5 to 10 seconds is really quite a bit of downtime.

> I don't know how much of the problem that leaves unsolved, though.

It would still require a remappable kernel.  And seems intuitively to be wrong 
to me.  But if you want to try it out I won't stop you.  It might even work.


