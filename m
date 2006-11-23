Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934041AbWKWVmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbWKWVmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933956AbWKWVmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:42:10 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:29100 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933542AbWKWVmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:42:08 -0500
Date: Thu, 23 Nov 2006 15:41:59 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Friedhoff <chris@friedhoff.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: security: introduce file caps
Message-ID: <20061123214159.GA23800@sergelap.austin.ibm.com>
References: <20061114030655.GB31893@sergelap> <20061123001458.fe73f64a.akpm@osdl.org> <20061123002207.5e18bade.akpm@osdl.org> <20061123131203.f7b6972f.chris@friedhoff.org> <20061123103920.8d908952.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123103920.8d908952.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> On Thu, 23 Nov 2006 13:12:03 +0100
> Chris Friedhoff <chris@friedhoff.org> wrote:
> 
> > xinit respects capabilities (at least i guess), so when the system has
> > capability-support, the binary /usr/X11R6/bin/xinit neeeds the
> > capability cap_kill even when no capability extended attribute exists
> > for this binary.
> >
> > setfcaps cap_kill=ep /usr/X11R6/bin/xinit
> >
> > I documented this here:
> > http://www.friedhoff.org/fscaps.html#Xorg,%20xinit,%20xfce,%20kde
> >
> > and for more:
> > http://www.friedhoff.org/fscaps.html
> >
> 
> Even when CONFIG_SECURITY_FS_CAPABILITIES=n?

No, the patch shouldn't change behavior when
CONFIG_SECURITY_FS_CAPABILITIES=n, though of course I see why it did.  I
will send a fixed patch tomorrow or this weekend.

sorry,
-serge
