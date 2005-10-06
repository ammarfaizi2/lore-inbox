Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVJFP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVJFP75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVJFP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:59:57 -0400
Received: from xenotime.net ([66.160.160.81]:42129 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751122AbVJFP75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:59:57 -0400
Date: Thu, 6 Oct 2005 08:59:52 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Kalin KOZHUHAROV <kalin@thinrope.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ksymoops should no longer be used to
 decode Oops messages
In-Reply-To: <di3h5d$f82$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.58.0510060857300.4651@shark.he.net>
References: <200510052239.43492.jesper.juhl@gmail.com> <di3h5d$f82$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005, Kalin KOZHUHAROV wrote:

> Jesper Juhl wrote:
> > Document the fact that ksymoops should no longer be used to decode Oops
> > messages.
> >
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > ---
> >
> >  Documentation/Changes |    7 +++----
> >  1 files changed, 3 insertions(+), 4 deletions(-)
> >
> > --- linux-2.6.14-rc3-git5-orig/Documentation/Changes	2005-10-03 21:54:50.000000000 +0200
> > +++ linux-2.6.14-rc3-git5/Documentation/Changes	2005-10-05 22:35:44.000000000 +0200
> > @@ -31,7 +31,7 @@
> >  Eine deutsche Version dieser Datei finden Sie unter
> >  <http://www.stefan-winter.de/Changes-2.4.0.txt>.
> >
> > -Last updated: October 29th, 2002
> > +Last updated: October 05th, 2005
> >
> >  Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
> >
> > @@ -139,9 +139,8 @@
> >  Ksymoops
> >  --------
> >
> > -If the unthinkable happens and your kernel oopses, you'll need a 2.4
> > -version of ksymoops to decode the report; see REPORTING-BUGS in the
> > -root of the Linux source for more information.
> > +With a 2.4 kernel you need ksymoops to decode a kernel Oops message. With
> > +2.6 kernels ksymoops is no longer needed and should not be used.
> >
> >  Module-Init-Tools
> >  -----------------
>
> OK, but what should I use then with 2.6??
> And since when is ksymoops not usable with it?
> I have reported quite a few times here, alaways with 2.6.x and nobody said anything about it...

You should just enable CONFIG_KALLSYMS so that the kernel can
report (decode) the symbols with the oops message.

Yes, ksymoops will still work, but it should only be used if
the kernel was not configured with CONFIG_KALLSYMS, and some
people say that the kernel oops + symbols are better than
the ksymoops output.  I haven't compared them so can't say.

-- 
~Randy
