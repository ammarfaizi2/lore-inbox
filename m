Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTDNWdZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbTDNWdZ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:33:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:36843 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264041AbTDNWdW (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:33:22 -0400
Date: Mon, 14 Apr 2003 15:44:38 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414224438.GB6411@kroah.com>
References: <20030414190032.GA4459@kroah.com> <200304142343.17802.oliver@neukum.org> <20030414215221.GA5989@kroah.com> <200304150019.26809.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304150019.26809.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 12:19:26AM +0200, Oliver Neukum wrote:
> Am Montag, 14. April 2003 23:52 schrieb Greg KH:
> > On Mon, Apr 14, 2003 at 11:43:17PM +0200, Oliver Neukum wrote:
> > > > > Well, for a little elegance you might introduce subdirectories for
> > > > > each type of hotplug event and use only them.
> > > >
> > > > No, that's for the individual scripts/programs to decide.  For example,
> > > > that's what the current hotplug scripts do, but that's not at all what
> > > > the udev program wants to do.
> > >
> > > So have them put a symlink into each subdirectory. This is the way it's
> > > done for init since times immemorial.
> >
> > But the number of different "types" keeps growing.  For some programs
> > (like udev) they really don't care about the type, and if you add a new
> > type, it still works just fine.  Other programs do care about the type,
> > so they can look at it and make a judgement based on it.
> 
> How can that be? What kind of thing should care about both
> device addition and routing changes in the same way?

No, udev doesn't care about routing changes.  But there isn't enough
hardcoded logic in it to care about the different subsystems, so it
wants to figure out that it shouldn't care about an event all on its
own.

> Not needlessly exposing scripts to event types they are not written
> to handle is an advantage.

Ok, I like Arnd's proposal of a "default" directory.  Maybe I should
change that to "all" as no one better create a subsystem or driver class
in the kernel called "all" :)

thanks,

greg k-h
