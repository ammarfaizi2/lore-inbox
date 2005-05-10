Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVEJWmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVEJWmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVEJWmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:42:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:45734 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261829AbVEJWmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:42:02 -0400
Date: Tue, 10 May 2005 15:41:12 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>
Cc: Per Svennerbrandt <per.svennerbrandt@lbi.se>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050510224112.GA4967@kroah.com>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 12:17:12AM +0200, Per Liden wrote:
> I'd like to get a better understanding of that as well. Why invent a 
> second on demand module loader when we have kmod? The current approach 
> feels like a step back to something very similar to the old kerneld.

kmod is not used at all if you are running udev on your system.  It's
also better to allow userspace to make the decision as to if it should
load a specific module or not, not the kernel.

And it allows us to get rid of the kmod code entirely :)

thanks,

greg k-h
