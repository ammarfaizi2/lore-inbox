Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbTF3WRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbTF3WRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:17:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10917 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265918AbTF3WRp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:17:45 -0400
Subject: [PATCH SET - 0/3] lost tick fixes
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057011774.28320.340.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 15:22:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 
	This set of patches fixes up the time doubling issues seen on laptops
with speedstep as well as other systems when HZ=100 or calibrate_tsc()
wasn't precise enough. No last-minute hand-editing of the diffs were
done and I've tested each step to insure they compile and boot. ;) The
patches in the order they should be applied are:

Patch 1: rename-timer_A1
o Your cleanups to the time code. 
o Replaces your current rename-timer patch in your tree. 
o Removes dependency on lost-tick-speedset-fix. 

Patch 2: lost-tick-speedstep-fix_A1
o Detects speedstep time trouble and falls back to the PIT
o Replaces the lost-tick-speedstep-fix patch in your tree
o Adds dependency on rename-timer-A1

Patch 3: lost-tick-corner-fix_A0
o Fixes corner case where we detect an overflow between time source
reads. 
o Depends on lost-tick-speedstep-fix_A1

Please consider for inclusion in your tree.

thanks
-john


