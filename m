Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbWGIGtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWGIGtV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 02:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbWGIGtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 02:49:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:40829 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161099AbWGIGtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 02:49:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=oDyQ9Al6PoWaH0/ocWqjlvIymgbMODaNAlsP/k7RhV0znlvFRp2sA+lRlAwrQ4mnMfp0B0jmKxatI9vEpWZydfxI3U2Rx65QIXN9e1KihQhH8KJsbKzIECyQuK2PkWCHB9yUNBjMRm5/zDXL/rujXiTUUfWTsyRCv776EGHt83Q=
Message-ID: <787b0d920607082349h59ec36f7nc477e3cc9f9b6c77@mail.gmail.com>
Date: Sun, 9 Jul 2006 02:49:19 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org, device@lanana.org
Subject: devices.txt errors
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Major 216 was ttyUB%d (looks normal), but is now rfcomm%d instead?
The description claims that the device is a tty, yet it no longer
has a tty name?

Char major 204, the low-density serial ports, has some
sort of problem with the /dev/ttyCPM%d devices. Depending
on how I read things, there are 2, 4, or 6 of these.

Minors claimed: 46, 47
Minors available: 46, 47, 48, 49
Names claimed:  0, 1, 2, 3, 4, 5
The description:  0, 1, 2, 3, 4, 5

Here it is in context:

44 = /dev/ttyMM0               Marvell MPSC - port 0
45 = /dev/ttyMM1               Marvell MPSC - port 1
46 = /dev/ttyCPM0              PPC CPM (SCC or SMC) - port 0
   ...
47 = /dev/ttyCPM5              PPC CPM (SCC or SMC) - port 5
50 = /dev/ttyIOC0              Altix serial card
   ...
81 = /dev/ttyIOC31             Altix serial card
82 = /dev/ttyVR0               NEC VR4100 series SIU
83 = /dev/ttyVR1               NEC VR4100 series DSIU

Less serious:

Major 78 and major 112 claim the same name.

Some names, like "/dev/iseries/vtty%d", are too damn big.
Keeping things to "/dev/tty?????" would be appreciated.

Last I checked, ttyD%d didn't match the code.
