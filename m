Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267582AbUIOVgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267582AbUIOVgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUIOVeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:34:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:19633 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267542AbUIOV2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:28:39 -0400
Date: Wed, 15 Sep 2004 14:27:54 -0700
From: Greg KH <greg@kroah.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Robert Love <rml@ximian.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915212754.GC25840@kroah.com>
References: <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org> <20040915011146.GA27782@hockin.org> <1095214229.20763.6.camel@localhost> <20040915031706.GA909@hockin.org> <20040915034229.GA30747@kroah.com> <20040915044830.GA4919@hockin.org> <20040915050904.GA682@kroah.com> <20040915062129.GA9230@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915062129.GA9230@hockin.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:21:29PM -0700, Tim Hockin wrote:
> On Tue, Sep 14, 2004 at 10:09:04PM -0700, Greg KH wrote:
> > > > > As much as we all like to malign "driver hardening", there is a *lot* that
> > > > > can be done to make drivers more robust and to report better diagnostics
> > > > > and failure events.
> > > > 
> > > > I agree.  But this interface is not designed or intended for that.  
> > > 
> > > Right.  I originally asked Robert if there was some way to make this
> > > interface capable of handling that, too.  Maybe the answer is merely "no,
> > > not this API".
> > 
> > Seriously, that's not what this interface is for.  This is a simple
> > event notification interface.
> 
> Well, this API is not far from "good enough".  It's meant to be a "simple
> event system" but with a few expansions, it can be a full-featured event
> system :)  And yes, I know the term "feature creep".

Ok, for now, no payload.  

The kevent interface is well defined, bounded and simple.  Let's not try
to muddy it up with arbitraty blobs being passed as a payload (and for
those people who want fimware binary crap in event log messages, please,
just use a sysfs file for access and send a kevent with KOBJ_CHANGE
action.)

The event logging people are working on figuring out what actually needs
to be logged in the first place.  Let's let them finialize that, and
then let them propose a way to get that standardized information out of
the kernel (hint, I don't think that netlink is going to cut it for
them...)

thanks,

greg k-h
