Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbTGJDjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268912AbTGJDjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:39:45 -0400
Received: from storm.he.net ([64.71.150.66]:44469 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S268911AbTGJDjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:39:44 -0400
Date: Wed, 9 Jul 2003 20:54:20 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC:  what's in a stable series?
Message-ID: <20030710035419.GB32507@kroah.com>
References: <3F0CBC08.1060201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0CBC08.1060201@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 09:06:16PM -0400, Jeff Garzik wrote:
> 
> Does it mean, no API changes except for security (or similarly severe) bugs?

Do that, and we will stagnate.

> Does it mean, no userland ABI changes, but API changes affecting onto 
> the kernel are ok?

That sounds acceptable to me.

But maybe I'm just biased, as I'm looking to start backporting some of
the USB 2.5 changes to 2.4 to fix real bugs that are in 2.4.  This will
require changing kernel apis.  And in doing so, fixing up all of the
in-kernel usages of that api will happen.

In doing this, it just enforces the fact that it really matters if you
have a in-kernel driver or not.  If you want to keep a driver or any
other kernel code outside of the main tree, it is costly, both in time
and effort.

My .02

greg k-h
