Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTAOLgM>; Wed, 15 Jan 2003 06:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbTAOLgM>; Wed, 15 Jan 2003 06:36:12 -0500
Received: from tomts19.bellnexxia.net ([209.226.175.73]:56561 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S266210AbTAOLgL>; Wed, 15 Jan 2003 06:36:11 -0500
Date: Wed, 15 Jan 2003 06:44:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: display bug in "make xconfig" in 2.5.58
Message-ID: <Pine.LNX.4.44.0301150638170.24623-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (aside:  i do realize that the "make xconfig" graphical
config screen doesn't represent the actual, underlying logistics
for kernel configuration, so i'm going to spend more time
concentrating on the underlying kbuild language.  but here's
a fairly obvious flaw in make xconfig anyway.)

  "make xconfig" will not display simple config entries at
the top menu level.

  granted, at the moment, there *are* none of these, but if
you examine arch/i386/Kconfig, it's clear that such things are
at least possible -- X86, MMU, SWAP and so on.  (i deduce that,
if a config entry has no label on its type attribute, it is
not to be displayed, right?)

  if you add a bogus label to the "bool" line for, say, the
X86 entry, that selection appears properly as a checkbox in
"make menuconfig", but is never displayed for "make xconfig".

rday

p.s.  and, no, i don't know enough about Qt to devise a patch
for this.  some day, maybe ...

