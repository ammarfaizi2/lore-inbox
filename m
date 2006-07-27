Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWG0XuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWG0XuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWG0XuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:50:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57543 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750755AbWG0XuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:50:09 -0400
Date: Thu, 27 Jul 2006 16:49:51 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       mtosatti@redhat.com, zaitcev@redhat.com
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Message-Id: <20060727164951.ada33ed5.zaitcev@redhat.com>
In-Reply-To: <200607271521.38217.benjamin.cherian.kernel@gmail.com>
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com>
	<200607201044.00739.benjamin.cherian.kernel@gmail.com>
	<20060724230732.4fdf2bf4.zaitcev@redhat.com>
	<200607271521.38217.benjamin.cherian.kernel@gmail.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006 15:21:37 -0700, Benjamin Cherian <benjamin.cherian.kernel@gmail.com> wrote:

> On Monday 24 July 2006 23:07, Pete Zaitcev wrote:
> > Anyway, please test the attached patch. Does it do what you want?
> 
> Sorry to say that it doesnt. When calling usb_get_string_simple in libusb,
> the program segfaults with the patched kernel. I believe that 
> usb_get_string_simple eventually calls usbdev_ioctl.

Thanks for testing, I'll look into it.

By the way, you didn't tell me if you tried to use alarm(2) across
submitted URBs. This is the technique ADSL modem drivers use. They
also have to have input and output streams running simultaneously.

-- Pete
