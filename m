Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752142AbWAELIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbWAELIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWAELIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:08:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752142AbWAELIk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:08:40 -0500
Date: Thu, 5 Jan 2006 03:08:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Debug shared irqs.
Message-Id: <20060105030824.20c70359.akpm@osdl.org>
In-Reply-To: <1136457598.4158.175.camel@pmac.infradead.org>
References: <1135251766.3557.13.camel@pmac.infradead.org>
	<20060105021929.498f45ef.akpm@osdl.org>
	<1136457598.4158.175.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2006-01-05 at 02:19 -0800, Andrew Morton wrote:
> > This is going to cause me a ton of grief.  How's about you put it in
> > Fedora for a few weeks, get all the drivers debugged first ;)
> 
> I'd do that normally, but it's the wrong point in the cycle -- we're
> getting ready for Fedora Core 5 at the moment; it's not the time to be
> doing such things. We can apply the patch... but we'd have to turn the
> config option off :)
> 
> What you're seeing is the whole point of the patch, surely? And it _is_
> a config option -- people aren't forced to turn it on.

Sure.  I was just regretting being the sucker again.

> Would it help if we added a printk to make it more obvious what's
> happening, which gives the naïve user the opportunity to turn off the
> config option just to get things working again? Somethign along the
> lines of "Faking irq %d due to CONFIG_DEBUG_SHIRQ. If your machine
> crashes now, don't blame akpm"?

Nah, that's all right.  I'm skilled at sending maintainers new bug reports
to ignore.

> Out of interest, does your i810 patch fix the problem which was reported
> in November by Eyal Lebedinsky ("2.6.14.2: repeated oops in i810 init")?

Looks like it.  I was oopsing at 0x00000030 too, although on x86_64, not x86.

