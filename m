Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWDVTR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWDVTR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWDVTQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:16:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54796 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750966AbWDVTQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:16:21 -0400
Date: Thu, 20 Apr 2006 21:13:09 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Crispin Cowan <crispin@novell.com>
Cc: Valdis.Kletnieks@vt.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060420211308.GB2360@ucw.cz>
References: <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4445484F.1050006@novell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue 18-04-06 13:13:03, Crispin Cowan wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > If we heave the LSM stuff overboard, there's one thing that *will* need
> > addressing - what to do with kernel support of Posix-y capabilities.  Currently
> > some of the heavy lifting is done by security/commoncap.c.
> >
> > Frankly, that's *another* thing that we need to either *fix* so it works right,
> > or rip out of the kernel entirely.  As far as I know, there's no in-tree way
> > to make /usr/bin/ping be set-CAP_NET_RAW and have it DTRT.
> >   
> This has actually been one of the interesting developments in AppArmor.
> I also had no use for POSIX.1e capabilities; I thought they were so
> awkward as to be useless. That is, until we integrated capabilities into
> AppArmor profiles.
> 
> Consider this profile for /bin/stty
> /bin/stty {
>   #include <abstractions/base>
> 
>   capability sys_tty_config,
> 
>   /bin/stty r,
> }
> 
> This policy basically allows stty to run, read its own text file, and
> use the capability sys_tty_config. Even though it may run as root, this
> profile confines it to *only* have sys_tty_config.


What happens if I ln /bin/stty /tmp/evilstty, then exploit
vulnerability in stty? 
							Pavel
-- 
Thanks, Sharp!
