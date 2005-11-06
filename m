Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVKFDvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVKFDvq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 22:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVKFDvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 22:51:46 -0500
Received: from ozlabs.org ([203.10.76.45]:22951 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932261AbVKFDvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 22:51:45 -0500
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Kay Sievers <kay.sievers@vrfy.org>, 333052@bugs.debian.org,
       Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051105184802.GB25468@ojjektum.uhulinux.hu>
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org>
	 <20051105184802.GB25468@ojjektum.uhulinux.hu>
Content-Type: text/plain
Date: Sun, 06 Nov 2005 14:51:36 +1100
Message-Id: <1131249096.12902.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-05 at 19:48 +0100, Pozsar Balazs wrote:
> On Sat, Nov 05, 2005 at 06:31:04PM +0100, Kay Sievers wrote:
> > I've got these messages several times on the experimental SUSE too,
> > but can't reproduce it so far, even without Rusty's patch to modprobe
> > they have disappeared. See here for the details:
> >   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=333052
> 
> 
> Just to let you know, I've also met this problem (on another distro), 
> and did not know about this bugreport until now.
> So I've done another workaround: modprobe already parses /proc/modules 
> to check whether the modules needed are already loaded, and this file 
> also shows us the state of the modules, being "Loading", "Live" or 
> "Unloading".
> 
> With my patch, modprobe waits until the needed modules come out of the 
> "Loading" or "Unloading" state.

Yes, this was going to be my solution.  However, we only need to resort
to this is locking fails (read-only root filesystem).

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

