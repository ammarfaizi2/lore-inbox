Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131717AbRBMOdB>; Tue, 13 Feb 2001 09:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbRBMOcw>; Tue, 13 Feb 2001 09:32:52 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:41872 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131717AbRBMOck>; Tue, 13 Feb 2001 09:32:40 -0500
Date: Tue, 13 Feb 2001 15:32:21 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Support for maximal supported mode
Message-ID: <20010213153221.B472@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,
hi lkml,

I need to add support for a maximum transfer mode selection on
drives and channels.

Reason: I have an ata flash disk as boot & root disk, that can
   only sucessfully do pio2 and it takes several minutes (5-10)
   until it will use pio2. This is not acceptable for embedded
   use.

I would like to add sth. like:

hda=udma2,sdma0,pio2

or 

ide0=udma0


To say, that this device should only be allowed to use these
modes (or worse according to the mode selection list).

I'm just afraid that I'll not be competent enough to implement
the sequence right (for setting it safely, without data
corruption).

Hope I can get some hints about some open pitfalls while
implementing it straightforward just using set_transfer in a
manner seen by ioctl.

And I would like to know the stage, at which I could should start
applying this setting (since parsing is before ide is set up).

Many Thanks in Advance

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
