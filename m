Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUBCUx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUBCUxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:53:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266149AbUBCUxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:53:31 -0500
Date: Tue, 3 Feb 2004 20:53:30 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools/udev and module auto-loading
Message-ID: <20040203205330.GZ21151@parcelfarce.linux.theplanet.co.uk>
References: <20040203010224.4CF742C261@lists.samba.org> <1075830486.7473.32.camel@nosferatu.lan> <20040203193351.GY21151@parcelfarce.linux.theplanet.co.uk> <1075841233.7473.54.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075841233.7473.54.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 10:47:13PM +0200, Martin Schlemmer wrote:
> On Tue, 2004-02-03 at 21:33, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> > On Tue, Feb 03, 2004 at 07:48:06PM +0200, Martin Schlemmer wrote:
> > > > > I guess there will be cries of murder if 'somebody' suggested that if
> > > > > a node in /dev is opened, but not there, the kernel can call
> > > > > 'modprobe -q /dev/foo' to load whatever alias there might have been?
> > 
> > Vetoed.  _Especially_ when you are checking that on "pathname prefix"
> > level - namei.c is not a place for such special-casing.
> > 
> 
> Well, I do not scratch around in there in general.  I guess the question
> is:
> 
> 1)  This this idea is Ok to make it (not patch or where it is, but the
> idea in general.

It is not.  Consider the effect of cd /dev followed by lookups.  Do you
really want a different behaviour in that case?  Ditto for use of
symlinks, yadda, yadda.
