Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCOWCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCOWCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCOWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:01:44 -0500
Received: from levante.wiggy.net ([195.85.225.139]:17384 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261936AbVCOWAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:00:36 -0500
Date: Tue, 15 Mar 2005 23:00:31 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Cc: p_gortmaker@yahoo.com, pavel@suse.cz
Subject: rtc misses interrupts after resume
Message-ID: <20050315220031.GD29715@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com,
	pavel@suse.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my laptop to 2.6.11.3 and removed the notsc boot
option I added a fairly long time ago to see if things worked properly
without it now. It seems to work, except that after a resume I get
an awful lot of these messages:

Mar 15 09:53:04 typhoon kernel: rtc: lost some interrupts at 1024Hz.
Mar 15 09:53:06 typhoon last message repeated 103 times

and indeed looking at /proc/interrupts interrupt 8 is not getting hit.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
