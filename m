Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVEKRnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVEKRnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEKRnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:43:05 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:20234 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262011AbVEKRl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:41:56 -0400
Date: Wed, 11 May 2005 10:41:53 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511174153.GA16353@suse.de>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509211323.GB5297@tsiryulnik> <Pine.LNX.4.63.0505102351300.8637@1-1-2-5a.f.sth.bostream.se> <20050510224112.GA4967@kroah.com> <Pine.LNX.4.63.0505110057550.20513@1-1-2-5a.f.sth.bostream.se> <20050511053320.GC8287@suse.de> <Pine.LNX.4.63.0505111824060.2216@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505111824060.2216@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 07:36:54PM +0200, Per Liden wrote:
> On Tue, 10 May 2005, Greg KH wrote:
> 
> > On Wed, May 11, 2005 at 01:56:01AM +0200, Per Liden wrote:
> > > On Tue, 10 May 2005, Greg KH wrote:
> > > 
> > > > On Wed, May 11, 2005 at 12:17:12AM +0200, Per Liden wrote:
> > > > > I'd like to get a better understanding of that as well. Why invent a 
> > > > > second on demand module loader when we have kmod? The current approach 
> > > > > feels like a step back to something very similar to the old kerneld.
> > > > 
> > > > kmod is not used at all if you are running udev on your system.
> > > 
> > > Since when does udev load modules for you?
> > 
> > It does not.  That was my point :)
> 
> Sorry, but I still don't get your point. Whether kmod is used or not is 
> unrelated to the use of udev.

I was trying to point out that if you use udev, kmod is not used at all
to autoload modules when you try to open a device file for a driver that
is not present (as if the module isn't loaded, then the device file
would not be present to try to open.)

But I forgot about the filesystem stuff...

Hope this clears things up.

greg k-h
