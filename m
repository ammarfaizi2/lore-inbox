Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUIYToQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUIYToQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269402AbUIYToQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:44:16 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:26808 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S269399AbUIYToO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:44:14 -0400
Date: Sat, 25 Sep 2004 21:40:01 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@oss.sgi.com
Cc: jgarzik@pobox.com, Jon Mason <jdmason@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: 8139C+/8169 and suspend mode
Message-ID: <20040925194000.GA11363@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have positive experience with suspend mode on the aforementionned
chipset ?

Rationale: Jon noticed that the r8169 driver did not correctly set the dirty
Rx ring index when the driver tries to reset the chipset (rtl8169_hw_start)
after a Tx timeout recovery. The chipset is told where the Tx/Rx rings start
but the software driver works with a badly inaccurate (rx_cur, rx_dirty) pair.

If I am not mistaken, the same pattern applies to the resume function in the
r8169 driver and in the 8139cp driver. 

So, despite me thinking that the poor thing is in a bad state, is there
anybody who actually succeeds using it ?

--
Ueimor
