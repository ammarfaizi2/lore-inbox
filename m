Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbVIZPHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbVIZPHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVIZPHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:07:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:11968 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932230AbVIZPHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:07:41 -0400
Date: Mon, 26 Sep 2005 08:07:09 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: usb-snd-audio breakage
Message-ID: <20050926150709.GB15781@kroah.com>
References: <9e4733910509251927484a70c7@mail.gmail.com> <9e4733910509251943277f077a@mail.gmail.com> <20050926033805.GB22376@redhat.com> <9e473391050926063264010349@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050926063264010349@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 09:32:43AM -0400, Jon Smirl wrote:
> So module

That's up to that maintainer.

> and proc code

That is not true at all.

> will strip white space, but sysfs won't strip white space. Where is
> the consistency?

If you want to strip whitespace for all of your subsystem's sysfs files,
a single function call will do this.

After thinking about this for a while, and seeing all of the different
iterations that the sysfs-whitespace-cleanup patch went through, I do
not want to add this to sysfs.  It is very easy to add this to a
subsystem, or even provide a generic function to do this if you want to
(I'd be glad to add that to the sysfs core) but it's not for the core of
sysfs to do for all files.

thanks,

greg k-h
