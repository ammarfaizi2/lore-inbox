Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVBJVie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVBJVie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 16:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVBJVie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 16:38:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:56005 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261617AbVBJVic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 16:38:32 -0500
Subject: Re: [RFC][PATCH] add driver matching priorities
From: Adam Belay <abelay@novell.com>
To: dtor_core@ameritech.net
Cc: Greg KH <greg@kroah.com>, rml@novell.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000502101046d87d13f@mail.gmail.com>
References: <1106951404.29709.20.camel@localhost.localdomain>
	 <20050210084113.GZ32727@kroah.com>
	 <1108055918.3423.23.camel@localhost.localdomain>
	 <20050210183338.GA9308@kroah.com>
	 <d120d5000502101046d87d13f@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 10 Feb 2005 16:32:56 -0500
Message-Id: <1108071176.3423.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 13:46 -0500, Dmitry Torokhov wrote:
> On Thu, 10 Feb 2005 10:33:38 -0800, Greg KH <greg@kroah.com> wrote:
> > On Thu, Feb 10, 2005 at 12:18:37PM -0500, Adam Belay wrote:
> > >
> > > The second "*match" function in "struct device_driver" gives the driver
> > > a chance to evaluate it's ability of controlling the device and solves a
> > > few problems with the current implementation.  (ex. it's not possible to
> > > detect ISA Modems with only a list of PnP IDs, and some PCI devices
> > > support a pool of IDs that is too large to put in an ID table).
> > 
> > What deficiancy in the current id tables do you see?  What driver has a
> > id table that is "too big"?  Is there some way we can change it to make
> > it work better?
> > 
> 
> Stepping a bit farther away - sometimes generinc matching is not
> enough to determine if driver suits for a device - actual probing is
> needed (consider atkbd and psmouse - they can both attach to the same
> port but we can't determine if it is a keyboard or mouse until we
> started probing)

Also, another example I remember seeing a while back...  Some pcmcia
devices have identical IDs but different chipsets.  The only way to find
the correct driver is to poke around.

Thanks,
Adam


