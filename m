Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUGVDWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUGVDWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 23:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266685AbUGVDWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 23:22:40 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:60082 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S266684AbUGVDWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 23:22:39 -0400
Message-ID: <40FF33DE.6010307@att.net>
Date: Wed, 21 Jul 2004 23:26:22 -0400
From: Peter Santoro <psantoro@att.net>
Reply-To: psantoro@att.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.26 oops (maybe solved)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After trying many h/w and s/w configurations, I've apparently isolated 
my instability issues to using the following the linux kernel highmem 
options: CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y, CONFIG_HIGHMEMIO=y.  I 
have 1GB ram, so maybe one of my dimms is bad or maybe there's a highmem 
bug in the 2.4.X kernel.

The crashes in my previous emails today were due to using the latest 
alsa modules (loaded, but not used by any application) with a HIGHMEM 
enabled kernel.  I appear to have no problem using alsa when HIGHMEM is 
disabled.  Apparently, I'm not the only one having problems with alsa 
and highmem 
(http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg13918.html).

I would be willing to work with a kernel developer to better isolate 
this problem and test a patch.

Thank you,


Peter Santoro
