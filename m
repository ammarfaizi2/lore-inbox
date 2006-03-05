Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWCEHoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWCEHoW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 02:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbWCEHoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 02:44:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17572 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751786AbWCEHoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 02:44:21 -0500
Date: Sun, 5 Mar 2006 02:43:55 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: norsk5@xmission.com, dthompson@linuxnetworx.com
Subject: edac slab corruption.
Message-ID: <20060305074355.GA3151@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, norsk5@xmission.com,
	dthompson@linuxnetworx.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmmod e752x_edac edac_mc
Wait a few seconds...

EDAC MC0: Removed device 0 for "e752x_edac" E7525: PCI 0000:00:00.0
Slab corruption: start=ffff81003fc5a000, len=4096

Call Trace: <ffffffff8017bcab>{check_poison_obj+121}
       <ffffffff802028a8>{kobject_uevent+676} <ffffffff8017be34>{cache_alloc_debugcheck_after+48}
       <ffffffff802028a8>{kobject_uevent+676} <ffffffff8017dd52>{__kmalloc_track_caller+301}
       <ffffffff802db731>{__alloc_skb+97} <ffffffff80202701>{kobject_uevent+253}
       <ffffffff802028a8>{kobject_uevent+676} <ffffffff80201fd6>{kobject_unregister+14}
       <ffffffff8026f273>{bus_remove_driver+126} <ffffffff8027004a>{driver_unregister+9}
       <ffffffff8020f4a8>{pci_unregister_driver+16} <ffffffff8014ec37>{sys_delete_module+551}
       <ffffffff8010dbdc>{syscall_trace_enter+156} <ffffffff8010a91c>{tracesys+209}
0f0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b

		Dave



-- 
http://www.codemonkey.org.uk
