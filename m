Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267888AbUGWSzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267888AbUGWSzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUGWSzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:55:14 -0400
Received: from waste.org ([209.173.204.2]:56448 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267888AbUGWSzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:55:06 -0400
Date: Fri, 23 Jul 2004 13:55:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] ketchup 0.8
Message-ID: <20040723185504.GJ18675@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ketchup is a script that automatically patches between kernel
versions, downloading and caching patches as needed, and automatically
determining the latest versions of several trees. Available at:

 http://selenic.com/ketchup/ketchup-0.8

New in this version by popular demand:

- falls back to .gz files if .bz2 files aren't available
- can find BK snapshots in old/ directories
  (aka the jgarzik memorial hack)
- option to rename directories to linux-<v> after update
- can read default options from KETCHUP_OPTS

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
Mathematics is the supreme nostalgia of our time.
