Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVCHEsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVCHEsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVCHEst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:48:49 -0500
Received: from peabody.ximian.com ([130.57.169.10]:10135 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261448AbVCHEsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:48:00 -0500
Subject: Re: [patch] inotify for 2.6.11-mm1, updated
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, John McCutchan <ttb@tentacle.dhs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050308044009.GA352@infradead.org>
References: <1109961444.10313.13.camel@betsy.boston.ximian.com>
	 <1109963494.10313.32.camel@betsy.boston.ximian.com>
	 <20050307011939.GA7764@infradead.org>
	 <1110230878.3973.40.camel@betsy.boston.ximian.com>
	 <20050308044009.GA352@infradead.org>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 23:50:36 -0500
Message-Id: <1110257436.12936.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 04:40 +0000, Christoph Hellwig wrote:

> Why do you need the classdevice?  I'm really not too eager about adding
> tons of new misdevices now that we can route directly to individual majors
> with cdev_add & stuff.  Especially when you're actually relying on class
> device you should have your own one instead of relying on an onsolete
> layer.

We have sysfs knobs and /sys/class/misc/inotify makes sense.

> Actually, you fixed that in read_write.c, just compat.c is still missing.
> Looks like you forget to fix that one and didn't have a chance to compile-test
> the 32bit compat layer?

Yah, I just missed it.  It is fixed in my tree.

Thanks,

	Robert Love


