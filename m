Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUIOVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUIOVka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267523AbUIOVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:40:21 -0400
Received: from peabody.ximian.com ([130.57.169.10]:1988 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267587AbUIOVjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:39:39 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915213419.GA21899@hockin.org>
References: <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
	 <1095280414.23385.108.camel@betsy.boston.ximian.com>
	 <20040915204754.GA19625@hockin.org>
	 <1095281358.23385.109.camel@betsy.boston.ximian.com>
	 <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com>
	 <1095283589.23385.117.camel@betsy.boston.ximian.com>
	 <20040915213419.GA21899@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 17:38:39 -0400
Message-Id: <1095284320.23385.123.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 14:34 -0700, Tim Hockin wrote:

> It's a can of worms, is what it is.  And I'm not sure what a good fix
> would be.  Would it just be enough to send a generic "mount-table changed"
> event, and let userspace figure out the rest?

"Can of worms" is a tough description for something that there is no
practical security issue for, just a lot of hand waving.  No one even
uses name spaces.

Anyhow, I already said that we could send out a generic kobject instead
of the one tied to the specific device.

> Or really, why is the kernel broadcasting a mount, which originated in
> userland.  Couldn't mount (or a mount wrapper) do that?  It's already
> running in the right namespace...

In practice stuff like that never works.  Besides, it is not mount(1)
that we want to wrap but the mount(2) system call.  And, uh, I'd rather
stab myself than try to get that patch by Uli.

	Robert Love


