Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263335AbVFYEm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbVFYEm7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbVFYEm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:42:59 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:60022 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S263335AbVFYEmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:42:52 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] bind and unbind drivers from userspace through sysfs
Date: Fri, 24 Jun 2005 23:22:57 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>
References: <20050624051229.GA24621@kroah.com>
In-Reply-To: <20050624051229.GA24621@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506242322.57535.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 00:12, Greg KH wrote:
> Now that we have the internal infrastructure of the driver model
> reworked so the locks aren't so global and imposing, it's possible to
> bind and unbind drivers from devices from userspace with only a very
> tiny ammount of code.
> 
> In reply to this email, are two patches, one that adds bind and one that
> adds unbind functionality.  I've added these to my trees and should show
> up in the next -mm releases.  Comments appreciated.
> 
> Oh, and yes, we still need a way to add new device ids to drivers from
> sysfs, like PCI currently has.  I'll be working on that next.
>

I think this is an overkill if you can do manual bind/unbind.

> Even so, with these two patches, people should be able to do things that
> they have been wanting to do for a while (like take over the what driver
> to what device logic in userspace, as I know some distro installers
> really want to do.)
> 

I think bind/unbind should be bus's methods and attributes should be
created only if bus supports such operations. Some buses either have
or may need additional locking considerations and will not particularly
like driver core getting in the middle of things.

Btw, do we really need separate attributes for bind/unbind?

-- 
Dmitry
