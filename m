Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161548AbWJKWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161548AbWJKWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161550AbWJKWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:07:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53944 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161548AbWJKWH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:07:27 -0400
Date: Wed, 11 Oct 2006 23:07:26 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] m68k: more workarounds for recent binutils idiocy
Message-ID: <20061011220726.GE29920@ftp.linux.org.uk>
References: <E1GXlNt-0004Xc-Fi@ZenIV.linux.org.uk> <Pine.LNX.4.64.0610112319320.7817@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610112319320.7817@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 11:30:05PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 11 Oct 2006, Al Viro wrote:
> 
> > cretinous thing doesn't believe that (%a0)+ is one macro argument and
> > splits it in two; worked around by quoting the argument...
> 
> NAK, this is a bug in binutils and is fixed there already (at least in 
> CVS).

OK...  Would be nice to find out which versions are broken (that's
Documentation/Changes fodder), I'll see to it.

What about the first problem?  Even current binutils CVS treats
foo.bar as a single identifier, and doesn't recognize it as invocation
of foo with .bar as the first argument.  Any objections against the
first patch?
