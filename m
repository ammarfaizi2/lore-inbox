Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUCOGIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 01:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbUCOGIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 01:08:36 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:29018 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261461AbUCOGIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 01:08:34 -0500
Date: Mon, 15 Mar 2004 07:08:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm2
Message-ID: <20040315060856.GA2058@mars.ravnborg.org>
Mail-Followup-To: Joshua Kwan <joshk@triplehelix.org>,
	linux-kernel@vger.kernel.org
References: <20040314172809.31bd72f7.akpm@osdl.org> <pan.2004.03.15.01.57.18.661707@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.03.15.01.57.18.661707@triplehelix.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 05:57:21PM -0800, Joshua Kwan wrote:
> On Sun, 14 Mar 2004 17:28:09 -0800, Andrew Morton wrote:
> > +kbuild-fix-early-dependencies.patch
> > +kbuild-fix-early-dependencies-fix.patch
> > 
> >  Parallel build fix
> 
> This set of patches requires the following fix to successfully link the
> kernel:
> 
> --- linux/Makefile~   2004-03-14 17:52:54.000000000 -0800
> +++ linux/Makefile    2004-03-14 17:52:21.000000000 -0800
> @@ -988,7 +988,7 @@
>         @set -e; \
>         $(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
>         $(cmd_$(1)); \
> -       scripts/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
> +       scripts/basic/fixdep $(depfile) $@ '$(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).tmp; \
>         rm -f $(depfile); \
>         mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)

Thanks, my bad.
Also I broke docbook. Next time I better delete the binaries in scripts
before testing :-(
Updated patch will follow tonight.

	Sam
