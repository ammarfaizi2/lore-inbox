Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUDXVRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUDXVRh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUDXVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 17:17:37 -0400
Received: from waste.org ([209.173.204.2]:57793 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262574AbUDXVRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 17:17:35 -0400
Date: Sat, 24 Apr 2004 16:17:32 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] ketchup 0.7
Message-ID: <20040424211732.GQ28459@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ketchup is a script that automatically patches between kernel
versions, downloading and caching patches as needed, and automatically
determining the latest versions of several trees. Available at:

 http://selenic.com/ketchup/ketchup-0.7

New in this version by popular demand:

- handles empty directories:
  if you run ketchup in an empty directory, it'll search its cache for
  a tarball nearest to the version specified and unpack that before
  patching, downloading a new tarball if none is available
- uses wget if available, with resume support
- uses gpg if available (disable with -G)
- archive, kernel-url, and work directory command line parameters
- cleaned up option parsing
- elimination of more Python 2.3isms (tested against 2.1)
- support for Martin Bligh's -mjb tree

Example usage:

 $ ketchup 2.6-mm
 2.6.3-rc1-mm1 -> 2.6.5-mm4
 Applying 2.6.3-rc1-mm1.bz2 -R
 Applying patch-2.6.3-rc1.bz2 -R
 Applying patch-2.6.3.bz2
 Applying patch-2.6.4.bz2
 Applying patch-2.6.5.bz2
 Downloading 2.6.5-mm4.bz2
 Downloading 2.6.5-mm4.bz2.sign
 Verifying signature...
 gpg: Signature made Sat Apr 10 21:55:36 2004 CDT using DSA key ID 517D0F0E
 gpg: Good signature from "Linux Kernel Archives Verification Key
 <ftpadmin@kernel.org>"
 gpg:                 aka "Linux Kernel Archives Verification Key
 <ftpadmin@kernel.org>"
 owner.
 gpg: WARNING: This key is not certified with a trusted signature!
 gpg:          There is no indication that the signature belongs to the
 Primary key fingerprint: C75D C40A 11D7 AF88 9981  ED5B C86B A06A 517D 0F0E
 Applying 2.6.5-mm4.bz2

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
