Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSHIV7p>; Fri, 9 Aug 2002 17:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSHIV7p>; Fri, 9 Aug 2002 17:59:45 -0400
Received: from waste.org ([209.173.204.2]:4073 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316204AbSHIV7o>;
	Fri, 9 Aug 2002 17:59:44 -0400
Date: Fri, 9 Aug 2002 17:03:25 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: klibc development release
In-Reply-To: <aivdi8$r2i$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208091651230.836-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Aug 2002, H. Peter Anvin wrote:

> Okay, I'm starting to have enough guts about this to release for
> testing...
>
> klibc is a tiny C library subset intended to be integrated into the
> kernel source tree and being used for initramfs stuff.  Thus,
> initramfs+rootfs can be used to move things that are currently in
> kernel space, such as ip autoconfiguration or nfsroot (in fact,
> mounting root in general) into user space.

Remind me why we'd want this in the kernel source tree when we don't even
have modutils there? Or a real bootloader? There is no requirement that
the kernel must be able to build a bootable image with ip autoconf and
nfsroot, etc. without using external tools. A minimal 'parse command line
to mount root and call real init' might be nice, but mostly as an
example, like the example watchdog code.

I think a better way to go is to simply roll an initbootutils.tar.gz,
point to it in the kernel CHANGES, etc., start pulling stuff into it, and
people will catch on in no time.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

