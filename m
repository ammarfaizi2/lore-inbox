Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRH0WKP>; Mon, 27 Aug 2001 18:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269412AbRH0WKF>; Mon, 27 Aug 2001 18:10:05 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:62952 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S269395AbRH0WJt>; Mon, 27 Aug 2001 18:09:49 -0400
Date: Mon, 27 Aug 2001 18:10:05 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Bug or feature?
Message-ID: <Pine.GSO.4.33.0108271736500.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my dangerous mode of "if it's presented to me, compile it", I've noticed
alot of junk being presented as a buildable option under the wrong arch.

For example, the Sparc64 and ARM MTD Map drivers are selectable from an
x86 build.  Some might say this is a shell bug, but at any rate, dep_*
don't function correctly (read: as one would expect) in the cases where
the deps are not defined.

For:
  dep_tristate '  Sun Microsystems userflash support' CONFIG_MTD_SUN_UFLASH $CONFIG_SPARC64
$CONFIG_SPARC64 is null and this doesn't appear to the shell function as an
arg.  Thus, it's presented as a selectable (tho' not compilable) option.

The same is visable for CONFIG_MTD_SA1100 and CONFIG_MTD_DC21285 (ARM).

Options:
 1) Don't select things that aren't in your machine/arch.
    (Translation: "Live with it.")
 2) Quote all the options.
    (ewww.)
 3) Fix the function(s).

--Ricky


