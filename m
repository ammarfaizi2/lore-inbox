Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVGKQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVGKQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVGKP7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:59:22 -0400
Received: from peabody.ximian.com ([130.57.169.10]:18664 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262134AbVGKP5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:57:13 -0400
Subject: Re: [RFC/PATCH 1/2] fsnotify
From: Robert Love <rml@novell.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Wright <chrisw@osdl.org>, ttb@tentacle.dhs.org,
       linux-audit@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1121086366.27264.108.camel@hades.cambridge.redhat.com>
References: <20050709012436.GD19052@shell0.pdx.osdl.net>
	 <20050709012657.GE19052@shell0.pdx.osdl.net>
	 <1121086366.27264.108.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Mon, 11 Jul 2005 11:57:09 -0400
Message-Id: <1121097429.6596.49.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 13:52 +0100, David Woodhouse wrote:

> To be honest, I don't really see that this is in any way better than
> what we had before. Yes, two different pieces of code actually use hooks
> in similar places in the VFS code. But this 'infrastructure' just to
> share those hooks is overkill as far as I can tell. It really isn't any
> better than having both inotify and audit hooks side by side where we
> can actually see what's going on at a glance. In fact, it's worse.

I think what makes this patch look superfluous is that Chris added a set
of wrappers for dnotify, too.

In the inotify patch, the fsnotify wrappers call directly into the
inotify and dnotify interfaces and they do consolidate code and clean
things up.  I added fsnotify at hch's request.

Now that audit is coming along, fsnotify makes even more sense.

I would like to share some more code at a lower level, though, as you
pointed out.

I planned to look at redoing dnotify entirely on top of inotify, once
inotify is in the kernel proper, for example.

	Robert Love


