Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWDRMWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWDRMWL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 08:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWDRMWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 08:22:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37002 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750872AbWDRMWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 08:22:09 -0400
Date: Tue, 18 Apr 2006 07:22:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060418122206.GC7562@sergelap.austin.ibm.com>
References: <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> On Mon, 17 Apr 2006 22:26:24 BST, Alan Cox said:
> 
> (Two replies to this paragraph, addressing 2 separate issues....)
> 
> > You can implement a BSD securelevel model in SELinux as far as I can see
> > from looking at it, and do it better than the code today, so its not
> > really a feature drop anyway just a migration away from some fossils
> 
> If we heave the LSM stuff overboard, there's one thing that *will* need
> addressing - what to do with kernel support of Posix-y capabilities.  Currently
> some of the heavy lifting is done by security/commoncap.c.
> 
> Frankly, that's *another* thing that we need to either *fix* so it works right,
> or rip out of the kernel entirely.  As far as I know, there's no in-tree way
> to make /usr/bin/ping be set-CAP_NET_RAW and have it DTRT.

Sigh...  it's such a cool idea, and yet such a dangerously easy thing to
get wrong, ie dropping the ability for a root process to drop it's root
privs.

If we were to drop posix caps, how would selinux change correspondingly?
Would it just drop the capability class altogether, perhaps beef up the
task or security class?  Just wondering whether anyone had thought about
this.

Alternatively, we could try yet again to get support for fs caps
upstream...

-serge
