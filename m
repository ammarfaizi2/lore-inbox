Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbUJWVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUJWVqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbUJWVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 17:46:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:45256 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261296AbUJWVqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 17:46:13 -0400
Date: Sat, 23 Oct 2004 23:46:33 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.9
Message-ID: <20041023214633.GA14325@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <10982037783139@kroah.com> <20041023202037.GA12345@dreamland.darkstar.lan> <20041023203404.GA24993@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023203404.GA24993@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, Oct 23, 2004 at 01:34:04PM -0700, Greg KH ha scritto: 
> On Sat, Oct 23, 2004 at 10:20:37PM +0200, Kronos wrote:
> > Greg KH <greg@kroah.com> ha scritto:
> > > ChangeSet 1.1867.3.4, 2004/09/15 11:36:09-07:00, greg@kroah.com
> > > 
> > > kevent: standardize on the event types
> > > 
> > > This prevents any potential typos from happening.
> > 
> > [cut]
> > 
> > > diff -Nru a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > > --- a/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> > > +++ b/lib/kobject_uevent.c      2004-10-19 09:22:44 -07:00
> > > @@ -19,9 +19,29 @@
> > > #include <linux/skbuff.h>
> > > #include <linux/netlink.h>
> > > #include <linux/string.h>
> > > +#include <linux/kobject_uevent.h>
> > > #include <linux/kobject.h>
> > > #include <net/sock.h>
> > > 
> > > +/* 
> > > + * These must match up with the values for enum kobject_action
> > > + * as found in include/linux/kobject_uevent.h
> > > + */
> > > +static char *actions[] = {
> > > +       "add",          /* 0x00 */
> > > +       "remove",       /* 0x01 */
> > > +       "change",       /* 0x02 */
> > > +       "mount",        /* 0x03 */
> > > +};
> > 
> > Hi Greg,
> > maybe it's just a matter of taste but I think that is better to do
> > something like this:
> > 
> > static char *actions[] = {
> >         [KOBJ_ADD]      = "add",
> >         [KOBJ_REMOVE]   = "remove",
> >         [KOBJ_CHANGE]   = "change",
> >         [KOBJ_MOUNT]    = "mount",
> > };
> > 
> > This would prevent the insertion of a new action in the wrong place.
> 
> See the following patches in the series, which fixes this up :)

Ah, right. I missed that patch. Sorry for the noise.

Luca
-- 
Home: http://kronoz.cjb.net
Sono un mirabile incrocio tra Tarzan e Giacomo Leopardi.
In me convivono tutte le doti intelluttuali di Tarzan e
tutta la prestanza fisica di Giacomo Leopardi.
A. Borsani
