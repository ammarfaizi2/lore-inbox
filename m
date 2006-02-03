Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWBCACd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWBCACd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWBCACd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 19:02:33 -0500
Received: from xenotime.net ([66.160.160.81]:4794 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964777AbWBCACc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 19:02:32 -0500
Date: Thu, 2 Feb 2006 16:02:32 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extract-ikconfig: be sure binoffset exists before
 extracting
In-Reply-To: <20060203001838.GA18431@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.58.0602021601450.16695@shark.he.net>
References: <20060201125658.GB8943@mipter.zuzino.mipt.ru>
 <20060202153241.48b206fb.akpm@osdl.org> <20060203001838.GA18431@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Alexey Dobriyan wrote:

> On Thu, Feb 02, 2006 at 03:32:41PM -0800, Andrew Morton wrote:
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > --- a/scripts/extract-ikconfig
> > > +++ b/scripts/extract-ikconfig
> > > @@ -4,6 +4,7 @@
> > >  # $arg1 is [b]zImage filename
> > >
> > >  binoffset="./scripts/binoffset"
> > > +test -e $binoffset || cc -o $binoffset ./scripts/binoffset.c || exit 1
> > >
> >
> > OK, but it would be better if we could find a way of doing this within a
> > Makefile.
>
> AFAICS, it's a standalone script for CONFIG_IKCONFIG=y,
> CONFIG_IKCONFIG_PROC=n users.

or for reading the .config from any kernel image file (if it's there),
not limited to only the loaded kernel.

-- 
~Randy
