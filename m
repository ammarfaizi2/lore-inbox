Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWDXRR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWDXRR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWDXRR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:17:27 -0400
Received: from waste.org ([64.81.244.121]:2956 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750837AbWDXRR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:17:26 -0400
Date: Mon, 24 Apr 2006 12:14:28 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Ketchup 0.9.7 released
Message-ID: <20060424171428.GF15445@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ketchup 0.9.7 is available at:

 http://selenic.com/ketchup/

The latest version includes several important bugfixes including a
safety check that avoids accidentally unpacking entire kernels in
directories that aren't empty.

Ketchup is an extremely handy tool for doing various things with
kernels. For example:

$ ketchup -s 2.6            # find the latest kernel version
2.6.16.9
$ ketchup -d linux 2.6      # install it
Creating target directory linux
None -> 2.6.16.9
Unpacking linux-2.6.14.tar.bz2
Applying patch-2.6.15.bz2
Applying patch-2.6.16.bz2
Downloading patch-2.6.16.9.bz2
[...]
Downloading patch-2.6.16.9.bz2.sign
[...]
Verifying signature...
[...]
Applying patch-2.6.16.9.bz2
$ cd linux
$ make kernelversion
Makefile:476: .config: No such file or directory
2.6.16.9
$ ketchup 2.6-mm   # switch to the latest -mm kernel
2.6.16.9 -> 2.6.17-rc1-mm3
Applying patch-2.6.16.9.bz2 -R
Applying patch-2.6.17-rc1.bz2
Downloading 2.6.17-rc1-mm3.bz2
[...]
Downloading 2.6.17-rc1-mm3.bz2.sign
[...]
Verifying signature...
[...]
Applying 2.6.17-rc1-mm3.bz2

It's also useful for automating tasks, for instance downloading
the latest broken-out -mm patches:

$ wget -c `ketchup -u 2.6-mm | sed "s/.bz2/-broken-out.tar.bz2/"`

(It's also good on fries.)

-- 
Mathematics is the supreme nostalgia of our time.
