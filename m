Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbTJBBoW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTJBBoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:44:21 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:32497 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263116AbTJBBn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:43:59 -0400
Date: Wed, 01 Oct 2003 20:45:04 -0500
From: John Lange <john.lange@bighostbox.com>
Subject: Re: A new model for ports and kernel security?
In-reply-to: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Valdis.Kletnieks@vt.edu, mcmanus@ducksong.com, jmorris@redhat.com
Message-id: <1065059104.5142.133.camel@mars>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few people suggested various patches which implement a similar
functionality to what I was suggesting and I thank them for that.

I think this clearly demonstrates that there is a demand for such a
feature.

> We should keep the standard behavior as default in the core kernel.  Other 
> security models can be implemented via LSM, Netfilter, config options etc.

I believe there are several compelling reasons why the standard
behaviour should be changed.

- patches are not a real solution. As a sysadmin I can't afford the
extra headache of applying patches after the fact every time I need to
upgrade the kernel. Also, if there is an urgent patch to the kernel then
I would have to wait for the external patch to be updated before I could
do a kernel compile. So generally external patches are problematic for
your standard sysadmin.

- If the functionality is not built into the standard behaviour then no
one will code for it.

- If it is generally agreed that the current behaviour is outdated and
creates problems with security then we have to ask "Is there any
compelling reason to keep it?" Would linux with the patch not be a
better, more secure Linux?

Backward compatibility would not be a problem because most programs just
try and grab the port and error if they can't get it. They would work
fine under the /etc/ports idea.

Any other programs that might have problems (for example any which check
to see if they are root before starting) can still be started as root.
Again, no problem.

So, why not?

-- 
John Lange
BigHostBox.com ltd


On Wed, 2003-10-01 at 14:27, James Morris wrote:
> On Wed, 1 Oct 2003, John Lange wrote:
> 
> > Suggestion: A groups based port binding security system for both
> > outgoing and incoming port binding.
> 
> Something like this for port binding exists as an external patch:
> http://www.olafdietsche.de/linux/accessfs/
> 
> > I realize similar things can be accomplished in other ways (with
> > iptables I believe) but it just seems to me that this should be a
> > fundamental part of the systems security and therefore should be in the
> > kernel by default (just as the root binding to low ports is currently).
> 
> We should keep the standard behavior as default in the core kernel.  Other 
> security models can be implemented via LSM, Netfilter, config options etc.
> 
> 
> - James


