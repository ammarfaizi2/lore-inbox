Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUIXMwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUIXMwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268717AbUIXMwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:52:45 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:11939 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S268723AbUIXMwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:52:43 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: Is there a user space pci rescan method?
Date: Fri, 24 Sep 2004 14:59:49 +0200
User-Agent: KMail/1.7
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241241.19654@bilbo.math.uni-mannheim.de> <415415BD.4030007@ppp0.net>
In-Reply-To: <415415BD.4030007@ppp0.net>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409241459.50579@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 24. September 2004 14:40 schrieben Sie:
> Rolf Eike Beer wrote:
> > -changed param "usedonly" to "showunused" so it behaves like fakephp at
> > the first look: if you load dummyphp without parameters there are only
> > slots with devices in it.
>
> Well, know I get only entries for all devices I don't have!

There was a device mask but I decided this was too ugly and ripped it out. 
Maybe it would make sense to have a parameter with an array of buses you want 
to see completely or something like this.

> > + dslot->dev = pci_get_slot(dslot->bus, dslot->devfn);
> > +
> > + if (showunused || dslot->dev) {
> > +  retval = 0;
> > +  goto error_dslot;
> > + }
>
> This should probably be !showunused || !dslot->dev ?

Yes. Error in boolean simplification.

Eike
