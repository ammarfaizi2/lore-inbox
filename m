Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWCRVHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWCRVHt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 16:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWCRVHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 16:07:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751002AbWCRVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 16:07:48 -0500
Date: Sat, 18 Mar 2006 13:04:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Message-Id: <20060318130446.18f4ae40.akpm@osdl.org>
In-Reply-To: <1142713820.17279.140.camel@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142830.607556000@localhost.localdomain>
	<20060318120728.63cbad54.akpm@osdl.org>
	<9a8748490603181223i32391d96nf794e93aa734f785@mail.gmail.com>
	<1142713820.17279.140.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, 2006-03-18 at 21:23 +0100, Jesper Juhl wrote:
> 
>  > Wouldn't this only break existing applications that do incorrect
>  > things (passing invalid values) ?
>  > If that's the case I'd say breaking them is OK and we should change to
>  > follow the spec.
>  > 
>  > I don't like potential userspace breakage any more than the next guy,
>  > but if the breakage only affects buggy applications then I think it's
>  > more acceptable.
> 
>  Yes, it only breaks buggy applications.

But we live in the real world.  There could be four-year-old applications
which passed all their Linux QA and which work perfectly well.

Then the kernel guys make some correctness change and that application
totally fails on new kernels.  Your choice is a) don't use new kernels or
b) hold off the new kernel until your provider (if the company or internal
group still exists) has put out a new version of the application and then
you wear the (considerable) cost of upgrading what was a perfectly-running
application.

And whose fault was it?  Ours.  Because older kernels had the wrong
checking (thus causing that app's QA to pass) and because later kernels
changed the rules.
