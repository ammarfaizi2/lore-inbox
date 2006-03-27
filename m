Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWC0FvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWC0FvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWC0FvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:51:04 -0500
Received: from ns2.suse.de ([195.135.220.15]:62131 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750718AbWC0FvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:51:01 -0500
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: dcache leak in 2.6.16-git8
Date: Mon, 27 Mar 2006 07:50:20 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603270750.28174.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A 2GB x86-64 desktop system here is currently swapping itself to death after
a few days uptime.

Some investigation shows this:

inode_cache         1287   1337    568    7    1 : tunables   54   27    8 : slabdata    191    191      0
dentry_cache      1867436 1867643    208   19    1 : tunables  120   60    8 : slabdata  98297  98297      0

Going to reboot it now.

-Andi
