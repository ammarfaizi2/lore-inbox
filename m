Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267408AbUIOUhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267408AbUIOUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUIOUfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:35:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:25027 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267360AbUIOUed
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:34:33 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Robert Love <rml@novell.com>
To: Tim Hockin <thockin@hockin.org>
Cc: Greg KH <greg@kroah.com>, Kay Sievers <kay.sievers@vrfy.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040915203133.GA18812@hockin.org>
References: <1094875775.10625.5.camel@lucy>
	 <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org>
	 <20040915000753.GA24125@kroah.com> <1095211167.20763.2.camel@localhost>
	 <20040915034455.GB30747@kroah.com> <20040915194018.GC24131@kroah.com>
	 <1095279043.23385.102.camel@betsy.boston.ximian.com>
	 <20040915202234.GA18242@hockin.org>
	 <1095279985.23385.104.camel@betsy.boston.ximian.com>
	 <20040915203133.GA18812@hockin.org>
Content-Type: text/plain
Date: Wed, 15 Sep 2004 16:33:34 -0400
Message-Id: <1095280414.23385.108.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 13:31 -0700, Tim Hockin wrote:

> > A mount event should really just cause a rescan of the mount table.
> 
> In which namespace?  All of them?  Is that an information leak that might
> be hazardous (I'm bad with security stuff).

You can only see your own namespace.  So e.g. /proc/mtab is your name
space's mount table and you can rescan that when receiving the mount
signal.

That is sort of the coolness of this approach - push the payload out to
user-space, and we don't have to worry about things like information
leak, name spaces, security, etc.  We are just providing a notify
mechanism for state information that should already be exposed through
sysfs.

So there is no information leak.

	Robert Love


