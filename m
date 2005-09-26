Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVI0HTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVI0HTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVI0HTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:19:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:45006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964844AbVI0HT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:19:26 -0400
Date: Mon, 26 Sep 2005 13:13:31 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: usb-snd-audio breakage
Message-ID: <20050926201331.GA18480@kroah.com>
References: <9e4733910509251927484a70c7@mail.gmail.com> <9e4733910509251943277f077a@mail.gmail.com> <20050926033805.GB22376@redhat.com> <9e473391050926063264010349@mail.gmail.com> <20050926150709.GB15781@kroah.com> <9e473391050926085476c1582d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050926085476c1582d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 11:54:31AM -0400, Jon Smirl wrote:
> On 9/26/05, Greg KH <greg@kroah.com> wrote:
> > After thinking about this for a while, and seeing all of the different
> > iterations that the sysfs-whitespace-cleanup patch went through, I do
> > not want to add this to sysfs.  It is very easy to add this to a
> > subsystem, or even provide a generic function to do this if you want to
> > (I'd be glad to add that to the sysfs core) but it's not for the core of
> > sysfs to do for all files.
> 
> I went through the iterations because I hadn't thought about the case
> where people were assigning multi-line CR terminated values to sysfs
> attributes and then using multiple reads to process the assignments
> one line at a time. I had thought that sysfs was only supposed to
> allow the assignment of single values.

Yes, that is "heavily encouraged" to be the case.  But as you found
out...

thanks,

greg k-h
