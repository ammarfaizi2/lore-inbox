Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDRGvD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 02:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbTDRGvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 02:51:03 -0400
Received: from granite.he.net ([216.218.226.66]:8464 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262885AbTDRGvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 02:51:02 -0400
Date: Fri, 18 Apr 2003 00:05:14 -0700
From: Greg KH <greg@kroah.com>
To: Frode Isaksen <fisaksen@bewan.com>
Cc: linux-kernel@vger.kernel.org, weissg@vienna.at
Subject: Re: PATCH: usb-uhci: interrupt out with urb->interval 0
Message-ID: <20030418070514.GA2322@kroah.com>
References: <F628F73A-70AE-11D7-8F05-003065EF6010@bewan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F628F73A-70AE-11D7-8F05-003065EF6010@bewan.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 10:31:18AM +0200, Frode Isaksen wrote:
> A recent change (2.4.21)

Um, 2.4.21 is not out yet :)

> in the usb-uhci driver calls 
> "uhci_clean_iso_step2" after the completion of one-shot (urb->interval 
> 0) interrupt out transfers. This call clears the list of descriptors. 
> However, it crashes when trying to get the next desciptor in the "for" 
> loop in the "process_interrupt" function, since the list of descriptors 
> are already cleared. A simple change I did was to do a "break" to quit 
> the "for" loop for interrupt out transfers with urb->interval 0.

Hm, I thought someone tested this previously.  Do you have a test case
for this that I can try to duplicate the problem for?

Also, your patch will not apply against the latest (2.4.21-pre7) version
of this file.

thanks,

greg k-h

p.s. I'd recommend sending these kinds of patches to the linux-usb-devel
mailing list too.  That's where most of the Linux USB developers are.
