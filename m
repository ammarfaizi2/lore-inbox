Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271892AbRHUXLH>; Tue, 21 Aug 2001 19:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271891AbRHUXKy>; Tue, 21 Aug 2001 19:10:54 -0400
Received: from dsl081-060-070.sfo1.dsl.speakeasy.net ([64.81.60.70]:13051 "EHLO
	uzo.telecoma.net") by vger.kernel.org with ESMTP id <S271890AbRHUXKs>;
	Tue, 21 Aug 2001 19:10:48 -0400
Date: Wed, 22 Aug 2001 01:39:29 +0200
From: firenza@gmx.net
To: linux-kernel@vger.kernel.org
Subject: how to page_cache.max_percent?
Message-ID: <20010822013929.E2275@telecoma.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

the following scenario:

 * kernel 2.4.9 smp
 * machine with 6GB physical memory
 * multiple processes are relying on a 3GB large data structure
   to be in memory (speed goes down the drain, when some pages 
   are swapped out)
 * not every page in this 3GB data structure is used all the time
 * this data structure is loaded from files, so initially
   i end up having 3GB of used cache (visible in vmstat)

now i start another memory intense process and discover via vmstat
the following sensible behaviour: pagecache shrinks slowly and
memory from the 3GB structure is swapped out at a faster rate...

i don't care about the pagecache, i only care about having those
3GB in memory... 

is there a way to set a maximum size for the pagecache (afaik,
page_cache.max_percent is not used)?

or can i specify to always drain the pagecache before swapping out?

cheers,
-iowa

