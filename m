Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSKUN0T>; Thu, 21 Nov 2002 08:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSKUN0T>; Thu, 21 Nov 2002 08:26:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46570 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266731AbSKUN0S>; Thu, 21 Nov 2002 08:26:18 -0500
Date: Thu, 21 Nov 2002 14:33:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: New kconfig: Please add define_*
Message-ID: <20021121133320.GD18869@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

one thing that easily leads to errors is that the difference between
e.g. bool and define_bool is less obvious than before (it's no longer
explicitely stated). If there's no string behind the bool and no
"prompt" line it's now treated as define_bool. I've already found two
places in sound/oss/Kconfig where this was missing accidentially. Could
you add explicite define_* back to the config language and let the
program quit with an error if there's e.g. a define_bool with a string
or prompt line or a bool without a string or prompt line?

I know this requiress a conversion of several Kconfig files but
considering that this might prevent some confusion in the future I think
it's worth it.

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

