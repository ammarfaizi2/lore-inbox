Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270731AbTGNTB7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270733AbTGNTB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:01:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:2985 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270731AbTGNTBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:01:55 -0400
Date: Mon, 14 Jul 2003 12:16:25 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Chris Wright <chris@wirex.com>,
       James Morris <jmorris@intercode.com.au>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add SELinux module to 2.6.0-test1
Message-ID: <20030714191625.GA24578@kroah.com>
References: <1058209504.13738.687.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058209504.13738.687.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 03:05:04PM -0400, Stephen Smalley wrote:
> The patch available from
> http://www.nsa.gov/selinux/lk/2.6.0-test1-addselinux.patch.gz adds the
> SELinux module under security/selinux and modifies the security/Makefile
> and security/Kconfig files for SELinux.

Some minor coding style nits:
	- you are creating your own typedefs, please don't.  Use the
	  "struct foo" style instead.
	- you have a number of printk() calls without a logging level.
	  Hm, looks like some of the functions doing this aren't ever
	  called at all (avc_dump_cache() is one example)...
	- your function style should be changed to take advantage of the
	  kerneldoc functionality.  avc_lookup() is a good example of
	  something that could benifit from this (don't put comments
	  within a function declaration...)

Other than that, the coding style looks real good.

thanks,

greg k-h
