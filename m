Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWEQOXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWEQOXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 10:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbWEQOXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 10:23:42 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:38409 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932568AbWEQOXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 10:23:42 -0400
Date: Wed, 17 May 2006 16:23:38 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Cc: Valdis.Kletnieks@vt.edu, linux cbon <linuxcbon@yahoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060517142338.GB54677@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Panagiotis Issaris <takis@lumumba.uhasselt.be>,
	Valdis.Kletnieks@vt.edu, linux cbon <linuxcbon@yahoo.fr>,
	linux-kernel@vger.kernel.org
References: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com> <200605171319.k4HDJwhv015404@turing-police.cc.vt.edu> <446B2EDE.7060000@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446B2EDE.7060000@lumumba.uhasselt.be>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 04:10:38PM +0200, Panagiotis Issaris wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
> >On Wed, 17 May 2006 14:39:37 +0200, linux cbon said:
> >
> > 
> >
> >>If we have a new window system, shall all applications
> >>be rewritten ?
> >>   
> >>
> >
> >No.  /bin/cat and /bin/ls will survive unscathed.  However, if you
> >have a graphical application, it will need reworking.  That's a LOT
> >of code.
> > 
> >
> Wouldn't porting GTK+ and Qt be enough for the majority
> of the graphical applications?

You'll need OpenGL/GLX and SDL too to stand a chance.

And in any case, porting gtk+ includes porting gdk, and gdk isn't much
more than a very thin layer over libX11 with some added functionality.
So in practice it is a better idea to have a libX11-compatible API
(and if possible ABI), which will give you gdk/gtk/Qt/Motif for "free"
(not GL/SDL though), and then change gtk/Qt where appropriate to use
your own features.

  OG.
