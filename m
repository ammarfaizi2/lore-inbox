Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271148AbTHLVgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271156AbTHLVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:36:37 -0400
Received: from mail.kroah.org ([65.200.24.183]:3023 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271148AbTHLVgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:36:31 -0400
Date: Tue, 12 Aug 2003 14:36:46 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Woods <kazrak+kernel@cesmail.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] oops in sd_shutdown
Message-ID: <20030812213646.GB2158@kroah.com>
References: <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail> <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <Pine.LNX.4.53.0308111426570.16008@thevillage.soulcatcher> <20030812002844.B1353@pclin040.win.tue.nl> <5.2.1.1.0.20030811180413.01a67dc0@no.incoming.mail> <5.2.1.1.0.20030811233014.02900008@no.incoming.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.0.20030811233014.02900008@no.incoming.mail>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:35:26PM -0700, Jeff Woods wrote:
> At +0200 04:49 AM 8/12/2003, Andries Brouwer wrote:
> >On Mon, Aug 11, 2003 at 06:13:50PM -0700, Jeff Woods wrote:
> >
> >>Looking only at the above code snippet, I'd suggest something more like:
> >
> >>+       if (!sdp ||
> >
> >This is not meaningful.
> 
> How is it not meaningful?  The next action in the expression is to 
> dereference the pointer and if it has a NULL value then I expect the 
> dereference to fail.  [But I am a complete newbie with respect to Linux 
> kernel and driver code so perhaps my understanding is in error.  If so, 
> please enlighten me.]

sdp can not be NULL in this case.  That is why it is not meaningful to
try to check for it.

thanks,

greg k-h
