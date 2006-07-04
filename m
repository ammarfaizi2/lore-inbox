Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWGDA2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWGDA2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWGDA2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 20:28:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49414 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751334AbWGDA2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 20:28:08 -0400
Date: Tue, 4 Jul 2006 02:28:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: -git: strange dependency for EMBEDDED6xx
Message-ID: <20060704002806.GE26941@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c5d56332fd6c2f0c7cf9d1f65416076f2711ea28 contained the following:

 config EMBEDDED6xx
        bool "Embedded 6xx/7xx/7xxx-based board"
-       depends on PPC32 && BROKEN
+       depends on PPC32 && (BROKEN||BROKEN_ON_SMP)

This looks very strange.

This dependency is equivalent to
	depends on PPC32 && SMP=n

Was this the intention?
Or what else was the intention?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

