Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUEQWwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUEQWwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUEQWwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:52:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:35770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262954AbUEQWwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:52:44 -0400
Date: Mon, 17 May 2004 15:55:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-Id: <20040517155503.3b0acaa5.akpm@osdl.org>
In-Reply-To: <20040517221320.GA20768@kroah.com>
References: <20040514175918.6b9f4c9d.akpm@osdl.org>
	<E1BOs7C-0003Bd-00@gondolin.me.apana.org.au>
	<20040514231620.0f653afd.akpm@osdl.org>
	<20040517221320.GA20768@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > Ho hum.  Greg, any preferences?  We can either:
> > 
> > a) Add a `restart' driver method and call that during reboot instead of
> >    ->shutdown, if the driver implements ->restart.  Otherwise call
> >    ->shutdown or
> > 
> > b) stick with the
> > 
> > 	if (system_state == SYSTEM_RESTART)
> > 		...
> > 
> >    thing in IDE and potentially a couple of other places?
> 
> I think we should stick with option b) for now, as we are already
> keeping this system state, right?

Yes, it's currently used in arch code which is otuside the driver model.

And the "current state of the entire system" maps comfortably onto a global
variable.
