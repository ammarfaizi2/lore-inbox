Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTDXLvK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 07:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTDXLvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 07:51:10 -0400
Received: from pointblue.com.pl ([62.89.73.6]:38929 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263124AbTDXLvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 07:51:08 -0400
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051184807.3604.2642.camel@workshop.saharact.lan>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
	 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
	 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
	 <20030421210020.A29421@lst.de>
	 <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
	 <20030421215637.A30019@lst.de>
	 <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
	 <1050957875.1224.2.camel@flat41>
	 <1051169958.3604.2619.camel@workshop.saharact.lan>
	 <1051171042.1104.11.camel@flat41>
	 <1051184807.3604.2642.camel@workshop.saharact.lan>
Content-Type: text/plain
Organization: K4 Labs
Message-Id: <1051185785.776.3.camel@gregs>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 13:03:05 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 12:46, Martin Schlemmer wrote:
> On Thu, 2003-04-24 at 09:57, Grzegorz Jaskiewicz wrote:
> 
> > Well, if you will read my post - i am trying to use _ONLY_ devfs,
> > without any demons.
> 
> Ok, missed that.
> 
> > Those demons are provided just to keep backward
> > compatbility (at least this is my opinion) and can be used without them.
> > 
> 
> Well, not really.  Yes, it does support the compat symlinks, etc, but
> you can do much more with devfsd than just that.  Setting the
> permissions/ownership on node registration, autoloading of modules
> if a node is accessed, etc is just a few.
Well, we don't need that - all we need is just file with settings cat-ed
to some /proc entry or script that sets up perms on boot/hotplug events.

> 
> > i don't like personaly any ideas about udevfs and others. We should get
> > rid of min/maj nr of each device becouse each single program uses device
> > by name indeed ! Having just devfs solves many problems and is very good
> > thing. But, again - without any userspace demons.
> > 
> 
> See above.
> 
> > Linus was always trying kernel as simple as it is possible, well - imho
> > devfs is just one step forward to make it even simpler but without
> > removing any of it functionality.
> > 
> 
> I guess you could see the management of devfs being done in userspace
> (devfsd) as keeping kernel side simple :P

Well, my point is - why i should install tons of userspace programs while everything can be/should be done internaly - becouse those demons are very close to kernel !
And it is pointles, kernel should be able to do everything required to be fully working by its self - not relay on some userspace shit.  

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 Labs

