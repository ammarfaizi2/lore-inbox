Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUFNW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUFNW7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFNW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:59:06 -0400
Received: from [66.35.79.110] ([66.35.79.110]:30624 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S264569AbUFNW7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:59:04 -0400
Date: Mon, 14 Jun 2004 15:54:38 -0700
From: Tim Hockin <thockin@hockin.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Oliver Neukum <oliver@neukum.org>,
       Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: upcalls from kernel code to user space daemons
Message-ID: <20040614225438.GA22161@hockin.org>
References: <1087250925.8828.3.camel@gimli.at.home> <40CE2538.4060603@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CE2538.4060603@nortelnetworks.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 06:22:48PM -0400, Chris Friesen wrote:
> > > Not quite.  The userspace is passing data down as well.  I don't know 
> >how you'd
> > > do that with read().
> >
> >For this you use write().

> Although I have to admit it's not pretty, and the performance improvements 
> may not be worth the obfuscation of the code.

You know, I've never understood why people hate ioctl.  Sometimes, it
really is what you want.  Why impose structured data onto a 2-way
unstructred system (read/write) when you have a structured system at hand
(ioctl).

I like ioctl() when it makes sense.  read() and write() are for data.
ioctl is for (tada!) control.
