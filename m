Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWEYQfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWEYQfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 12:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWEYQfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 12:35:31 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:13000 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965201AbWEYQfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 12:35:30 -0400
Date: Thu, 25 May 2006 11:35:25 -0500
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: PCI reset using x86 or x86-64 BIOS calls?
Message-ID: <20060525163524.GV25867@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've go a newbie x86 BIOS question:  is there a BIOS function that 
can be called to reset a PCI device? (By "reset a device" I mean
raise the #RST PCI signal line to electrical high for 1.5 seconds).
I know that BIOS does this during a soft reboot, but I was wondering
if there's a stand-alone function for doing this while the system is up
and running.

This question ame up during conversations about kexec. When kexec is
used to get out from under a crashed system, the PCI devices are 
typically in some unknown state, and need to be brought to heel. 
It seems to me that a brute-force reset would be a particularly 
straightforward way of doing this.

--linas
