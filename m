Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbUCKGPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbUCKGPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 01:15:35 -0500
Received: from ip214-49.coastside.net ([207.213.214.33]:26341 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S262753AbUCKGPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 01:15:32 -0500
Mime-Version: 1.0
Message-Id: <p0610038abc75b353d82c@[192.168.0.3]>
Date: Wed, 10 Mar 2004 22:15:24 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: nmi oddity
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running smp 2.4.9 (don't ask) with updated nmi logic on a Dell 650 
(UP P4), I notice that NMI is running at about 1.08 Hz. Per the 
kernel logic, it should be running at HZ (100) Hz.

I'm using NMI_LOCAL_APIC. check_nmi_watchdog() never gets called in 
this mode in an smp kernel, near as I can tell, so nmi_hz never gets 
set to 1.

What's going on? Or does anyone else see it?
-- 
/Jonathan Lundell.
