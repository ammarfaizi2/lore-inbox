Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVBSXDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVBSXDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 18:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVBSXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 18:03:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:11435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262223AbVBSXDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 18:03:42 -0500
Date: Sat, 19 Feb 2005 15:03:26 -0800
From: Greg KH <greg@kroah.com>
To: Michal Januszewski <spock@gentoo.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050219230326.GB13135@kroah.com>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219011433.GA5954@spock.one.pl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 02:14:34AM +0100, Michal Januszewski wrote:
> On Fri, Feb 18, 2005 at 05:52:54PM +0100, Pavel Machek wrote:
> 
> Hi,
> 
> > Just in case someone is interested, this is bootsplash for 2.6.11-rc4,
> > taken from suse kernel. I'll probably try to modify it to work with
> > radeonfb.
> > 
> > Any ideas why bootsplash needs to hack into vesafb? It only uses
> > vesafb_ops to test against them before some kind of free...
> 
> It doesn't really need vesafb for anything. Back in the days of 2.6.7 
> I used to release a version of bootsplash that had the dep. on vesafb 
> removed. It worked fine with at least some other fb drivers.
> 
> You might also want to save yourself some work and try out an
> alternative solution called fbsplash [1], which I designed after I got 
> tired of fixing bootsplash and which I actively maintain. Fbsplash 
> provides virtually the same functionality, and it has as much code as 
> possible moved into userspace (no more JPEG decoders in the kernel).
> 
> [1] http://dev.gentoo.org/~spock/projects/gensplash/current/

Pavel, I agree with Michal, take a look at this version of the code
instead of the version that you posted.  It's a _whole_ lot more sane,
and possibly even mergable.

Michal, any thoughts on submitting it for inclusion?  It seems pretty
stable now.

thanks,

greg k-h
