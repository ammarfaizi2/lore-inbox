Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271108AbTHGX7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271117AbTHGX7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:59:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50882 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271108AbTHGX7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:59:08 -0400
Date: Fri, 8 Aug 2003 01:59:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: Problem multiple bool/tristate prompts
Message-ID: <20030807235905.GO16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I observed a problem with the following Kconfig snippet I tried to add
to 2.6.0-test2-mm5:

config BLK_DEV_PS2
        tristate "PS/2 ESDI hard disk support" if BROKEN_MODULAR
        bool "PS/2 ESDI hard disk support" if !BROKEN_MODULAR


Every "make *config" gives the warning

  drivers/block/Kconfig:45: prompt redefined
  drivers/block/Kconfig:45:warning: type of 'BLK_DEV_PS2' redefined from 
  'tristate' to 'boolean'

and the symbol is handled as tristate although BROKEN_MODULAR isn't
defined.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

