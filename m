Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWJMQoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWJMQoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWJMQoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:44:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29645 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751155AbWJMQoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:44:01 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Message-Id: <20061013143516.15438.8802.sendpatchset@linux.site>
Subject: [rfc] buffered write deadlock fix
Date: Fri, 13 Oct 2006 18:43:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches attempt to fix the buffered write
locking problems. 

While looking at this deadlock, it became apparent that there are
several others which are equally bad or worse. It will be very
good to fix these.

I ceased to become an admirer of this problem when it stopped my
pagefault vs invalidate race fix from being merged!

Review and comments would be very nice. Testing only if you don't
value your data. I realise all filesystem developers are busy
solving the 10TB fsck problem now, but if you could please take a
minute to look at the fs/ changes, and also ensure your
filesystem's prepare and commit_write handlers aren't broken.

Sorry for the shotgun mail. It is your fault for ever being
mentioned in the same email as the buffered write deadlock ;)

Thanks,
Nick

--
SuSE Labs

