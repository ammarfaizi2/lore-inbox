Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUBIC6G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUBIC5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:57:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:49083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264916AbUBIC5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:57:48 -0500
Date: Sun, 8 Feb 2004 18:57:12 -0800
From: Greg KH <greg@kroah.com>
To: Fab Tillier <ftillier@infiniconsys.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040209025712.GA22737@kroah.com>
References: <20040208162946.GA2531@kroah.com> <08628CA53C6CBA4ABAFB9E808A5214CB017C1A11@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A11@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 08:51:22AM -0800, Fab Tillier wrote:
> > On Sun, Feb 08, 2004 at 12:31:56AM -0800, Fab Tillier wrote:
> > >
> > > I think there is value in allowing the code to be shared between
> > > kernel mode and user mode.  Would using a macro that resolve to the
> > > native kernel spin lock structure and functions be acceptable?
> > 
> > Probably not, just use the in-kernel call, and be done with it.  If you
> > _really_ want to share code between userspace and the kernel, keep a
> > different version of it somewhere else.
> 
> Are you suggesting branching the user mode code from the kernel mode code?
> Duplication is not the same as sharing code - you have twice the number of
> places that require fixing in the event of a bug.  If we can help it, we'd
> like to avoid this.

Do you honestly think that if your code ever makes it into the main
kernel tree, you would be able somehow to extact that and use it from
userspace properly?

No, just don't do this.

Remember, if you _can_ do this from userspace, then your code doesn't
need to be in the kernel at all :)

Oh, and I repeat, let's see some code.  No more bickering about "what
ifs" anymore.

greg k-h
