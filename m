Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbUDQAR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 20:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUDQAR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 20:17:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:3996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264027AbUDQARy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 20:17:54 -0400
Date: Fri, 16 Apr 2004 17:15:48 -0700
From: Greg KH <greg@kroah.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Maneesh Soni <maneesh@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040417001548.GA10477@kroah.com>
References: <20040413124037.GA21637@in.ibm.com> <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040415220232.GC23039@kroah.com> <20040416152448.GF24997@parcelfarce.linux.theplanet.co.uk> <20040416223732.GC21701@kroah.com> <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416234601.GL24997@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 12:46:02AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Apr 16, 2004 at 03:37:32PM -0700, Greg KH wrote:
> 
> > Since when did we ever assume that renaming a kobject would rename the
> > symlinks that might point to it?  Renaming kobjects are a hack that way,
> > if you use them, you need to be aware of this limitation.
> 
> Since we assume that these symlinks actually reflect some relationship
> between the objects and are really needed for something.  If they are
> not - why the hell do we keep them at all?

They show a relationship, yes.  And it would be nice to be able to try
to keep that link around if possible.

But what devices currently have this problem?  I only thought network
devices renamed themselves, and there are no symlinks to those devices,
only out from it.  In grepping the tree, they seem like the only users
of this functionality, and they would never need the symlink "reaname".

thanks,

greg k-h
