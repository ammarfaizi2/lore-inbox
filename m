Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTB0Xpi>; Thu, 27 Feb 2003 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTB0Xpi>; Thu, 27 Feb 2003 18:45:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36114 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267322AbTB0Xph>; Thu, 27 Feb 2003 18:45:37 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Invalid compilation without -fno-strict-aliasing
Date: 27 Feb 2003 15:55:43 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3m8hv$5fh$1@cesium.transmeta.com>
References: <20030227203512.GA12623@nevyn.them.org> <Pine.LNX.4.44.0302271234530.9696-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0302271234530.9696-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> On Thu, 27 Feb 2003, Daniel Jacobowitz wrote:
> > 
> > We could work around both of these: disable the sign compare warning,
> > and use check_gcc to set a high number for -finline-limit...
> 
> Oh, both are work-aroundable, no question about it. The same way it was 
> possible to work around the broken aliasing with previous releases. I'm 
> just hoping that especially the inline thing can be resolved sanely, 
> otherwise we'll end up having to use something ugly like
> 
> 	-D'inline=inline __attribute__((force_inline))'
> 
> on every single command line..
> 

Isn't this what compiler.h is for?  If the complaint is that some
things don't include compiler.h then we may want to force it with
-include.  Better all the cruft in one file IMO.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
