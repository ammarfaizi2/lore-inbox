Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311593AbSCNLys>; Thu, 14 Mar 2002 06:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311595AbSCNLyi>; Thu, 14 Mar 2002 06:54:38 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:24329 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311593AbSCNLy0>; Thu, 14 Mar 2002 06:54:26 -0500
Date: Thu, 14 Mar 2002 12:54:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: [patch] Big IDE chipset driver update, please test!
Message-ID: <20020314125420.A20797@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After Martin Dalecki poked me to start doing something I was planning
long ago with the IDE chipset drivers, I indeed started.

And the work slowly evolved in a quite big change. Here

http://twilight.ucw.cz/ide-via-amd-piix-efar-nvidia-timing-11.diff

is a patch that (among other things):

* changes all the chipset drivers to use the new IDE mode-timing
  routines
* replaces the Intel IDE driver completely, adding support for
  PIIX3
* removes the slc90e66 Efar Victory66 driver, as that chip is
  now handled by the Intel PIIX driver
* replaces the AMD ide driver completely, adding support for
  AMD-8111 and nVidia nForce
* fixes minor bugs and cleans up stuff here and there

Please test this namely: If you have an Intel PIIX, PIIX3, ICH2 or ICH3
chip, or if you have the nVidia nForce or the Efar Victory66. I'm really
interested if it works correctly on those. 

On both the Intel and AMD chipsets the driver is expected to give
slightly (< 5%) better performance due to timing the transfers closer to
the spec.

-- 
Vojtech Pavlik
SuSE Labs
