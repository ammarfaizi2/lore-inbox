Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVGVDql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVGVDql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVGVDql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:46:41 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:5559 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261943AbVGVDqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:46:39 -0400
Date: Fri, 22 Jul 2005 05:41:35 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: fastboot, diskstat
Message-ID: <20050722034135.GA21201@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I'm currently at OLS and presented http://ds9a.nl/diskstat yesterday, which
also references your ancient 'fboot' program.

I've also done experiments along those lines, and will be doing more of them
soon. 

You mention it was a waste of time, do you recall if that meant:

1) that the total time for prefetching + actual boot was only 10% shorter,
but that the actual booting did not (significantly) touch the disk?

2) that on actual boot there would still be a lot of i/o

?

Regarding 1), in my own experiments I failed to convince the kernel to
actually cache the pages I touched, I wonder if some sequential-read
detection kicked in, the one that prevents entire cd's being cached.

For my next attempt I'll try to actually lock the pages into memory.

Also, regarding the directory entries, are they accessed via the buffer
cache? Iow, would reading blocks which can't be mapped to files directly via
/dev/hda be useful?

Thanks!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
