Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132883AbRDPIcP>; Mon, 16 Apr 2001 04:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132884AbRDPIby>; Mon, 16 Apr 2001 04:31:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51110 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132883AbRDPIbv>;
	Mon, 16 Apr 2001 04:31:51 -0400
Date: Mon, 16 Apr 2001 10:31:48 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200104160831.KAA196012.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, acahalan@cs.uml.edu
Subject: Re: Bug in EZ-Drive remapping code (ide.c)
Cc: Jochen.Hoenicke@informatik.uni-oldenburg.de, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From acahalan@saturn.cs.uml.edu Mon Apr 16 08:35:09 2001

    Andries.Brouwer writes:

    > What one wants is to remap access to sector 0 to sector 1,
    > and leave all other sectors alone. Thus, if someone asks
    > for sectors 0 1 2 3 4, she should get sectors 1 1 2 3 4.

    No, because then you can't write to the real first sector.
    Assuming translation is good, 1 0 2 3 4 is a better order.
    Then "dd if=/dev/zero of=/dev/hda bs=1k count=999" will get
    rid of all this crap. Otherwise, killing it is difficult.

If you use EZdrive and damage its code, then probably you
cannot boot anymore, or lose access to your data.
Killing it must be difficult.

EZdrive provides uninstall code itself, but if you really want,
boot with "hda=noremap", and then your dd command will erase
both EZdrive and your precious data.

Andries
