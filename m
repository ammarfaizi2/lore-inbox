Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWAJEg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWAJEg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 23:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAJEg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 23:36:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19982 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751206AbWAJEg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 23:36:28 -0500
Date: Tue, 10 Jan 2006 05:36:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: SOFTWARE_SUSPEND: dependency on non-existing FVR symbol
Message-ID: <20060110043627.GD3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following issue in kernel/power/Kconfig was noted by
Jean-Luc Leger <reiga@dspnet.fr.eu.org>:

config SOFTWARE_SUSPEND
        bool "Software Suspend"
        depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)


The problem is that there is no FVR symbol in the kernel.

Is this a misspelling of FRV or something different?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

