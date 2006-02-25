Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbWBYSFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbWBYSFs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWBYSFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:05:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:45515
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932682AbWBYSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:05:46 -0500
Date: Sat, 25 Feb 2006 10:05:36 -0800
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Greg K-H <gregkh@suse.de>
Subject: Re: usbfs2 panic [Was: 2.6.16-rc4-mm2]
Message-ID: <20060225180536.GA6741@kroah.com>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <E1FCzkA-0005fe-00@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FCzkA-0005fe-00@decibel.fi.muni.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 02:45:54PM +0100, Jiri Slaby wrote:
> Andrew Morton wrote:
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm2/
> [...]
> Hello,
> 
> I catched this oops through booting due to Greg's inode usbfs2 patch.
> Here is camera-snapshot of the screen:
> http://www.fi.muni.cz/~xslaby/sklad/panic.gif
> Config:
> http://www.fi.muni.cz/~xslaby/sklad/config-desk

Thanks.  For now just disable usbfs2, or make it a module and don't load
it.  It is _very_ raw and as you see, doesn't work properly.  And, in
working on it some more, usbfs2 is not even going to be a file system,
but instead just rely on device nodes, like usbfs does today.  That will
allow us to proper set ACLs and not force distros to have to mount
yet-another-filesytem.

thanks,

greg k-h
