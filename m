Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUFGVDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUFGVDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFGVDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:03:23 -0400
Received: from world.rdmcorp.com ([204.225.180.10]:38399 "EHLO
	mailhost.rdmcorp.com") by vger.kernel.org with ESMTP
	id S265057AbUFGVDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:03:18 -0400
Date: Mon, 7 Jun 2004 17:00:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: how to configure/build a kernel in a separate directory?
Message-ID: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (i originally posted this to the "make" mailing list, but i figured 
someone here *must* have done this before.)

  is there an easy way to configure/build one or both of a 2.4 and 2.6 
kernel in a totally separate directory from the source directory itself?

  i'd like to have a totally pristine ("make mrproper"ed) source tree,
write-protected, readable by all, so that several developers can 
independently configure and build their own kernels without stepping on 
each other.  currently, they all check out their own copy of the source 
via CVS, which starts to take up a lot of space.

  obviously, it would be great if they could all set up some kind of build 
structure where they could do their own configuration and build in their 
personal work directories, so that *all* generated results (header files,
object files, etc.) are placed in their work directory -- nothing should
be generated in the kernel source tree itself.

  i'm suspecting that, if there are solutions, they will be different from 
2.4 to 2.6, so i'll take whatever solutions i can get.  others have 
suggested using gnu make in combination with "VPATH", but i'm not sure 
that's going to work, as VPATH deals strictly with pre-requisites in other 
directories, not executable programs like scripts.

rday

p.s.  it gets more exciting since developers might want to create a 
downloadable image combination of a kernel and root filesystem, so they
might want to have independent copies of 
arch/<arch>/boot/images/ramdisk.image.gz, but i'll fight with that when
the time comes.
