Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWHBEuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWHBEuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWHBEuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:50:44 -0400
Received: from mail.suse.de ([195.135.220.2]:6533 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751165AbWHBEun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:50:43 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Subject: NFS root broken in 2.6.18-rc2-mm1
Date: Wed, 2 Aug 2006 06:50:18 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020650.18093.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI,

I tried to boot 2.6.18-rc2-mm1 on a nfsroot system with x86-64 defconfig.

Unfortunately it seems to generate lots of random EIO while reading executables 
during the startup sequence, which causes some things to break. Writing
also doesn't seem to work - it complains about EPERM for that.
Not all executables error out, but at least some.

The same setup works fine with mainline 2.6.18-rc*

-Andi
