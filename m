Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbUA0GcW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUA0GcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:32:22 -0500
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:2829 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262598AbUA0GcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:32:20 -0500
Date: Mon, 26 Jan 2004 22:47:57 -0600
From: Glenn Johnson <glennpj@charter.net>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 oops with X
Message-ID: <20040127044757.GA5400@gforce.johnson.home>
References: <20040123061927.GA7025@gforce.johnson.home> <20040122231814.149c8e8d.akpm@osdl.org> <1074848612.23073.81.camel@imladris.demon.co.uk> <20040123011158.665ad574.akpm@osdl.org> <1074850572.23073.83.camel@imladris.demon.co.uk> <20040123014453.775a0ba7.akpm@osdl.org> <20040123170504.GA21623@node1.cluster.srrc.usda.gov> <20040123215624.GX23765@srv-lnx2600.matchmail.com> <20040124043326.GB14701@gforce.johnson.home> <20040127040446.GA2445@srv-lnx2600.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127040446.GA2445@srv-lnx2600.matchmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 08:04:46PM -0800, Mike Fedyk wrote:

> On Fri, Jan 23, 2004 at 10:33:27PM -0600, Glenn Johnson wrote:
>
> > On Fri, Jan 23, 2004 at 01:56:24PM -0800, Mike Fedyk wrote:
> >
> > > How far does it get through, and at what point in X startup does
> > > the kernel oops?
> >
> > I would say fairly early on but I do not know how to quantify that.
>
> Post your log file, and show where in the log the oops occours...

Okay, below is the XFree log file.  It is truncated at the point where
the oops occurs.  I sent an e-mail to Andrew confirming that backing out
sysfs-class-10-vc.patch fixes the problem for me.

---begin X log for kernel oops---

XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.1-mm5 i686 [ELF] 
Build Date: 20 January 2004
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Mon Jan 26 22:33:10 2004
(==) Using config file: "/etc/X11/XF86Config"
(==) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(==) Keyboard: CustomKeycode disabled
(**) FontPath set to "unix/:-1"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(**) ModulePath set to "/usr/X11R6/lib/modules"
(++) using VT number 8

---end X log for kernel oops

The VT number it tries to use jumps around.  Sometimes it is VT10, VT11,
etc.  It should be using VT7 however.

Cheers,

Glenn
