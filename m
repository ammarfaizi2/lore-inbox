Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUBHQac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUBHQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:30:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:45245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263793AbUBHQab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:30:31 -0500
Date: Sun, 8 Feb 2004 08:29:46 -0800
From: Greg KH <greg@kroah.com>
To: Fab Tillier <ftillier@infiniconsys.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Message-ID: <20040208162946.GA2531@kroah.com>
References: <20040206185132.GG32116@kroah.com> <08628CA53C6CBA4ABAFB9E808A5214CB017C1A10@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB017C1A10@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 12:31:56AM -0800, Fab Tillier wrote:
> 
> I think there is value in allowing the code to be shared between
> kernel mode and user mode.  Would using a macro that resolve to the
> native kernel spin lock structure and functions be acceptable?

Probably not, just use the in-kernel call, and be done with it.  If you
_really_ want to share code between userspace and the kernel, keep a
different version of it somewhere else.

Why do you want to run your code in both places?  Does this mean that it
doesn't even really need to be in the kernel as it works just fine in
userspace?

thanks,

greg k-h
