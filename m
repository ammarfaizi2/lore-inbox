Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEJWzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEJWzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUEJWx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:53:57 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:49812 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262961AbUEJWxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:53:00 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 15:52:58 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
In-Reply-To: <1084228900.28903.2.camel@vertex>
Message-ID: <Pine.LNX.4.58.0405101548230.1156@bigblue.dev.mdolabs.com>
References: <1084152941.22837.21.camel@vertex>  <20040510021141.GA10760@taniwha.stupidest.org>
  <1084227460.28663.8.camel@vertex>  <Pine.LNX.4.58.0405101521280.1156@bigblue.dev.mdolabs.com>
 <1084228900.28903.2.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, John McCutchan wrote:

> On Mon, 2004-05-10 at 18:31, Davide Libenzi wrote:
> > On Mon, 10 May 2004, John McCutchan wrote:
> > 
> > > > 3) dnotify cannot easily watch changes for a directory hierarchy
> > > 
> > > People don't seem to really care about this one. Alexander Larsson has
> > > said he doesn't care about it. It might be nice to add in the future.
> > 
> > Please excuse my ignorance, but who is Alexander Larsson? A dnotify 
> > replacement that does not have the ability to watch for a hierarchy is 
> > pretty much useless. Or do you want to drop thousands of single watches to 
> > accomplish that?
> 
> Alexander Larsson is the maintainer of nautilus, gnome-vfs and I think
> the dnotify patch for fam. He made a post to l-k a month or two ago
> about why he doesn't care about it. I do plan on adding this feature in
> the near future though.

GUIs have different requirements. They display a finite number of views on 
directories, so for them it is fine to not have hierarchy watching 
capabilities. A sane dnotify API should have the ability to watch hierarchies.
And it should not even be that much hard to do, since you can just 
backtrace the the point where the change happened to see if there are 
watchers on the parent directories.



- Davide

