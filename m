Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVA0AfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVA0AfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVA0AXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:23:15 -0500
Received: from peabody.ximian.com ([130.57.169.10]:38378 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261632AbVAZXX2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:23:28 -0500
Subject: Re: [ANNOUNCE] inotify 0.18
From: Robert Love <rml@novell.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <41F6BA4B.2000303@sun.com>
References: <1106682112.23615.3.camel@vertex>
	 <20050125200100.GC8859@parcelfarce.linux.theplanet.co.uk>
	 <41F6BA4B.2000303@sun.com>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 18:18:32 -0500
Message-Id: <1106781512.7087.144.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 16:29 -0500, Mike Waychison wrote:

> How about inotify hold on to the nameidata until it is sure to have
> updated the watches?  That way, the inode will be seen by
> inotify_super_block_umount when called by generic_shutdown_super.

I was chatting with John as soon as Al pointed out the problem and
suggested we look at something like this.  I am glad you were able to
crank it out so readily.  Thank you!

Barring a more elegant solution, I think just holding nameidata down
until the watches are added is the way to go.  We will test this and
then merge it into the next patch.

Thanks,

	Robert Love


