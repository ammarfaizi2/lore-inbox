Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVCWAiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVCWAiP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 19:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCWAiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 19:38:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60686 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262660AbVCWAiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 19:38:09 -0500
Date: Wed, 23 Mar 2005 01:38:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kraxel@bytesex.org
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: drivers/media/video/bt819.c: bt819_init: wrong array indexing
Message-ID: <20050323003808.GX1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found the following bug in array indexing in the 
function bt819_init in drivers/media/video/bt819.c:

        init[0x19*2-1] = decoder->norm == 0 ? 115 : 93;

I don't know whether the other array indexes in this function are 
correct, but this is definitely wrong:
It indexes element 49 wile only the elements 0-43 are available.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

