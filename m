Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbUBPUUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUBPUUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:20:49 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:43190 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S265839AbUBPUUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:20:47 -0500
Date: Mon, 16 Feb 2004 21:20:43 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040216202043.GD17015@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <Pine.LNX.4.58.0402161141140.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161141140.30742@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 11:48:35AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> works on the raw byte sequence and isn't confused). Basically accept the
> fact that UTF-8 strings can contain "garbage", and don't try to fix it up.

But you are wrong, UTF-8 strings never contain garbage. UTF-8 is
well-defined and is always proper UTF-8. It's a tautology.

The evry idea of "UTF-8 with garbage in it" doesn't make sense.

> And no, I'm not claiming that it's wonderfully clean and that we should
> all love it.

It's also a totally useless idiom...

> And it largely works today.
> 		Linus

On ascii-only-systems, it works fine. My system is largely ascii-only,
with only very few filenames (japanese and german ones mostly) in
UTF-8. Sometimes in EUC-JP, but that's a bug in rar.

It also works fine in single-user environments where the user just forces
everything to be in her locale. It does fail miserably on multi-user
systems. It does fail miserably in ISO-C's locale model. It does fail
miserably with gnu shellutils, fileutils and most other apps.

It fails, because it's not at all well supported by the kernel.

Claiming that it largely works today is simply not true for most
non-ascii-users (which increasingly includes the US).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
