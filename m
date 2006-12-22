Return-Path: <linux-kernel-owner+w=401wt.eu-S1753083AbWLWJh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbWLWJh4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 04:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbWLWJhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 04:37:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1160 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752978AbWLWJhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 04:37:20 -0500
Date: Fri, 22 Dec 2006 20:47:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to PM layer break userspace
Message-ID: <20061222204701.GC3960@ucw.cz>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191322.13378.david-b@pacbell.net> <20061219225729.GA15777@srcf.ucam.org> <200612191536.28998.david-b@pacbell.net> <20061220000955.GA17231@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061220000955.GA17231@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > That's a workable approach to resolving the underlying problem in the
> > long term.  In the short term, notice the system still works correctly
> > if you don't try writing those files.
> 
> Well, except I'm now burning an extra couple of watts of power. I 
> consider that pretty broken.

Couple of watts is not that bad, considering usb still eats 4W more
than it should.

> > I'd not be keen on reverting Linus' patch [1] myself, even though few
> > drivers have started to use that mechanism yet; that would be a step
> > backwards, and would perpetuate users of that broken sysfs file.
> 
> I'm sorry, which bit of "Don't break userspace API without adequate 
> prior warning and with a workable replacement" is difficult to 
> understand?

It should not break any userspace... but you do not get the power
savings any more. Sorry. This kind of powersaving is not available on
recent kernels.


Right fix is to extend wifi stack... and have ifconfig wlan0
powerdown, or something like that.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
