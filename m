Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWGXSqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWGXSqO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWGXSqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:46:14 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:65492 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751346AbWGXSqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:46:13 -0400
Date: Mon, 24 Jul 2006 20:45:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <a.gruenbacher@computer.org>
Cc: Nathan Scott <nathans@sgi.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: include/linux/xattr.h: how much userpace visible?
Message-ID: <20060724184534.GA26842@mars.ravnborg.org>
References: <20060723184343.GA25367@stusta.de> <20060724085701.B2083275@wobbly.melbourne.sgi.com> <200607242031.11815.a.gruenbacher@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607242031.11815.a.gruenbacher@computer.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 08:31:11PM +0200, Andreas Gruenbacher wrote:
> On Monday, 24 July 2006 00:57, Nathan Scott wrote:
> > On Sun, Jul 23, 2006 at 08:43:43PM +0200, Adrian Bunk wrote:
> > > Hi,
> > >
> > > how much of include/linux/xattr.h has to be part of the userspace kernel
> > > headers?
> >
> > None, I think.
> 
> None, indeed. The attr package comes with it own version of xattr.h that also 
> includes definitions of XATTR_CREATE and XATTR_REPLACE.
The userspace headers are supposed to hold the part of the kernel
definitions that glibc (and mayby the attr package) uses. If they happen
to have their own copy now should not impct the decision what is part of
the userspace interface for the kernel. So actual usage does not decide
what is part of the userspace kernel headers but what definitionas are
definitions the userspace <-> kernel interface.

	Sam
