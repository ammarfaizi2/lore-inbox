Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUBDCEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 21:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266276AbUBDCEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 21:04:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266274AbUBDCE0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 21:04:26 -0500
Date: Wed, 4 Feb 2004 02:04:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools/udev and module auto-loading
Message-ID: <20040204020425.GA21151@parcelfarce.linux.theplanet.co.uk>
References: <1075830486.7473.32.camel@nosferatu.lan> <20040204014222.46AF02C29B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040204014222.46AF02C29B@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 12:22:31PM +1100, Rusty Russell wrote:
> In message <1075830486.7473.32.camel@nosferatu.lan> you write:
> > > I think it's an excellent idea, although ideally we would have this
> > > mechanism in userspace as much as possible.  Anything from some
> > > special hack to block -ENOENT on directory lookups and notify an fd,
> > > to some exotic overlay filesystem.
> > 
> > Something like attached.  Besides me not knowing if there is a better
> > place for it, it have the following issues:
> 
> Dude, you're brave.  I mean, really, really brave.
> 
> However, it strikes me that the automounter does similar tricks, and
> so a similar setup should be possible for /dev.
> 
> Al?  Suggestions appreciated?

<shrug> If you want to mount autofs on /dev, more power to you.  However,
it got to be explicit "I mount <this> at /dev" - _anything_ based on
"if pathname starts with /dev, it's special" is FUBAR.
