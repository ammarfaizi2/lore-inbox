Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVKHR6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVKHR6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKHR6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:58:39 -0500
Received: from waste.org ([216.27.176.166]:8373 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030192AbVKHR6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:58:38 -0500
Date: Tue, 8 Nov 2005 09:58:00 -0800
From: Matt Mackall <mpm@selenic.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: jonathan@jonmasters.org, Rob Landley <rob@landley.net>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: What's wrong with tmpfs?
Message-ID: <20051108175800.GB8126@waste.org>
References: <200510300624.38794.rob@landley.net> <35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com> <20051030151506.GA3354@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030151506.GA3354@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 10:15:06AM -0500, Jeff Dike wrote:
> On Sun, Oct 30, 2005 at 12:53:00PM +0000, Jon Masters wrote:
> > On 10/30/05, Rob Landley <rob@landley.net> wrote:
> > 
> > > If somebody needs a reproduction sequence, I'm happy to oblige.  In theory
> > > "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_ simple it
> > > wouldn't have shipped...
> > 
> > I don't see this behaviour on a regular desktop box running 2.6.14.
> > Guess it's UML specific.
> 
> Sorry, but wrong.
> 
> IIRC, this triggers when you don't have CONFIG_TMPFS enabled.  If you don't,
> you still get it, but you get a version that's only usable in-kernel.

That sounds like a regression. Turning off CONFIG_TMPFS replaces tmpfs
with an aliased ramfs. It should be perfectly usable everywhere that
tmpfs is, with the exception that it's not swap-backed and doesn't
have an size limiting.

-- 
Mathematics is the supreme nostalgia of our time.
