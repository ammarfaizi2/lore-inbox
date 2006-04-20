Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWDUPVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWDUPVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWDUPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:21:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16658 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932351AbWDUPVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:21:16 -0400
Date: Thu, 20 Apr 2006 17:46:02 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060420174602.GA2360@ucw.cz>
References: <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> If we heave the LSM stuff overboard, there's one thing that *will* need
> addressing - what to do with kernel support of Posix-y capabilities.  Currently
> some of the heavy lifting is done by security/commoncap.c.
> 
> Frankly, that's *another* thing that we need to either *fix* so it works right,
> or rip out of the kernel entirely.  As far as I know, there's no in-tree way
> to make /usr/bin/ping be set-CAP_NET_RAW and have it DTRT.

Well, you can still have ping drop all but CAP_NET_RAW as a first
thing in main(), which is almost as good. And IIRC some apps actually
do that...

-- 
Thanks, Sharp!
