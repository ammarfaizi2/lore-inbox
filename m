Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757488AbWKWXXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757488AbWKWXXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 18:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757485AbWKWXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 18:23:03 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:57293 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1757482AbWKWXXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 18:23:01 -0500
Date: Fri, 24 Nov 2006 00:21:44 +0100
From: Chris Friedhoff <chris@friedhoff.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Friedhoff <chris@friedhoff.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: security: introduce file caps
Message-Id: <20061124002144.18231ae9.chris@friedhoff.org>
In-Reply-To: <20061123214159.GA23800@sergelap.austin.ibm.com>
References: <20061114030655.GB31893@sergelap>
	<20061123001458.fe73f64a.akpm@osdl.org>
	<20061123002207.5e18bade.akpm@osdl.org>
	<20061123131203.f7b6972f.chris@friedhoff.org>
	<20061123103920.8d908952.akpm@osdl.org>
	<20061123214159.GA23800@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm this behavior, but only in the interaction of xinit and X.
ping and ntpdate behave with a patched kernel but
CONFIG_SECURITY_FS_CAPABILITIES=n like expected, even with empty or
wrong capabilities. Tested with 2.6.18.3 kernel

Chris



 On Thu, 23 Nov 2006 15:41:59 -0600
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Andrew Morton (akpm@osdl.org):
> > On Thu, 23 Nov 2006 13:12:03 +0100
> > Chris Friedhoff <chris@friedhoff.org> wrote:
> > 
> > > xinit respects capabilities (at least i guess), so when the system has
> > > capability-support, the binary /usr/X11R6/bin/xinit neeeds the
> > > capability cap_kill even when no capability extended attribute exists
> > > for this binary.
> > >
> > > setfcaps cap_kill=ep /usr/X11R6/bin/xinit
> > >
> > > I documented this here:
> > > http://www.friedhoff.org/fscaps.html#Xorg,%20xinit,%20xfce,%20kde
> > >
> > > and for more:
> > > http://www.friedhoff.org/fscaps.html
> > >
> > 
> > Even when CONFIG_SECURITY_FS_CAPABILITIES=n?
> 
> No, the patch shouldn't change behavior when
> CONFIG_SECURITY_FS_CAPABILITIES=n, though of course I see why it did.  I
> will send a fixed patch tomorrow or this weekend.
> 
> sorry,
> -serge


--------------------
Chris Friedhoff
chris@friedhoff.org
