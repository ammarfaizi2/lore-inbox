Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVCVAoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVCVAoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVCVAn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:43:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:32906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262231AbVCVAnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:43:23 -0500
Date: Mon, 21 Mar 2005 16:43:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: jonsmirl@gmail.com, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: current linus bk, error mounting root
Message-Id: <20050321164318.04a5dc82.akpm@osdl.org>
In-Reply-To: <20050322003807.GA10180@kroah.com>
References: <9e47339105030909031486744f@mail.gmail.com>
	<20050321154131.30616ed0.akpm@osdl.org>
	<9e473391050321155735fc506d@mail.gmail.com>
	<20050321161925.76c37a7f.akpm@osdl.org>
	<20050322003807.GA10180@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > I don't agree that this is a userspace issue.  It's just not sane for a
> > driver to be in an unusable state for an arbitrary length of time after
> > modprobe returns.
> 
> It is a userspace issue.  If you have a static /dev there are no
> problems, right?  If you use udev, you need to wait for the device node
> to show up, it will not be there right after modprobe returns.

OK, that's different.

(grumble, mutter)

It would be very convenient, tidy and sane if we _could_ arrange for
modprobe to block until the device node appears though.  I think devfs can
do that ;)

