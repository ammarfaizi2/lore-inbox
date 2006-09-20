Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWITW60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWITW60 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWITW60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:58:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29124 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932450AbWITW6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:58:25 -0400
Date: Wed, 20 Sep 2006 15:58:15 -0700
From: Paul Jackson <pj@sgi.com>
To: rohitseth@google.com
Cc: clameter@sgi.com, ckrm-tech@lists.sourceforge.net, devel@openvz.org,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920155815.33b03991.pj@sgi.com>
In-Reply-To: <1158775678.8574.81.camel@galaxy.corp.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773208.8574.53.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
	<1158775678.8574.81.camel@galaxy.corp.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wrote:
> So now we depend on getting memory hot-plug to work for faking up these
> nodes ...for the memory that is already present in the system. It just
> does not sound logical.

It's logical to me.  Part of memory hotplug is adding physial memory,
which is not an issue here.  Part of it is adding another logical
memory node (turning on another bit in node_online_map) and fixing up
any code that thought a systems memory nodes were baked in at boottime.
Perhaps the hardest part is the memory hot-un-plug, which would become
more urgently needed with such use of fake numa nodes.  The assumption
that memory doesn't just up and vanish is non-trivial to remove from
the kernel.  A useful memory containerization should (IMHO) allow for
both adding and removing such containers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
