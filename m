Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVBQTQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVBQTQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVBQTMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:12:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14343 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262336AbVBQTKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:10:38 -0500
Date: Thu, 17 Feb 2005 20:10:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/eeprom.h
Message-ID: <20050217191030.GE1772@stusta.de>
References: <20050217144825.GJ24808@stusta.de> <4214E419.5060807@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214E419.5060807@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 01:36:09PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch kills include/linux/eeprom.h .
> >
> >Rationale:
> >- it's only used by one single driver
> >- most of this file are non-inline and non-static functions (sic)
> >
> >This patch moves all required contents of this file into ns83820.c and 
> >removes include/linux/eeprom.h (and makes setup_ee_mem_bitbanger 
> >static).
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I would rather update other drivers to use it :)

You mean you want to:
- move the code from the header file to a .c file
- implement the write method that is currently empty
- add uses of the eeprom code (note that even ns83820.c used only
  one of the 7 functions in eeprom.h).

Noone did any of these during the more than 3 years eeprom.h already 
exists...

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

