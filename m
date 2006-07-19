Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWGSBdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWGSBdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGSBdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:33:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5609 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932451AbWGSBdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:33:45 -0400
Date: Tue, 18 Jul 2006 18:33:13 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devl@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-Id: <20060718183313.e8e5a5b2.zaitcev@redhat.com>
In-Reply-To: <200607181004.55191.benjamin.cherian.kernel@gmail.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
	<200607171435.22128.benjamin.cherian.kernel@gmail.com>
	<20060717151940.5cd79087.zaitcev@redhat.com>
	<200607181004.55191.benjamin.cherian.kernel@gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 10:04:54 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:

> > Another option would be to change USBDEVFS_BULK to USBDEVFS_SUBMITURB.
> > Did you look at doing that?

> We did that as well. But when you try to reap an URB there is no timeout. So 
> if something goes wrong you're stuck waiting for the operation to finish or 
> for the user to physically unplug the device.

This can't be right. Surely alarm(2) should work?

> >Of course it's very tempting for me to off-load both
> >the work and the responsibility on you.
> 
> All right then. I'll send you a patch that backports the string caching 
> mechanism from 2.6 in a few days. Would you be able to test it with the 
> 210PU?

Yes, that would be fine.

Although I am starting to think about creating a custom locking
scheme in devio.c after all. It seems like less work.

-- Pete
