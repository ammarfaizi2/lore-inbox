Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbTFSD4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 23:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTFSDzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 23:55:18 -0400
Received: from granite.he.net ([216.218.226.66]:13070 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265352AbTFSDyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 23:54:05 -0400
Date: Wed, 18 Jun 2003 17:51:51 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Oliver Neukum <oliver@neukum.org>, Robert Love <rml@tech9.net>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619005151.GA3411@kroah.com>
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com> <200306132201.47346.oliver@neukum.org> <20030618225913.GB2413@kroah.com> <3EF10002.7020308@cox.net> <20030619002039.GA2866@kroah.com> <3EF10705.9090609@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF10705.9090609@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 05:42:45PM -0700, Kevin P. Fleming wrote:
> Greg KH wrote:
> 
> >But you also have to "hold" events for a bit of time in order to
> >determine that things are out of order, or we have a gap.  So a bit of
> >"complex" logic is in the works, but it's much less complex than if we
> >didn't have that sequence number.
> >
> 
> OK, so the important point here is that while you probably delay events 
> for a small amount of time (1-3 seconds maybe) to ensure that you aren't 
> processing steps out of order, it's not likely that userspace is going 
> hold event #1321 for an indefinite period of time just because it has 
> never seen event #1320.

Exactly.

> I can't wait to see this implementation; it's going to be interesting, 
> to say the least. However, without the sequence numbers, it would very 
> likely be impossible.

Hey, I still think my originally proposed version would have worked,
eventually... :)

greg k-h
