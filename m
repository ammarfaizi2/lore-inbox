Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUI0JHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUI0JHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUI0JHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:07:48 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:417 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S266473AbUI0JHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:07:20 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Greg KH <greg@kroah.com>
Subject: Re: Is there a user space pci rescan method?
Date: Mon, 27 Sep 2004 11:14:44 +0200
User-Agent: KMail/1.7
Cc: Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <200409241432.06748@bilbo.math.uni-mannheim.de> <20040924145542.GA17147@kroah.com>
In-Reply-To: <20040924145542.GA17147@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409271114.44774@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > to get all slots and try to enable the device. We have tested it once
> > with a special PCI debugging board where we can electrically disable the
> > PCI bus so we don't kill our hardware. The problem was that on reenabling
> > a interrupt storm killed the machine, I don't remember the exact problem.
> > IIRC it looked like the kernel found the device but the PCI bridge got
> > confused by the new device (or something like this). I don't know if
> > there is a way to survive this situation as the bridges in "normal"
> > hardware are not hotplug aware. Greg?
>
> Hm, don't know, but that's the whole reason people want this, so it
> should work :)

IMHO they want it for testing logical removal, hot removal without hardware 
support is just too dangerous to test with dummyphp. Or what am I missing?

> The main reason I don't like showing _all_ possible pci devices like
> dummyphp does is that it doesn't handle adding a new device (like you
> just said), and the fact that you forgot to handle pci domains.  If you
> add support for PCI domains, then the list of files in that directory
> will pretty much be unusable.

Ehm? Did you read the code? I use the PCI domains of the slots and buses. And 
by default there are only slots with devices in it shown now.

> Please just add the "rescan" support to fakephp, and everyone will be
> happy...

That can't be. I hate fakephp ;)

Eike
