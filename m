Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264167AbUDGTZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDGTZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:25:04 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:26928 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264167AbUDGTYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:24:33 -0400
Date: Wed, 7 Apr 2004 14:24:32 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407192432.GD2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407111841.78ae0021.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 11:18:41AM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > > While you're there, please add an fsync-before-closing option.
> > 
> > Easy enough.  How does this look?  Note that C_TWOBUFS ensures the
> > output buffer is getpagesize()-aligned.
> 
> Looks nice and simple.  You'll need an ext2 filesystem to test it under 2.4.

I tested against a block device.  Easier to just "swapoff /dev/hda2"
than to find space to make a new filesystem.

> Be aware that it's rather a challenge to actually get the O_DIRECT #define
> in scope under some glibc versions.  I think you need to define _GNU_SOURCE
> or something like that.

Yeah, I had to -D_GNU_SOURCE to build standalone, but coreutils'
makefile seems to do OK.

Would there be any reason to allow O_DIRECT on the read side?

-andy
