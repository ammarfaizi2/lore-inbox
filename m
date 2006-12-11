Return-Path: <linux-kernel-owner+w=401wt.eu-S1762363AbWLKEpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762363AbWLKEpL (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762409AbWLKEpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:45:10 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:55371 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762363AbWLKEpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:45:09 -0500
Date: Sun, 10 Dec 2006 20:45:45 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Nicolas Pitre <nico@cam.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] ucb1400_ts depends SND_AC97_BUS
Message-Id: <20061210204545.a68d15cd.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0612102244140.2630@xanadu.home>
References: <20061209003635.e778ff76.randy.dunlap@oracle.com>
	<200612092150.02940.dtor@insightbb.com>
	<20061209185737.1768315d.randy.dunlap@oracle.com>
	<200612092205.19358.dtor@insightbb.com>
	<Pine.LNX.4.64.0612092212410.2630@xanadu.home>
	<20061209210945.5abe2d89.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0612102244140.2630@xanadu.home>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 22:55:25 -0500 (EST) Nicolas Pitre wrote:

> On Sat, 9 Dec 2006, Randy Dunlap wrote:
> 
> > On Sat, 09 Dec 2006 22:17:55 -0500 (EST) Nicolas Pitre wrote:
> > 
> > > Please consider what SND_CONFIG_AC97_BUS corresponds to.  It is 
> > > sound/pci/ac97/ac97_bus.c and if you look into this file you'll see that 
> > > it is perfectly buildable even if sound is entirely configured out, just 
> > > like some lib code would be.
> > 
> > OK.  Should it (CONFIG_SND_AC97_BUS -> sound/pci/ac97/ac97_bus.c)
> > be buildable when sound is disabled?
> 
> Yes.
> 
> > If so, where should it be moved to (since afaik, make won't even
> > descend into sound/ if SOUND=n; I don't see that changing
> > any time soon).
> 
> What about this patch?

About all I can say is that it builds as expected...


> ----- >8
> Subject: break config ordering/dependency between UCB1400 touchscreen driver and sound subsystem
> 
> Commit 2d4ba4a3b9aef95d328d74a17ae84f8d658059e2 introduced a dependency
> that was never meant to exist when the ac97_bus.c module was created.
> Move ac97_bus.c up the directory hierarchy to make sure it is built when 
> selected even if sound is configured out so things work as originally 
> expected.
> 
> Signed-off-by: Nicolas Pitre <nico@cam.org>


---
~Randy
