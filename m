Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVASB0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVASB0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 20:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVASB0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 20:26:17 -0500
Received: from waste.org ([216.27.176.166]:42715 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261538AbVASB0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 20:26:13 -0500
Date: Tue, 18 Jan 2005 17:26:12 -0800
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: Implicit dependence on the C compiler
Message-ID: <20050119012612.GD3867@waste.org>
References: <cshbd7$nff$1@terminus.zytor.com> <20050117220052.GB18293@mars.ravnborg.org> <41EC363D.1090106@zytor.com> <20050118190513.GA16120@mars.ravnborg.org> <csjoef$gkt$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csjoef$gkt$1@terminus.zytor.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 07:35:43PM +0000, H. Peter Anvin wrote:
> Followup to:  <20050118190513.GA16120@mars.ravnborg.org>
> By author:    Sam Ravnborg <sam@ravnborg.org>
> In newsgroup: linux.dev.kernel
> > 
> > To give some background info about why kbuild does what it does.
> > A kernel being compiled partly with and partly without say -regparm=3
> > will result in a non-workable kernel.
> > 
> > The same goes for a kernel that is partly built using gcc 2.96, partly
> > using 3.3.4 for example.
> > 
> > So kbuild pr. default will force a recompile for any .o file where
> > opions to gcc differ, or name of gcc has changed. Today no check has
> > been implemented to check the actual gcc executable timestamp - and
> > neither is this planned.
> > 
> 
> I would argue that "name of gcc has changed" is possibly a condition
> that does more harm than good.  It is just as frequently used to have
> wrappers, like distcc, as it is to have different versions.

Disagree. I switch compilers all the time and kbuild does the right
thing for me.

I do occassionally feel your 'make install' pain and some sort of
'make __install' might be called for.

-- 
Mathematics is the supreme nostalgia of our time.
