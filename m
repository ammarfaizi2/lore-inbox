Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIOVkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIOVkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIOVhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:37:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:11188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267587AbUIOVgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:36:42 -0400
Date: Wed, 15 Sep 2004 14:35:26 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@novell.com>
Cc: Tim Hockin <thockin@hockin.org>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915213526.GD25840@kroah.com>
References: <1095279043.23385.102.camel@betsy.boston.ximian.com> <20040915202234.GA18242@hockin.org> <1095279985.23385.104.camel@betsy.boston.ximian.com> <20040915203133.GA18812@hockin.org> <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095283589.23385.117.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:26:29PM -0400, Robert Love wrote:
> On Wed, 2004-09-15 at 14:23 -0700, Greg KH wrote:
> 
> > We aren't giving absolute /dev entries here, that's the beauty of the
> > kobject tree :)
> 
> Not that I agree, but I don't think it is the absolute /dev entries that
> bother him: it is the fact that knowledge of the mount itself is an
> information leak.
> 
> Which it is.  As root, in my name space, I should rest in the knowledge
> that my mounts are secret, I guess.  But I just do not see it as a big
> problem.

Hm, this is an issue that I and the FreeBSD author of jail were talking
about a week or so ago when I was describing why we did udev in
userspace and the hotplug stuff.  He pointed out the namespace issue as
the biggest problem for FreeBSD to be able to do the same kind of thing
that we are doing.

But I agree, I don't think it's a big deal right now either.

thanks,

greg k-h
