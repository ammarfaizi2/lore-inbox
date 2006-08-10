Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161438AbWHJQYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161438AbWHJQYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161435AbWHJQYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:24:14 -0400
Received: from mxsf38.cluster1.charter.net ([209.225.28.165]:30898 "EHLO
	mxsf38.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161429AbWHJQYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:24:11 -0400
X-IronPort-AV: i="4.08,111,1154923200"; 
   d="scan'208"; a="2046197113:sNHT49841400"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17627.23974.848640.278643@stoffel.org>
Date: Thu, 10 Aug 2006 12:24:06 -0400
From: "John Stoffel" <john@stoffel.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
In-Reply-To: <Pine.LNX.4.64.0608101519560.6762@scrub.home>
References: <1155172843.3161.81.camel@localhost.localdomain>
	<20060809234019.c8a730e3.akpm@osdl.org>
	<Pine.LNX.4.64.0608101302270.6762@scrub.home>
	<44DB203A.6050901@garzik.org>
	<Pine.LNX.4.64.0608101409350.6762@scrub.home>
	<44DB25C1.1020807@garzik.org>
	<Pine.LNX.4.64.0608101429510.6762@scrub.home>
	<44DB27A3.1040606@garzik.org>
	<Pine.LNX.4.64.0608101459260.6761@scrub.home>
	<44DB3151.8050904@garzik.org>
	<Pine.LNX.4.64.0608101519560.6762@scrub.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Roman" == Roman Zippel <zippel@linux-m68k.org> writes:

Roman> If you force everyone to use 64bit sector numbers, I don't
Roman> understand how you can claim "still working just fine on
Roman> 32bit"?  At some point ext4 is probably going to be the de
Roman> facto standard, which very many people want to use, because it
Roman> has all the new features, which won't be ported to ext2/3. So I
Roman> still don't understand, what's so wrong about a little tuning
Roman> in both directions?

The problem as I see it, is that you want extents, but you don't want
the RAM/DISK/ROM penalty of 64bit blocks, since embedded devices won't
ever go past the existing ext3 sizes, right?

Is this a more clear statement of what you want?

So the next question I have, and this is for the ext3/ext4 developers,
is whether ext4 will have a feature flag to mark whether the
filesystem has 64bit sector numbers or not.  If so, then I think Roman
will be fine.  

Me, I think going all 64bit is the way to go, since it moves the
limits so high up, that we probably won't hit them in a serious way
for another 20 years in terms of disk space addressing needs, sorta
like how 64bit CPUs have really moved out the RAM constraints as
well.  

Now sure, there are people who will hit those limits, but they're in a
very very small minority with the money to pay for a large large
electric bill to just run a system that big.  For now.

John
