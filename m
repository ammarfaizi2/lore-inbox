Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUGSDiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUGSDiD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 23:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUGSDiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 23:38:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13460 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264668AbUGSDh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 23:37:56 -0400
Date: Sun, 18 Jul 2004 23:37:19 -0400
From: Daniel Veillard <veillard@redhat.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, nautilus-list@gnome.org
Subject: Re: [PATCH] inotify 0.5
Message-ID: <20040719033719.GA24114@redhat.com>
Reply-To: veillard@redhat.com
References: <1090180167.5079.21.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090180167.5079.21.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 03:49:27PM -0400, John McCutchan wrote:
[...]
> I have attached a tarball, which includes the patch for linux 2.6.7 and
> a small test app.
> 
> I have tested this on my system and AFAIK it is working. No doubt it has
> plenty of bugs.
> 
> I plan on adding an inotify backend to gamin soon.

  I take patches :-)
But I think it misses the really good point of inotify as I see
it, i.e. there is no need anymore of a daemon outside the application
space, in practice I would rather see inotify plugged at the gnome-vfs
level. The reason is that you will just need to monitor the inotify
file descriptor, which is easy to do at the gnome-vfs level since you
have glib and loop access, while in libgamin this would either require
disabling dnotify if inotify is available (FAM has only one fd registered
at the application layer), or use the daemon for inotify too.
The only advantage of using the daemon would be for advanced features
like congestion control, which are not available (yet ?) in gamin.

  inotify sounds good to me, I hope it won't be bounced by the kernels
people.

Daniel

-- 
Daniel Veillard      | Red Hat Desktop team http://redhat.com/
veillard@redhat.com  | libxml GNOME XML XSLT toolkit  http://xmlsoft.org/
http://veillard.com/ | Rpmfind RPM search engine http://rpmfind.net/
