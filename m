Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276831AbRJKUPb>; Thu, 11 Oct 2001 16:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276842AbRJKUPV>; Thu, 11 Oct 2001 16:15:21 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:60225 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276831AbRJKUPN>; Thu, 11 Oct 2001 16:15:13 -0400
Date: Thu, 11 Oct 2001 15:15:34 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Unconditional include of <linux/module.h> in aic7xxx driver
In-Reply-To: <200110112001.f9BK0vY99173@aslan.scsiguy.com>
Message-ID: <Pine.LNX.3.96.1011011150946.5934C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Justin T. Gibbs wrote:
> So, in theory I could nuke many of the remaining "#ifdef MODULE"'s?

yes.  most if not all.


> This wasn't done in the aic7xxx driver for 2.4.12.  My only concern with
> doing this is having the driver still work on older kernel versions.

Define "older" :)  Even 2.2 kernels have worked this way for a while, so
it really depends on how far you want to go back.  I think this policy
started in late 2.1.xx days IIRC.

Also, WRT older kernel compatibility, look at drivers/net/acenic.c or
the kcompat24 toolkit.  These, and other code, illustrate how to be
compatible with older kernels without loading the source code down with
ifdefs.  The basic idea is to provide a 2.4-like API on older kernels,
using macros and inline functions hidden in a compatibility header.

	Jeff



