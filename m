Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSHVUgz>; Thu, 22 Aug 2002 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSHVUgz>; Thu, 22 Aug 2002 16:36:55 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:28863 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S316789AbSHVUgz>;
	Thu, 22 Aug 2002 16:36:55 -0400
Date: Thu, 22 Aug 2002 22:39:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Jones <davej@suse.de>,
       James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: Patch for PC keyboard driver's autorepeat-rate handling
Message-ID: <20020822203942.GA5471@win.tue.nl>
References: <Pine.LNX.4.33L2.0208221153210.672-100000@ida.rowland.org> <1030037462.3090.1.camel@irongate.swansea.linux.org.uk> <20020822193743.GA5448@win.tue.nl> <1030047374.3161.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030047374.3161.60.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 09:16:14PM +0100, Alan Cox wrote:
> On Thu, 2002-08-22 at 20:37, Andries Brouwer wrote:
> > What it does for KDKBDREP is conform the text of kd.h, and I think
> > conform what m68k has done for years (but I've never seen the m68k patch).
> > Alan Stern is entirely right that the current 2.4 kernels and the
> > current kbdrate program have different ideas about what KDKBDREP does.
> 
> XFree86 assumes the existing m68k behaviour from the base m68k tree

A good pointer. And indeed,

  xc/programs/Xserver/hw/xfree86/os-support/linux/lnx_io.c

has code virtually identical to the kbdrate code (indeed, most likely
taken from kbdrate). So, it seems the kernel has to change, and
(although I have not checked it) Alan Stern's patch may be the right thing.

Andries


