Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVCVVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVCVVAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVCVVAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:00:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1292 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261942AbVCVU77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:59:59 -0500
Date: Tue, 22 Mar 2005 21:59:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: drivers/pci/hotplug/cpqphp_ctrl.c: board_replaced: dead code
Message-ID: <20050322205956.GJ1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker correctly noted, that in function board_replaced in 
drivers/pci/hotplug/cpqphp_ctrl.c, the variable src always has the
value 8, and therefore much code after the

...
                        if (rc || src) {
...
                                if (rc)
                                        return rc;
                                else
                                        return 1;
                        }
...


can never be called.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

