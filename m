Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUKRSOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUKRSOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUKRSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:12:06 -0500
Received: from mail17.bluewin.ch ([195.186.18.64]:27356 "EHLO
	mail17.bluewin.ch") by vger.kernel.org with ESMTP id S261856AbUKRSKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:10:46 -0500
Date: Thu, 18 Nov 2004 19:10:45 +0100
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: VIA Rhine WOL
Message-ID: <20041118181045.GC28972@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got quite a few reports regarding WOL and via-rhine. Here's some
information so people can find it:

Rhine hardware can often do WOL without any support from the operating
system, i.e. the hardware will wake-up upon receiving a magic packet
even if you have no OS installed. That's meant for legacy OSes like DOS.

A WOL-aware OS has a more fine-grained control over Rhine WOL. For one,
it can turn WOL off. It can also configure the type of events that will
wake the system.

The via-rhine code has changed in the 2.6.9/2.6.10 time frame: Legacy
WOL is turned off (mostly), so it will not work unless you explicitly
tell the driver to enable WOL. You can do this using ethtool(8).

If WOL used to work with your Rhine hardware and now all of a sudden
doesn't, check first if you enabled WOL using ethtool.

Roger
