Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbVAPEeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbVAPEeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVAPEeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:34:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50949 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262423AbVAPEeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:34:00 -0500
Date: Sun, 16 Jan 2005 05:33:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: anton@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: ppc64 xics.c: what is smp_threads_ready exactly used for?
Message-ID: <20050116043356.GM4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

during a cleanup, I stumbled upon the following:


arch/ppc64/kernel/smp.c (in 2.6.11-rc1-mm1) says:

        /* XXX fix this, xics currently relies on it - Anton */
        smp_threads_ready = 1;


arch/ppc64/kernel/xics.c is the _only_ place in the whole kernel where 
smp_threads_ready is actually used, and this is the _only_ place where 
smp_threads_ready ever changes it's value on ppc64.

I have to admit I'm a bit lost in the sequence of function calls on 
ppc64. Is it possible to make any assumptions about the ordering of the 
assignment and the usage of smp_threads_ready?


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

