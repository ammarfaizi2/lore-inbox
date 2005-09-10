Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVIJJUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVIJJUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 05:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVIJJUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 05:20:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41157 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750716AbVIJJUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 05:20:25 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org
Subject: NUMA mempolicy /proc code in mainline shouldn't have been merged
Date: Sat, 10 Sep 2005 11:20:18 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509101120.19236.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just noticed the ugly SGI /proc/*/numa_maps code got merged.  I argued
several times against it and I very deliberately didn't include
a similar facility when I wrote the NUMA policy code because it's a bad
idea.


- it's a lot of ugly code.
- it's basically only a debugging hack right now
- it presents lots of kernel internal information and mempolicy
internals (like how many people have a page mapped) etc.
to userland that shouldn't be exposed to this.
- the format is very complicated and the chance of bug free
userland parsers of this is near zero.
- there is no demonstrated application that needs it
(there was a theoretical usecase where it might be needed,
but there were better solutions proposed for this) 


Can the patch please be removed? 

Thanks,

-Andi
