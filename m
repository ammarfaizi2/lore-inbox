Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267817AbUHERMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267817AbUHERMr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUHERJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:09:25 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:55643 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267814AbUHERFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:05:44 -0400
Message-ID: <944a03770408051005614aa25e@mail.gmail.com>
Date: Thu, 5 Aug 2004 13:05:39 -0400
From: Michael Guterl <mguterl@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Cc: linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?ISO-8859-1?Q?=20Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
In-Reply-To: <200408050834.27452.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408022100.54850.ktech@wanadoo.es> <200408041820.50199.david-b@pacbell.net> <944a037704080420574bb181f8@mail.gmail.com> <200408050834.27452.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply David, but where exactly does this leave me and
the others experiencing this problem?  Is there any more information I
can provide that might help?  Any possible solutions, patches, etc?

On Thu, 5 Aug 2004 08:34:27 -0700, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 04 August 2004 20:57, Michael Guterl wrote:
> 
> > Attached are my dmesg's from each kernel, each time I booted fully,
> > then plugged the USB keyboard in, and then the USB mouse.  My kernel
> > config is also attached, along with the output of lspci -v, (David
> > Brownell mentioned "lspci -w" but this isn't a valid option, and I
> 
> Actually that was "-vv" (two v's, not double-v), but don't bother.
> 
> The dmesg output shows this is a HID failure.  It's likely connected
> with some changes in the unlink logic, since that's what returns
> the "-ENOENT" status.  The usb_kill_urb() changes added a new
> URB state as I recall, maybe that's part of the issue here... since
> that routine replaced the previous "synchronous unlink" logic.
> 
> - Dave
> 
>
