Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWAEITe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWAEITe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932939AbWAEITe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:19:34 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51143 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S932601AbWAEITd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:19:33 -0500
Date: Thu, 5 Jan 2006 09:19:29 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: linux-kernel@vger.kernel.org
Subject: heads up: Ubuntu Breezy GCC 4.0.2-prerelease miscompiles 2.6.15 with -Os
Message-ID: <20060105081928.GA13722@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For Ubuntu and perhaps other pre-release shipping distribution users:

If you get errors like:
# ip route add default via 10.0.0.12
RTNETLINK answers: Network is unreachable

for no good reason, and you can't delete any routes either, you may be
compiling your kernel optimized for size (CONFIG_CC_OPTIMIZE_FOR_SIZE),
which is triggering a bug in your gcc 4.0.2 pre-release, or at a stretch, a
bug in the kernel.

The fix is to either turn off optimization for size ("-Os"), or to compile
with a real gcc 4.0.2 release and not a pre-release.

For more details see
http://marc.theaimsgroup.com/?l=linux-netdev&m=113641427215320&w=2 and
http://marc.theaimsgroup.com/?l=linux-netdev&m=113641859718902&w=2 and
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=322723

I'll be heading to the ubuntu bug tracker to see if this problem is there
already.

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
